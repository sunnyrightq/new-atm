import 'package:atm/First_pages/add_deposit_proof_screen.dart';
import 'package:atm/models/app_update/razorpay_config_model.dart';
import 'package:atm/models/withdrawal/get_withdrawal_list_model.dart';
import 'package:atm/repository/investment_repository.dart';
import 'package:atm/utils/page_navigator.dart';
import 'package:atm/utils/show_toast.dart';
import 'package:atm/utils/type_strings.dart';
import 'package:flutter/material.dart';

import '../Home_pages/Home.dart';

enum DepositType { online_deposit, manual_deposit }

class DepositScreen extends StatefulWidget {
  const DepositScreen(
      {Key? key,
      required this.depositType,
      required this.razorPayConfigModel,
      required this.withdrawalDatum})
      : super(key: key);

  final WithdrawalDatum? withdrawalDatum;
  final DepositType depositType;
  final RazorPayConfigModel razorPayConfigModel;

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  final TextEditingController amountController = TextEditingController();
  String select = '';

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
                    color: const Color.fromRGBO(63, 81, 181, 1),
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
                      margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width / 3.9,
                          top: 10),
                      child: Text(
                        "Get ${widget.withdrawalDatum!.planMonthlyMinReturn}-${widget.withdrawalDatum!.planMonthlyMaxReturn}% monthly returns",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              right: 15, bottom: 10, top: 15),
                          margin: const EdgeInsets.only(
                              left: 15, right: 15, top: 15),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 226, 224, 224),
                                  blurRadius: 5.0,
                                ),
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.only(left: 20),
                                child: const Text(
                                  "Deposit Amount",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 120),
                                    alignment: Alignment.center,
                                    child: TextFormField(
                                      controller: amountController,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                      cursorHeight: 25,
                                      cursorWidth: 2,
                                      keyboardType: TextInputType.number,
                                      cursorColor: Colors.black,
                                      onChanged: (c) {
                                        if (mounted) {
                                          setState(() {});
                                        }
                                      },
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: 15,
                                              bottom: 11,
                                              top: 11,
                                              right: 15),
                                          hintText: "₹",
                                          hintStyle: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Minimum Amount is 500",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 15, bottom: 10),
                                    width: 80,
                                    child: ChoiceChip(
                                      padding: const EdgeInsets.only(
                                          top: 15, bottom: 15, left: 15),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      )),
                                      selectedColor:
                                          const Color.fromRGBO(63, 81, 181, 1),
                                      label: Row(
                                        children: const [
                                          Text(
                                            '500',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      selected:
                                          (select == '500') ? true : false,
                                      onSelected: (bool value) {
                                        setState(() {
                                          select = '500';
                                          amountController.text = select;
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 15, bottom: 10),
                                    width: 80,
                                    child: ChoiceChip(
                                      padding: const EdgeInsets.only(
                                          top: 15, bottom: 15, left: 15),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      selectedColor:
                                          const Color.fromRGBO(63, 81, 181, 1),
                                      label: Row(
                                        children: const [
                                          Text(
                                            '1000',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      selected:
                                          (select == '1000') ? true : false,
                                      onSelected: (bool value) {
                                        setState(() {
                                          select = '1000';
                                          amountController.text = select;
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 15, bottom: 10),
                                    width: 80,
                                    child: ChoiceChip(
                                      padding: const EdgeInsets.only(
                                          top: 15, bottom: 15, left: 15),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      selectedColor:
                                          const Color.fromRGBO(63, 81, 181, 1),
                                      label: Row(
                                        children: const [
                                          Text(
                                            '5000',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      selected:
                                          (select == '5000') ? true : false,
                                      onSelected: (bool value) {
                                        setState(() {
                                          select = '5000';
                                          amountController.text = select;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              right: 15, bottom: 10, top: 15),
                          margin: const EdgeInsets.only(
                              left: 15, right: 15, top: 15),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 226, 224, 224),
                                  blurRadius: 5.0,
                                ),
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: Text(
                                  widget.withdrawalDatum!.planName ?? "--",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      widget.withdrawalDatum!.planDescription ??
                                          "--",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(
                              right: 15, bottom: 10, top: 15),
                          margin: const EdgeInsets.only(
                              left: 15, right: 15, top: 15),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 226, 224, 224),
                                  blurRadius: 5.0,
                                ),
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  "Return upto ${widget.withdrawalDatum!.planMonthlyMinReturn}-${widget.withdrawalDatum!.planMonthlyMaxReturn}% Monthly",
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  amountController.text.isNotEmpty
                                      ? "${getINRTypeValue(rupees: double.parse((int.parse(amountController.text) * int.parse(widget.withdrawalDatum!.planMonthlyMinReturn ?? "0") / 100).toString()))} - ${getINRTypeValue(rupees: double.parse((int.parse(amountController.text) * int.parse(widget.withdrawalDatum!.planMonthlyMaxReturn ?? "0") / 100).toString()))}"
                                      : "₹0 - ₹0",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Color.fromRGBO(63, 81, 181, 1),
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 37,
            margin: const EdgeInsets.only(left: 25, right: 25, top: 50),
            decoration: const BoxDecoration(
                color: Color(0xff224389),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: TextButton(
              onPressed: () async {
                if (widget.depositType == DepositType.manual_deposit) {
                  if (amountController.text.isNotEmpty &&
                      int.parse(amountController.text) > 0) {
                    PageNavigator.pushPage(
                        context: context,
                        page: AddDepositProofScreen(
                          razorPayConfigModel: widget.razorPayConfigModel,
                          amount: amountController.text,
                          withdrawalDatum: widget.withdrawalDatum,
                        ));
                  } else {
                    showToast(
                        context: context,
                        msg: "Please select screen shot for proof!",
                        isError: true);
                  }
                } else {
                  if (amountController.text.isNotEmpty &&
                      int.parse(amountController.text) > 0) {
                    await InvestRepository.investmentOnlineManage(
                        context: context,
                        amount: amountController.text,
                        planId: widget.withdrawalDatum!.planId ?? "1");
                  } else {
                    showToast(
                        context: context,
                        msg: "Please enter correct amount!",
                        isError: true);
                  }
                }
              },
              child: const Text(
                "NEXT",
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
