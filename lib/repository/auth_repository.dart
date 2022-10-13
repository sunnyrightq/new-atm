import 'package:atm/Bottomnavi.dart';
import 'package:atm/First_pages/Login_page.dart';
import 'package:atm/First_pages/login_otp_screen.dart';
import 'package:atm/First_pages/register_otp_screen.dart';
import 'package:atm/config/api_endpoints.dart';
import 'package:atm/config/app_constant.dart';
import 'package:atm/models/authentication/login_model.dart';
import 'package:atm/models/common/api_response.dart';
import 'package:atm/models/simple_model.dart';
import 'package:atm/networking/http_handler.dart';
import 'package:atm/utils/loading_view.dart';
import 'package:atm/utils/local_storage/shared_preferences.dart';
import 'package:atm/utils/page_navigator.dart';
import 'package:atm/utils/show_toast.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  // static Future createUser(
  //     {required BuildContext context,
  //     required String userFirstName,
  //     required String userLastName,
  //     required String userEmailAddress,
  //     required String userPhone}) async {
  //   showLoadingDialog(context: context);
  //   APIResponse response = await HttpHandler.postMethod(url: APIEndpoints.createUser, data: {
  //     "user_first_name": userFirstName,
  //     "user_last_name": userLastName,
  //     "user_email_address": userEmailAddress,
  //     "user_phone": userPhone,
  //   });
  //   if (response.isSuccess) {
  //     hideLoadingDialog(context: context);
  //     CreateUserModel createUserModel = createUserModelFromJson(response.data);
  //     showToast(
  //       msg: createUserModel.message!,
  //       color: Colors.green,
  //       context: context,
  //     );
  //     PageNavigator.pushAndRemoveUntilPage(context: context, page: const Login_page());
  //   } else {
  //     hideLoadingDialog(context: context);
  //     CreateUserModel createUserModel = createUserModelFromJson(response.data);
  //     showToast(
  //       msg: createUserModel.message!,
  //       color: Colors.red,
  //       context: context,
  //     );
  //   }
  // }

  static Future validateAndGetOTPForNewRegister({
    required BuildContext context,
    required String userFirstName,
    required String userLastName,
    required String userEmailAddress,
    required String userPhone,
  }) async {
    if (userFirstName.isEmpty) {
      showToast(context: context, msg: "Enter first name.", isError: true);
    } else if (userLastName.isEmpty) {
      showToast(context: context, msg: "Enter last name.", isError: true);
    } else if (userEmailAddress.isEmpty) {
      showToast(context: context, msg: "Enter e-mail address.", isError: true);
    } else if (!isValidEmail(userEmailAddress)) {
      showToast(context: context, msg: "Enter valid e-mail address.", isError: true);
    } else if (userPhone.isEmpty) {
      showToast(context: context, msg: "Enter phone number.", isError: true);
    } else if (userPhone.length < 4 || userPhone.length > 12) {
      showToast(context: context, msg: "Enter valid phone number", isError: true);
    } else {
      showLoadingDialog(context: context);
      APIResponse response = await HttpHandler.postMethod(
        context: context,
          url: APIEndpoints.newRegister,
          data: {"user_email_address": userEmailAddress, "is_app": AppConstant.isApp, "action": APIActions.sendOTP});
      if (response.isSuccess) {
        hideLoadingDialog(context: context);
        SimpleModel simpleModel = simpleModelFromJson(response.data);
        PageNavigator.pushPage(
            context: context,
            page: RegisterOTPScreen(
                phoneNumber: userPhone, email: userEmailAddress, firstName: userFirstName, lastName: userLastName));
        showToast(msg: simpleModel.message, context: context);
      } else {
        hideLoadingDialog(context: context);
        SimpleModel simpleModel = simpleModelFromJson(response.data);
        showToast(msg: simpleModel.message, isError: true, context: context);
      }
    }
  }

  static Future newRegisterUser({
    required BuildContext context,
    required String userFirstName,
    required String userLastName,
    required String userEmailAddress,
    required String userPhone,
    required String otp,
  }) async {
    showLoadingDialog(context: context);
    APIResponse response = await HttpHandler.postMethod(context: context,url: APIEndpoints.createUser, data: {
      "user_first_name": userFirstName,
      "user_last_name": userLastName,
      "user_email_address": userEmailAddress,
      "user_phone": userPhone,
      "is_app": AppConstant.isApp,
      "otp": otp
    });
    if (response.isSuccess) {
      SimpleModel simpleModel = simpleModelFromJson(response.data);
      hideLoadingDialog(context: context);
      PageNavigator.pushAndRemoveUntilPage(context: context, page: const LoginScreen());
      showToast(msg: simpleModel.message, context: context);
    } else {
      SimpleModel simpleModel = simpleModelFromJson(response.data);
      hideLoadingDialog(context: context);
      showToast(msg: simpleModel.message, isError: true, context: context);
    }
  }

  static Future validateAndGetLoginOTP({required BuildContext context, required String userEmailAddress}) async {
    if (userEmailAddress.isEmpty) {
      showToast(context: context, msg: 'E-mail Is Required.', isError: true);
    } else if (!isValidEmail(userEmailAddress)) {
      showToast(
        context: context,
        msg: 'Enter valid e-mail address.',
        isError: true,
      );
    } else {
      showLoadingDialog(context: context);
      APIResponse response = await HttpHandler.postMethod(context: context,
          url: APIEndpoints.login,
          data: {"username": userEmailAddress, "is_app": AppConstant.isApp, "action": APIActions.sendOTP});
      if (response.isSuccess) {
        hideLoadingDialog(context: context);
        SimpleModel simpleModel = simpleModelFromJson(response.data);
        PageNavigator.pushPage(context: context, page: LoginOTPScreen(email: userEmailAddress));
        showToast(msg: simpleModel.message, context: context);
      } else {
        hideLoadingDialog(context: context);
        SimpleModel simpleModel = simpleModelFromJson(response.data);
        showToast(msg: simpleModel.message, isError: true, context: context);
      }
    }
  }

  static Future login({required BuildContext context, required String userEmailAddress, required String otp}) async {
    showLoadingDialog(context: context);
    APIResponse response = await HttpHandler.postMethod(context: context,
        url: APIEndpoints.login,
        data: {"username": userEmailAddress, "is_app": AppConstant.isApp, "action": APIActions.verifyOTP, "otp": otp});
    if (response.isSuccess) {
      hideLoadingDialog(context: context);
      LoginModel loginModel = loginModelFromJson(response.data);
      LocalStorage.setString(key: AppConstant.token, value: loginModel.userData!.authKey);
      LocalStorage.setString(key: AppConstant.userId, value: loginModel.userData!.userId);
      LocalStorage.setString(key: AppConstant.userDetails, value: loginModelToJson(loginModel));
      LocalStorage.setBool(key: AppConstant.isLoggedIn, value: true);
      PageNavigator.pushPage(context: context, page: const Bottomnavi());
      showToast(msg: loginModel.message ?? "--", context: context);
    } else {
      hideLoadingDialog(context: context);
      LoginModel loginModel = loginModelFromJson(response.data);
      showToast(msg: loginModel.message ?? "--", isError: true, context: context);
    }
  }
}

bool isValidEmail(String email) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(p);

  return regExp.hasMatch(email);
}
