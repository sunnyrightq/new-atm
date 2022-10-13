import 'dart:io' show Platform;

import 'package:atm/Bottomnavi.dart';
import 'package:atm/First_pages/Login_page.dart';
import 'package:atm/config/app_constant.dart';
import 'package:atm/models/app_update/app_update_model.dart';
import 'package:atm/repository/app_update_repository.dart';
import 'package:atm/utils/local_storage/shared_preferences.dart';
import 'package:atm/utils/page_navigator.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class First_screen extends StatefulWidget {
  const First_screen({Key? key}) : super(key: key);

  @override
  State<First_screen> createState() => _First_screenState();
}

class _First_screenState extends State<First_screen> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    AppUpdateModel? appUpdateModel =
        await AppUpdateRepository.checkAppConfigToUpdate(context: context);
    if (appUpdateModel != null) {
      if (Platform.isAndroid) {
        if (appUpdateModel.data.androidVersion !=
            AppConstant.androidAppVersion) {
          Future.delayed(const Duration(seconds: 0), () {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    title: const Center(
                        child: Text(
                      "Update App",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    )),
                    content: const Text(
                      "New version of app is available. Please update app to get better experience.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.blueGrey, fontWeight: FontWeight.w400),
                    ),
                    actions: [
                      appUpdateModel.data.androidForceUpdate
                          ? Container()
                          : TextButton(
                              onPressed: () {
                                checkLoginStatus();
                              },
                              child: const Text(
                                "IGNORE",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16),
                              )),
                      TextButton(
                          onPressed: () async {
                            if (await canLaunchUrl(
                                Uri.parse(appUpdateModel.data.androidUrl))) {
                              await launchUrl(
                                  Uri.parse(appUpdateModel.data.androidUrl));
                            }
                          },
                          child: const Text(
                            "UPDATE",
                            style: TextStyle(color: Colors.green, fontSize: 16),
                          ))
                    ],
                  );
                });
          });
        } else {
          checkLoginStatus();
        }
      } else if (Platform.isIOS) {
        if (appUpdateModel.data.iosVersion != AppConstant.iosAppVersion) {
          Future.delayed(const Duration(seconds: 0), () {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    title: const Center(
                        child: Text(
                      "Update App",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    )),
                    content: const Text(
                      "New version of app is available. Please update app to get better experience.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.blueGrey, fontWeight: FontWeight.w400),
                    ),
                    actions: [
                      appUpdateModel.data.iosForceUpdate
                          ? Container()
                          : TextButton(
                              onPressed: () {
                                checkLoginStatus();
                              },
                              child: const Text(
                                "IGNORE",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              )),
                      TextButton(
                          onPressed: () async {
                            if (await canLaunchUrl(
                                Uri.parse(appUpdateModel.data.iosUrl))) {
                              await launchUrl(
                                  Uri.parse(appUpdateModel.data.iosUrl));
                            }
                          },
                          child: const Text(
                            "UPDATE",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ))
                    ],
                  );
                });
          });
        } else {
          checkLoginStatus();
        }
      }
    } else {
      checkLoginStatus();
    }
  }

  void checkLoginStatus() async {
    bool? isLogin = await LocalStorage.getBool(key: AppConstant.isLoggedIn);
    if (isLogin == true) {
      PageNavigator.pushAndRemoveUntilPage(
          context: context, page: const Bottomnavi());
    } else {
      PageNavigator.pushAndRemoveUntilPage(
          context: context, page: const LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(63, 81, 181, 1),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 120),
            child: Image.asset("assets/Logo_Atm.png"),
          )
        ],
      ),
    );
  }
}
