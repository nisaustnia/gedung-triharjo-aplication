import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/model/list_user_model.dart';
import 'package:penyewaan_gedung_triharjo/service/list_user_service.dart';

class AccountListViewModel extends ChangeNotifier {
  List<ListUserModel?> _listAllUser = [];
  List<ListUserModel?> get allUserData => _listAllUser;

  Future getAllListUser() async {
    try {
      final List<ListUserModel> allListUserData =
          await ListUserService.fetchListUserData();

      _listAllUser = allListUserData;
      notifyListeners();
    } catch (error) {
      throw Exception('Gagal memuat all user : $error');
    }
  }

  void filterUserList(String keyword) {
    List<ListUserModel?> filteredList = _listAllUser.where((user) {
      return user?.email.toLowerCase().contains(keyword.toLowerCase()) ?? false;
    }).toList();
    _listAllUser = filteredList;
    notifyListeners();
  }

  @override
  notifyListeners();
}
