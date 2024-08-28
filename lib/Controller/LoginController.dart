import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fintech_dashboard_clone/main.dart';
import 'package:fintech_dashboard_clone/models/UserModel.dart';
import 'package:fintech_dashboard_clone/widgets/Auth/LoginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends ChangeNotifier {
  String defaultEmail = 'admin@gmail.com';
  String defaultpassword = '12345678';
  UserModel? loggedInUser;
  login({required String email, required String password}) async {
    try {
      EasyLoading.show(dismissOnTap: false);
      var isAdminUpdated =
          await FirebaseFirestore.instance.collection('Admin').get();
      var res = await FirebaseFirestore.instance
          .collection('Admin')
          .where('email', isEqualTo: email.trim())
          .where('password', isEqualTo: password)
          .get();
      EasyLoading.dismiss();
      if ((isAdminUpdated.docs.isNotEmpty && res.docs.isEmpty) ||
          (isAdminUpdated.docs.isEmpty &&
              email != defaultEmail &&
              password != defaultpassword)) {
        EasyLoading.showToast("Credentials are not valid");
      } else if (res.docs.isNotEmpty ||
          (isAdminUpdated.docs.isEmpty &&
              email == defaultEmail &&
              password == defaultpassword)) {
        SharedPreferences getStorage = await SharedPreferences.getInstance();
        if (res.docs.isNotEmpty) {
          loggedInUser = UserModel.fromMap(res.docs[0].data());
          loggedInUser!.user_id = res.docs[0].id;
        } else {
          loggedInUser =
              UserModel(email: defaultEmail, password: defaultpassword);
        }

        await getStorage.setString('loggedUser', loggedInUser!.toJson());
        Get.to(() => const HomePage());
      } else {
        EasyLoading.showToast("Credentials are not valid");
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showToast(e.toString());
    }
  }

  updateAdmin(
      {required String name,
      required String email,
      required String password}) async {
    try {
      EasyLoading.show(dismissOnTap: true);

      loggedInUser!.name = name;
      loggedInUser!.email = email;

      if (password != '') {
        loggedInUser!.password = password;
      }
      await FirebaseFirestore.instance
          .collection('Admin')
          .add(loggedInUser!.toMap());
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('loggedUser', loggedInUser!.toJson());
      EasyLoading.dismiss();
      EasyLoading.showToast('Updated Successfully!');
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showToast(e.toString());
    }
  }

  logout() async {
    try {
      SharedPreferences getStorage = await SharedPreferences.getInstance();
      await getStorage.remove('loggedUser');
      Get.to(() => const LoginScreen());
    } catch (e) {}
  }

  checkIfLoggedIn() async {
    try {
      SharedPreferences getStorage = await SharedPreferences.getInstance();
      var res = getStorage.getString('loggedUser');
      if (res != null) {
        loggedInUser = UserModel.fromJson(res);
        notifyListeners();
      }
    } catch (e) {}
  }
}
