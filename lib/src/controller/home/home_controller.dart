import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../core/model/users/users_model.dart';
import '../../../core/service/request/api_req.dart';

class HomeController extends ChangeNotifier {
  final ApiReq apiReq = ApiReq();

  late UserList _userList;
  UserList get userList => _userList;

  int _currentPage = 1;
  int get currentPage => _currentPage;

  Future<void> usersListReq() async {
    try {
      final response = await apiReq.usersList(_currentPage);
      if (response.statusCode == 200) {
        _userList = userListFromJson(jsonEncode(response.data));
        _currentPage = (_currentPage == 1) ? 2 : 1; // Toggle between 1 and 2
        notifyListeners();
      }
    } catch (e) {
      Future.error('Sunucu Bakımda Lütfen Daha Sonra Tekrar Deneyiniz');
    }
  }
}
