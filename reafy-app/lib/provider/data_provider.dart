import 'dart:developer';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reafy/models/response_data.dart';

import '../models/user.dart';

class DataProvider with ChangeNotifier {
  ResponseData responseData = ResponseData();
  User user = User();

  bool isLoading = false;

  getUser() async {
    //isLoading = true;
    responseData = await getAllData();
    //isLoading = false;

    notifyListeners();
  }

  getParticipantList() async {
    isLoading = true;
    responseData = await getAllData();
    isLoading = false;
    notifyListeners();
  }

  Future<ResponseData> getAllData() async {
    try {
      final response = await http.get(Uri.parse(
          "https://reafy-christianvestre.vercel.app/api/whitelist/get-people-whitelist"));
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        responseData = ResponseData.fromJson(item);
        notifyListeners();
      } else {
        print("else");
      }
    } catch (e) {
      log(e.toString());
    }

    return responseData;
  }
}
