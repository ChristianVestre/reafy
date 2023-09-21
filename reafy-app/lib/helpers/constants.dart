import 'dart:io' show Platform;

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const REFRESH_TOKEN_KEY = 'refresh_token';
const BACKEND_TOKEN_KEY = 'backend_token';
const GOOGLE_ISSUER = 'https://accounts.google.com';
const GOOGLE_CLIENT_ID_IOS =
    '205445612470-ls4vdj2h844qn5vfgk3uah2ts1gcl2j5.apps.googleusercontent.com';
const GOOGLE_REDIRECT_URI_IOS =
    'com.googleusercontent.apps.205445612470-ls4vdj2h844qn5vfgk3uah2ts1gcl2j5:/oauthredirect';
const GOOGLE_CLIENT_ID_ANDROID = '<ANDROID-CLIENT-ID>';
const GOOGLE_REDIRECT_URI_ANDROID =
    'com.googleusercontent.apps.<ANDROID-CLIENT-ID>:/oauthredirect';

String clientID() {
  if (Platform.isAndroid) {
    return GOOGLE_CLIENT_ID_ANDROID;
  } else if (Platform.isIOS) {
    return GOOGLE_CLIENT_ID_IOS;
  }
  return '';
}

String redirectUrl() {
  if (Platform.isAndroid) {
    return GOOGLE_REDIRECT_URI_ANDROID;
  } else if (Platform.isIOS) {
    return GOOGLE_REDIRECT_URI_IOS;
  }
  return '';
}

//const baseApiUrl = 'http://localhost:3000/api';
const baseApiUrl = 'https://reafy-backend.vercel.app/api';
final pw = dotenv.env['SECRET_TOKEN']!;
final key = SecretKey(pw);
