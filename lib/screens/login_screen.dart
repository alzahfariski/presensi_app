import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi_app/controllers/auth_controllers.dart';
import 'package:presensi_app/screens/absensi_screen.dart';
import 'package:presensi_app/utils/constants/color.dart';
import 'package:presensi_app/widgets/text_input_widget.dart';

import '../utils/validators/validator.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logController = Get.put(AuthenticationController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Form(
            key: logController.signInFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back!',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.black,
                      ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Sign in your account',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                      ),
                ),
                const SizedBox(
                  height: 18,
                ),
                TextInputWidget(
                  validator: (value) => AValidtor.validateEmail(value),
                  labelText: 'Email',
                ),
                const SizedBox(
                  height: 18,
                ),
                TextInputWidget(
                  validator: (value) => AValidtor.validateEmail(value),
                  labelText: 'Password',
                ),
                const SizedBox(
                  height: 18,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        DInfo.snackBarError(
                            context, 'Maaf fitur belum tersedia');
                      },
                      child: Text(
                        'Lupa Password ?',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: AColors.primary,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      logController.handleSignIn();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AColors.primary,
                      padding: const EdgeInsets.all(18),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => AbsensiScreen());
                  },
                  child: Text('Coba aplikasi tanpa API'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
