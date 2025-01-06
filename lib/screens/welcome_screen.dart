import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi_app/screens/login_screen.dart';
import 'package:presensi_app/widgets/button_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Logo.png',
                height: 100,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Presensi App',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                'Aplikasi absensi karyawan',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ButtonWidget(
        onTap: () => Get.to(() => LoginScreen()),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
