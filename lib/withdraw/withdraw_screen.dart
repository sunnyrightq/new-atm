import 'package:atm/models/bank/bank_model.dart';
import 'package:atm/models/withdrawal/get_withdrawal_list_model.dart';
import 'package:atm/repository/withdrawal_repository.dart';
import 'package:atm/utils/page_navigator.dart';
import 'package:atm/utils/show_toast.dart';
import 'package:atm/utils/type_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum WithdrawType { capital_withdrawal, profit_withdrawal }

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({
    Key? key,
    required this.withdrawType,
    required this.withdrawalDatum,
    required this.bankDatum,
    required this.maxAmount,
  }) : super(key: key);

  final WithdrawType withdrawType;
  final WithdrawalDatum withdrawalDatum;
  final BankDatum bankDatum;
  final double maxAmount;

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Stack(
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
                  padding: const EdgeInsets.only(top: 60, left: 5),
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
                    child: const Text(
                      "Withdraw",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          child: const Text(
                            "Tour Balance :",
                            style: TextStyle(
                              color: Color.fromARGB(255, 207, 201, 201),
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          )),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            getINRTypeValue(rupees: widget.maxAmount),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          )),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 226, 224, 224),
                          blurRadius: 5.0,
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "Withdraw Amount",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/w_icon1.png",
                              height: 55,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: const Icon(Icons.arrow_forward),
                            ),
                            Image.asset(
                              "assets/w_icon2.png",
                              height: 55,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 15),
                        child: const Text(
                          "Withdraw Profit from Wallet",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 120),
                        alignment: Alignment.center,
                        child: TextFormField(
                          controller: amountController,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                          cursorHeight: 25,
                          cursorWidth: 2,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                          onChanged: (v) {
                            if (v.isNotEmpty) {
                              if (int.parse(v) >= widget.maxAmount) {
                                amountController.text =
                                    widget.maxAmount.toInt().toString();
                                amountController.selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset: amountController.text.length));
                              }
                            }
                          },
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                              hintText: "₹",
                              hintStyle:
                                  TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(
                        width: 170,
                        height: 38,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                const Color.fromRGBO(235, 229, 241, 10),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                            onPressed: () {
                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (context) => My_profile()));
                            },
                            child: const Text(
                              "UPI ID",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(63, 81, 181, 1),
                              ),
                            )),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Scan QR",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 17,
                                color: Colors.grey),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            width: 90,
            height: 45,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color(0xff224389),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              onPressed: () async {
                if (amountController.text.isEmpty) {
                  showToast(
                      context: context,
                      msg: "Please enter withdrawal amount!",
                      isError: true);
                } else if (widget.withdrawType ==
                    WithdrawType.capital_withdrawal) {
                  await WithdrawalRepository.capitalWithdrawal(
                      context: context,
                      planId:
                          int.parse(widget.withdrawalDatum.planId.toString()),
                      bankId: int.parse(widget.bankDatum.userBankId.toString()),
                      withdrawalAmount: double.parse(amountController.text),
                      accountNumber: int.parse(
                        widget.bankDatum.bankAccountNumber.toString(),
                      ));
                } else if (widget.withdrawType ==
                    WithdrawType.profit_withdrawal) {
                  await WithdrawalRepository.profitWithdrawal(
                      context: context,
                      planId:
                          int.parse(widget.withdrawalDatum.planId.toString()),
                      bankId: int.parse(widget.bankDatum.userBankId.toString()),
                      withdrawalAmount: double.parse(amountController.text),
                      accountNumber: int.parse(
                        widget.bankDatum.bankAccountNumber.toString(),
                      ));
                }
              },
              child: const Icon(
                Icons.arrow_forward,
              ),
            ),
          ),
        ),
      ],
    ));
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;

    var path = Path();
    path.lineTo(0, height - 50);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}
