import 'dart:io';

import 'package:atm/models/app_update/razorpay_config_model.dart';
import 'package:atm/models/withdrawal/get_withdrawal_list_model.dart';
import 'package:atm/repository/investment_repository.dart';
import 'package:atm/utils/page_navigator.dart';
import 'package:atm/utils/show_logs.dart';
import 'package:atm/utils/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Home_pages/Home.dart';

class AddDepositProofScreen extends StatefulWidget {
  const AddDepositProofScreen({
    Key? key,
    required this.withdrawalDatum,
    required this.razorPayConfigModel,
    required this.amount,
  }) : super(key: key);

  final WithdrawalDatum? withdrawalDatum;
  final RazorPayConfigModel razorPayConfigModel;
  final String amount;

  @override
  State<AddDepositProofScreen> createState() => _AddDepositProofScreenState();
}

class _AddDepositProofScreenState extends State<AddDepositProofScreen> {
  String select = '';
  File? proofPicture;

  Future<void> uploadProofImage() async {
    ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      proofPicture = File(image.path);
      showLogs(message: "USER PICTURE :: $proofPicture");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            child: Stack(
              children: [
                ClipPath(
                  clipper: CustomShape(),
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    color: const Color.fromRGBO(59, 6, 122, 1),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 20, left: 5),
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          PageNavigator.pop(context: context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 10, left: 20),
                        child: Text(
                          widget.withdrawalDatum!.planName ?? "--",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                    Container(
                      margin: EdgeInsets.only(right: MediaQuery.of(context).size.width / 3.9, top: 10),
                      child: Text(
                        "Get ${widget.withdrawalDatum!.planMonthlyMinReturn}-${widget.withdrawalDatum!.planMonthlyMaxReturn}% monthly returns",
                        style: const TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 15),
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 2.5,
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: Image.network(
                            widget.razorPayConfigModel.data.upiQrcode,
                            height: MediaQuery.of(context).size.width / 2.5,
                            width: MediaQuery.of(context).size.width / 2.5,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          widget.razorPayConfigModel.data.upiId,
                          style: const TextStyle(color: Colors.black, fontSize: 17),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            image: proofPicture != null
                                ? DecorationImage(
                                    image: FileImage(proofPicture!),
                                  )
                                : null,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 60,
                                width: 150,
                                child: IconButton(
                                  onPressed: uploadProofImage,
                                  icon: const Icon(
                                    Icons.camera_enhance_outlined,
                                    size: 40,
                                    color: Color.fromRGBO(59, 6, 122, 1),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: const Text(
                                  "Upload Proof",
                                  style: TextStyle(fontSize: 17),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 37,
            margin: const EdgeInsets.only(left: 25, right: 25, top: 50),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(59, 6, 122, 1), borderRadius: BorderRadius.all(Radius.circular(5))),
            child: TextButton(
              onPressed: () async {
                if (proofPicture != null) {
                  await InvestRepository.investmentManualManage(
                      context: context,
                      amount: widget.amount,
                      image: proofPicture!,
                      planId: widget.withdrawalDatum!.planId ?? "1");
                } else {
                  showToast(context: context, msg: "Please select screen shot for proof!", isError: true);
                }
              },
              child: const Text(
                "SUBMIT",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
