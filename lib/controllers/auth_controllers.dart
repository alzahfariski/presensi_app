import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:presensi_app/models/user_model.dart';
import 'package:presensi_app/screens/absensi_screen.dart';
import 'package:presensi_app/services/auth_service.dart';
import 'package:presensi_app/utils/loaders/fullscreen_loader.dart';
import 'package:presensi_app/utils/loaders/loader.dart';
import 'package:presensi_app/utils/networks/network_manager.dart';

class AuthenticationController extends GetxController {
  static AuthenticationController get instance => Get.find();

  RxBool isLogin = true.obs;
  RxBool isHidden = true.obs;

  late TextEditingController email;
  late TextEditingController username;
  late TextEditingController password;
  late TextEditingController work;

  @override
  void onInit() async {
    email = TextEditingController();
    username = TextEditingController();
    password = TextEditingController();
    work = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    email.dispose();
    username.dispose();
    password.dispose();
    work.dispose();
    super.onClose();
  }

  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> updateUserProfilFormKey = GlobalKey<FormState>();

  UserModel? _user;

  UserModel? get user => _user;

  Future<void> autoLogin() async {
    final box = GetStorage();
    final token = box.read('usertoken');
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      if (token != null) {
        _user = await AuthService().fetchData(token);
        update();
      }
    }
  }

  Future<bool> login({
    String? username,
    String? password,
  }) async {
    try {
      UserModel user = await AuthService().login(
        username: username,
        password: password,
      );
      _user = await AuthService().fetchData(user.token!);

      // work.text = user.work!;

      update();
      return true;
    } catch (e) {
      return false;
    }
  }

  void handleSignIn() async {
    try {
      EFullScreenLoader.openLoadingDialog(
          'we are processing your information', 'assets/lottie/loader.json');
      if (!signInFormKey.currentState!.validate()) {
        EFullScreenLoader.stopLoading();
        return;
      }
      if (await login(
        username: username.text,
        password: password.text,
      )) {
        EFullScreenLoader.stopLoading();
        ALoaders.successSnackBar(title: 'selamat', message: 'Selamat Datang');

        final storage = GetStorage();
        storage.write("isFirstTime", false);
        final box = GetStorage();
        box.writeIfNull('usertoken', user!.token);
        Get.to(() => AbsensiScreen());
      } else {
        ALoaders.errorSnackBar(
            title: 'oh snap!', message: 'Tidak berhasil login');
        EFullScreenLoader.stopLoading();
      }
    } catch (e) {
      ALoaders.errorSnackBar(title: 'oh snap!', message: e.toString());
      EFullScreenLoader.stopLoading();
    }
  }

  void refreshFormKeys() {
    signInFormKey = GlobalKey<FormState>();
  }

  File? selectedImage;
}
