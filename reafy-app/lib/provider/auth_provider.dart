import 'dart:developer';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:reafy/helper/constants.dart';
import 'package:reafy/models/user.dart';

class AuthProvider with ChangeNotifier {
  final FlutterAppAuth _appAuth = const FlutterAppAuth();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  User user = User();
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

    final storedUser = await _secureStorage.read(key: "user");
    print(storedUser);
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
      print(isLoggedIn);
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
          print(item);
          user = User.fromJson(item);
          print(user.name);
          if (user.name != null) {
            await _secureStorage.write(
                key: "user", value: User.serialize(user));
          }
          notifyListeners();
        } else {
          print("else");
        }
      } catch (e) {
        log(e.toString());
      }

      // Send request to backend with access token
      // final url = Uri.https(
      //   'api.your-server.com',
      //   '/v1/social-authentication',
      //   {
      //     'access_token': googleAccessToken,
      //   },
      // );
      // final response = await http.get(url);
      // final backendToken = response.token

      // Let's assume it has been successful and a valid token has been returned
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
