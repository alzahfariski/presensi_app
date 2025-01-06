import 'package:d_info/d_info.dart';
import 'package:presensi_app/services/absensi_service.dart';
import 'package:presensi_app/utils/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:one_clock/one_clock.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:get_storage/get_storage.dart';

class AbsensiScreen extends StatefulWidget {
  const AbsensiScreen({super.key});

  @override
  State<AbsensiScreen> createState() => _AbsensiScreenState();
}

class _AbsensiScreenState extends State<AbsensiScreen> {
  final attendanceService = AttendanceService();
  String? checkInTime;
  String? checkOutTime;
  bool isLoading = false;
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
  }

  Future<void> handleCheckIn() async {
    try {
      setState(() => isLoading = true);

      final ImagePicker picker = ImagePicker();
      final XFile? photo = await picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 50,
      );

      if (photo == null) {
        // ignore: use_build_context_synchronously
        DInfo.snackBarError(context, 'Foto diperlukan untuk check-in');
        return;
      }

      final userId = box.read('userId') ?? '';
      if (userId.isEmpty) {
        // ignore: use_build_context_synchronously
        DInfo.snackBarError(context, 'User ID tidak ditemukan');
        return;
      }

      // ignore: unused_local_variable
      final result = await attendanceService.checkIn(
        userId: userId,
        photo: File(photo.path),
      );

      setState(() {
        checkInTime = DateTime.now().toString().substring(11, 16);
      });
      // ignore: use_build_context_synchronously
      DInfo.snackBarSuccess(context, 'Berhasil melakukan check-in');
    } catch (e) {
      // ignore: use_build_context_synchronously
      DInfo.snackBarError(context, 'Gagal melakukan check-in: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> handleCheckOut() async {
    try {
      setState(() => isLoading = true);

      final userId = box.read('userId') ?? '';
      if (userId.isEmpty) {
        DInfo.snackBarError(context, 'User ID tidak ditemukan');
        return;
      }

      // ignore: unused_local_variable
      final result = await attendanceService.checkOut(
        userId: userId,
      );

      setState(() {
        checkOutTime = DateTime.now().toString().substring(11, 16);
      });
      // ignore: use_build_context_synchronously
      DInfo.snackBarSuccess(context, 'Berhasil melakukan check-out');
    } catch (e) {
      // ignore: use_build_context_synchronously
      DInfo.snackBarError(context, 'Gagal melakukan check-out: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bgheader.png'),
                  alignment: Alignment.topCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image.asset(
                            'assets/images/Logo.png',
                            width: 48.0,
                            height: 48.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello, Welcome!',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.black),
                            ),
                            Text(
                              box.read('username') ?? 'User',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 18,
              ),
              child: Column(
                children: [
                  DigitalClock.light(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    isLive: true,
                    datetime: DateTime.now(),
                    textScaleFactor: 1.8,
                    digitalClockTextColor: AColors.primary,
                    showSeconds: false,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: DigitalClock(
                      format: 'yMMMEd',
                      datetime: DateTime.now(),
                      textScaleFactor: 1,
                      showSeconds: false,
                      isLive: true,
                    ),
                  ),
                  const SizedBox(height: 32),
                  GestureDetector(
                    onTap: isLoading
                        ? null
                        : (checkInTime == null
                            ? handleCheckIn
                            : handleCheckOut),
                    child: Container(
                      padding: const EdgeInsets.all(64),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isLoading
                            ? AColors.primary.withAlpha(120)
                            : AColors.primary,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 12,
                            color: AColors.primary,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          if (isLoading)
                            const CircularProgressIndicator(color: Colors.white)
                          else
                            Icon(
                              checkInTime == null
                                  ? MingCuteIcons.mgc_finger_press_line
                                  : MingCuteIcons.mgc_close_line,
                              size: 62,
                              color: Colors.white,
                            ),
                          const SizedBox(height: 18),
                          Text(
                            checkInTime == null ? 'Check In' : 'Check Out',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            checkInTime ?? '-- : --',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Check In',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                    ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            checkOutTime ?? '-- : --',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Check Out',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  GestureDetector(
                    onTap: () {
                      DInfo.snackBarError(
                        context,
                        'Maaf Fitur Belum dikembangkan',
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AColors.primary.withAlpha(100),
                          width: 0.8,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          MingCuteIcons.mgc_calendar_add_line,
                                          size: 24,
                                          color: AColors.primary,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          'Izin Bekerja',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      MingCuteIcons.mgc_right_line,
                                      color: AColors.primary,
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: AColors.primary,
                                  height: 32,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      MingCuteIcons.mgc_information_line,
                                      color: AColors.primary,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Tidak sedang mengajukan izin',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
