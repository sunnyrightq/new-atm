import 'dart:io';

import 'package:atm/config/api_endpoints.dart';
import 'package:atm/config/app_constant.dart';
import 'package:atm/kyc/You_verifyd.dart';
import 'package:atm/models/common/api_response.dart';
import 'package:atm/models/kyc/kyc_status_model.dart';
import 'package:atm/models/simple_model.dart';
import 'package:atm/networking/http_handler.dart';
import 'package:atm/utils/loading_view.dart';
import 'package:atm/utils/local_storage/shared_preferences.dart';
import 'package:atm/utils/page_navigator.dart';
import 'package:atm/utils/show_toast.dart';
import 'package:flutter/material.dart';

class KYCRepository {
  static Future updateKYC({
    required BuildContext context,
    required bool isPanCard,
    required String aadharCardNumber,
    required File? aadharCardFontImage,
    required File? aadharCardBackImage,
    required File? panCardImage,
  }) async {
    showLoadingDialog(context: context);
    String userId = await LocalStorage.getString(key: AppConstant.userId) ?? "";
    String token = await LocalStorage.getString(key: AppConstant.token) ?? "";
    APIResponse response = await HttpHandler.postMultiPartRequestMethod(
      url: APIEndpoints.updateKYC,
      data: {
        "aadhar_card_number": aadharCardNumber,
        "user_id": userId,
        "auth_key": token,
        "is_app": AppConstant.isApp.toString(),
      },
      file1Key: !isPanCard ? "aadhar_card_front_image" : null,
      file1Data: !isPanCard ? aadharCardFontImage : null,
      file2Key: !isPanCard ? "aadhar_card_back_image" : null,
      file2Data: !isPanCard ? aadharCardBackImage : null,
      file3Key: isPanCard ? "pancard_image" : null,
      file3Data: isPanCard ? panCardImage : null,
    );
    if (response.isSuccess) {
      SimpleModel simpleModel = simpleModelFromJson(response.data);
      hideLoadingDialog(context: context);
      PageNavigator.pushPage(
        context: context,
        page: const YouVerifiedScreen(),
      );
      showToast(msg: simpleModel.message, context: context);
    } else {
      SimpleModel simpleModel = simpleModelFromJson(response.data);
      hideLoadingDialog(context: context);
      showToast(msg: simpleModel.message, isError: true, context: context);
    }
  }

  static Future<KycStatusModel?> getKycStatus({required BuildContext context}) async {
    String userId = await LocalStorage.getString(key: AppConstant.userId) ?? "";
    String token = await LocalStorage.getString(key: AppConstant.token) ?? "";
    APIResponse apiResponse = await HttpHandler.postMethod(
        url: APIEndpoints.kycStatus,
        context: context,
        data: {"is_app": AppConstant.isApp.toString(), "user_id": userId, "auth_key": token});
    if (apiResponse.isSuccess) {
      return kycStatusModelFromJson(apiResponse.data);
    } else {
      return kycStatusModelFromJson(apiResponse.data);
    }
  }
}
