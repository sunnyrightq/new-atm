import 'dart:io';

import 'package:atm/Bottomnavi.dart';
import 'package:atm/config/api_endpoints.dart';
import 'package:atm/config/app_constant.dart';
import 'package:atm/models/common/api_response.dart';
import 'package:atm/models/investment_manage/investment_manage_model.dart';
import 'package:atm/networking/http_handler.dart';
import 'package:atm/repository/payment_repository.dart';
import 'package:atm/utils/loading_view.dart';
import 'package:atm/utils/local_storage/shared_preferences.dart';
import 'package:atm/utils/page_navigator.dart';
import 'package:atm/utils/payment/razorpay_payment.dart';
import 'package:atm/utils/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class InvestRepository {
  static Future<void> investmentManualManage({
    required BuildContext context,
    required String amount,
    required File image,
    required String planId,
  }) async {
    showLoadingDialog(context: context);
    APIResponse apiResponse = await HttpHandler.postMultiPartRequestMethod(
        url: APIEndpoints.investmentManage,
        file1Data: image,
        file1Key: "payment_screenshort_image",
        data: {
          "manual_deposit": "1",
          "is_app": AppConstant.isApp.toString(),
          "action": APIActions.buyPackage,
          "user_id": await LocalStorage.getString(key: AppConstant.userId) ?? "",
          "auth_key": await LocalStorage.getString(key: AppConstant.token) ?? "",
          "plan_id": planId,
          "amount": amount
        });
    if (apiResponse.isSuccess) {
      hideLoadingDialog(context: context);
      InvestmentManageModel investmentManageModel = investmentManageModelFromJson(apiResponse.data);
      showToast(context: context, msg: investmentManageModel.message ?? "");
      PageNavigator.pushAndRemoveUntilPage(context: context, page: const Bottomnavi());
    } else {
      hideLoadingDialog(context: context);
    }
  }

  static Future<void> investmentOnlineManage({
    required BuildContext context,
    required String amount,
    required String planId,
  }) async {
    showLoadingDialog(context: context);
    APIResponse apiResponse = await HttpHandler.postMethod(context: context, url: APIEndpoints.investmentManage, data: {
      "manual_deposit": "0",
      "is_app": AppConstant.isApp.toString(),
      "action": APIActions.buyPackage,
      "user_id": await LocalStorage.getString(key: AppConstant.userId) ?? "",
      "auth_key": await LocalStorage.getString(key: AppConstant.token) ?? "",
      "plan_id": planId,
      "amount": amount
    });
    if (apiResponse.isSuccess) {
      hideLoadingDialog(context: context);
      InvestmentManageModel investmentManageModel = investmentManageModelFromJson(apiResponse.data);
      RazorpayPayment.paymentRequestOptions['amount'] = (int.parse(amount) * 100).toString();
      RazorpayPayment.addRazorpayListeners(
        onSuccessHandel: (PaymentSuccessResponse response) async {
          await PaymentRepository.paymentSuccess(context: context, investmentId: investmentManageModel.investmentId!);
        },
        onFailureHandel: (PaymentFailureResponse response) async {
          await PaymentRepository.paymentFailed(context: context, investmentId: investmentManageModel.investmentId!);
        },
      );
      RazorpayPayment.openRazorpayPayment();
    } else {
      hideLoadingDialog(context: context);
    }
  }
}
