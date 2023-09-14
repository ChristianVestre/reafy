import 'dart:developer';
import 'dart:async';
import 'dart:convert';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:reafy/helpers/constants.dart';
import 'package:reafy/models/user.dart';

class AuthProvider with ChangeNotifier {
  final FlutterAppAuth _appAuth = const FlutterAppAuth();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  GoogleUser googleUser = GoogleUser();
  ReafyUser reafyUser = ReafyUser();
  bool isLoggedIn = false;
  bool isLoading = false;

  Future<bool> initAuth() async {
    isLoading = true;
    final storedRefreshToken =
        await _secureStorage.read(key: REFRESH_TOKEN_KEY);
    final TokenResponse? result;
    if (storedRefreshToken == null) {
      isLoading = false;
      notifyListeners();
      return false;
    }
    print(isLoggedIn);

    final storedUser = await _secureStorage.read(key: "googleUser");
    if (storedUser == null) {
      isLoading = false;
      notifyListeners();

      return false;
    }

    print(isLoggedIn);

    try {
      // Obtaining token response from refresh token
      result = await _appAuth.token(
        TokenRequest(
          clientID(),
          redirectUrl(),
          issuer: GOOGLE_ISSUER,
          refreshToken: storedRefreshToken,
        ),
      );

      isLoggedIn = await _handleAuthResult(result);
      isLoading = false;
      notifyListeners();
      return isLoggedIn;
    } catch (e, s) {
      print('error on Refresh Token: $e - stack: $s');
      // logOut() possibly
      return false;
    }
  }

  Future<bool> login() async {
    final AuthorizationTokenRequest authorizationTokenRequest;

    try {
      authorizationTokenRequest = AuthorizationTokenRequest(
        clientID(),
        redirectUrl(),
        issuer: GOOGLE_ISSUER,
        scopes: ['email', 'profile'],
      );
// Requesting the auth token and waiting for the response

      final AuthorizationTokenResponse? result =
          await _appAuth.authorizeAndExchangeCode(
        authorizationTokenRequest,
      );
      isLoggedIn = await _handleAuthResult(result);
      print(isLoggedIn);
      isLoading = false;
      notifyListeners();
      return isLoggedIn;
    } on PlatformException {
      print("User has cancelled or no internet!");
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> logout() async {
    await _secureStorage.delete(key: REFRESH_TOKEN_KEY);
    isLoggedIn = false;
    notifyListeners();
    return isLoggedIn;
  }

  Future<bool> _handleAuthResult(result) async {
    final bool isValidResult =
        result != null && result.accessToken != null && result.idToken != null;
    if (isValidResult) {
      // Storing refresh token to renew login on app restart
      if (result.refreshToken != null) {
        await _secureStorage.write(
          key: REFRESH_TOKEN_KEY,
          value: result.refreshToken,
        );
      }

      final String googleAccessToken = result.accessToken!;

      try {
        final userInfoResponse = await http.post(
          Uri.parse(
              'https://www.googleapis.com/oauth2/v3/userinfo?access_token=${result.accessToken}'),
        );

        if (userInfoResponse.statusCode == 200) {
          final item = json.decode(userInfoResponse.body);
          googleUser = GoogleUser.fromJson(item);
          final pw = dotenv.env['SECRET_TOKEN']!;
          final key = SecretKey(pw);

          final Map data = {"userName": googleUser.name, "sub": googleUser.sub};

          final loginInfo = await http.post(
              Uri.parse('http://localhost:3000/api/login'),
              body: json.encode(data),
              headers: {
                "authorization": 'Bearer ${JWT({
                      "nameUser": googleUser.name,
                      "sub": googleUser.sub
                    }).sign(key, algorithm: JWTAlgorithm.HS256)}'
              });

          final loginInfoJson = json.decode(loginInfo.body);
          reafyUser = ReafyUser.fromJson(loginInfoJson);
          if (googleUser.name != null && reafyUser.userName != null) {
            await _secureStorage.write(
                key: "googleUser", value: GoogleUser.serialize(googleUser));
            await _secureStorage.write(
                key: "reafyUser", value: ReafyUser.serialize(reafyUser));
          }
          notifyListeners();
        } else {
          print("else");
        }
      } catch (e) {
        log(e.toString());
      }

      const String backendToken = 'TOKEN';
      if (backendToken != null) {
        await _secureStorage.write(
          key: BACKEND_TOKEN_KEY,
          value: backendToken,
        );
      }
      return true;
    } else {
      return false;
    }
  }
}
