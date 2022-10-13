import 'package:atm/Bottomnavi.dart';
import 'package:atm/config/api_endpoints.dart';
import 'package:atm/models/common/api_response.dart';
import 'package:atm/models/simple_model.dart';
import 'package:atm/networking/http_handler.dart';
import 'package:atm/utils/loading_view.dart';
import 'package:atm/utils/page_navigator.dart';
import 'package:atm/utils/show_toast.dart';
import 'package:flutter/material.dart';

class PaymentRepository {
  static Future<void> paymentSuccess({required BuildContext context, required int investmentId}) async {
    showLoadingDialog(context: context);
    APIResponse apiResponse = await HttpHandler.postMethod(
        context: context, url: APIEndpoints.paymentSuccess, data: {"investment_id": investmentId});
    if (apiResponse.isSuccess) {
      hideLoadingDialog(context: context);
      SimpleModel simpleModel = simpleModelFromJson(apiResponse.data);
      PageNavigator.pushAndRemoveUntilPage(context: context, page: const Bottomnavi());
      showToast(context: context, msg: simpleModel.message);
    } else {
      hideLoadingDialog(context: context);
      SimpleModel simpleModel = simpleModelFromJson(apiResponse.data);
      showToast(context: context, msg: simpleModel.message, isError: true);
    }
  }

  static Future<void> paymentFailed({required BuildContext context, required int investmentId}) async {
    showLoadingDialog(context: context);
    APIResponse apiResponse = await HttpHandler.postMethod(
        context: context, url: APIEndpoints.paymentFailed, data: {"investment_id": investmentId});
    if (apiResponse.isSuccess) {
      hideLoadingDialog(context: context);
      SimpleModel simpleModel = simpleModelFromJson(apiResponse.data);
      PageNavigator.pushAndRemoveUntilPage(context: context, page: const Bottomnavi());
      showToast(context: context, msg: simpleModel.message, isError: true);
    } else {
      hideLoadingDialog(context: context);
      SimpleModel simpleModel = simpleModelFromJson(apiResponse.data);
      showToast(context: context, msg: simpleModel.message, isError: true);
    }
  }
}
