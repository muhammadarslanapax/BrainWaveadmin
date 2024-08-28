import 'package:fintech_dashboard_clone/models/KeysModel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../models/UserModel.dart';

class DataHandlerController extends ChangeNotifier {
  List<UserModel>? _users;
  KeysModel? keysModel;

  List<UserModel> get users => _users ?? [];
  bool? _isUserLoading;
  bool get isUserLoading => _isUserLoading ?? false;
  getUsers() async {
    try {
      _isUserLoading = true;
      notifyListeners();
      var res = await FirebaseFirestore.instance.collection('users').get();
      _users = res.docs.map((user) {
        UserModel userModel = UserModel.fromMap(user.data());
        userModel.user_id = user.id;
        return userModel;
      }).toList();
    } catch (e) {}

    _isUserLoading = false;
    notifyListeners();
  }

  getCredentials() async {
    try {
      var res =
          await FirebaseFirestore.instance.collection('Credentials').get();
      if (res.docs.isNotEmpty) {
        keysModel = KeysModel.fromMap(res.docs[0].data());
        keysModel!.id = res.docs[0].id;
        notifyListeners();
      }
    } catch (e) {}
  }

  updateCredentials({required KeysModel keyModel}) async {
    try {
      _isUserLoading = true;
      notifyListeners();
      print('addeddddinggg');
      if (keysModel != null) {
        await FirebaseFirestore.instance
            .collection('Credentials')
            .doc(keysModel!.id)
            .update(keyModel.toMap());
        keysModel = keyModel;
      } else {
        var res = await FirebaseFirestore.instance
            .collection('Credentials')
            .add(keyModel.toMap());
        keyModel.id = res.id;
        keysModel = keyModel;
      }
      // print('addedddd');
      Get.showSnackbar(const GetSnackBar(message: 'Updated successfully!'));
    } catch (e) {
      print(e);
      Get.showSnackbar(GetSnackBar(message: e.toString()));
    }
    _isUserLoading = false;
    notifyListeners();
  }

  bool checkIfPlannotExists({String? startDate, String? endDate}) {
    try {
      if (startDate != null) {
        if (DateTime.parse(startDate).isBefore(DateTime.parse(endDate!))) {
          return true;
        }
      }
    } catch (e) {}
    return false;
  }
}
