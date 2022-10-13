import 'package:atm/First_pages/deposite_screen.dart';
import 'package:atm/Profile_page/Add_bank_account.dart';
import 'package:atm/models/app_update/razorpay_config_model.dart';
import 'package:atm/models/bank/bank_model.dart';
import 'package:atm/models/withdrawal/get_withdrawal_list_model.dart';
import 'package:atm/repository/app_update_repository.dart';
import 'package:atm/repository/bank_repository.dart';
import 'package:atm/repository/withdrawal_repository.dart';
import 'package:atm/utils/loading_view.dart';
import 'package:atm/utils/page_navigator.dart';
import 'package:atm/utils/show_toast.dart';
import 'package:atm/utils/type_strings.dart';
import 'package:atm/withdraw/withdraw_screen.dart';
import 'package:flutter/material.dart';

class WithdrawTab extends StatefulWidget {
  const WithdrawTab({Key? key}) : super(key: key);

  @override
  State<WithdrawTab> createState() => _WithdrawTabState();
}

class _WithdrawTabState extends State<WithdrawTab> {
  String choice = '';
  String select = '';

  GetWithdrawalListModel? withdrawalListModel;

  @override
  void initState() {
    getWithdrawalData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: withdrawalListModel == null
          ? const Center(child: LoadingView())
          : Stack(
              children: [
                ClipPath(
                  clipper: CustomShape(),
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    color: const Color.fromRGBO(63, 81, 181, 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            // Container(
                            //   margin: const EdgeInsets.only(top: 45, right: 110),
                            //   child: IconButton(
                            //       onPressed: () {
                            //         Navigator.push(
                            //             context,
                            //             MaterialPageRoute(
                            //               builder: (context) => const home(),
                            //             ));
                            //       },
                            //       icon: const Icon(
                            //         Icons.arrow_back_ios_new,
                            //         color: Colors.white,
                            //       )),
                            // ),
                            SafeArea(
                              child: Container(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  top: 50,
                                ),
                                child: const Text(
                                  "Withdraw",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                withdrawalListModel!.withdrawalData!.isEmpty
                    ? Column(
                        children: [
                          Center(
                            child: Container(
                              padding: const EdgeInsets.only(top: 400),
                              child: const Text(
                                "No bank found yet!",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            ...List.generate(
                              withdrawalListModel!.withdrawalData!.length,
                              (index) => Container(
                                margin: EdgeInsets.only(
                                  top: index == 0 ? 180 : 10,
                                  left: 10,
                                  right: 10,
                                ),
                                padding: const EdgeInsets.all(15),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 226, 224, 224),
                                      blurRadius: 5.0,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      withdrawalListModel!
                                          .withdrawalData![index].planName!
                                          .toLowerCase(),
                                      style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          child: Text(
                                            getINRTypeValue(
                                                rupees: double.parse(
                                                        (withdrawalListModel!
                                                                    .withdrawalData![
                                                                        index]
                                                                    .invested ??
                                                                0)
                                                            .toString())
                                                    .abs()),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, top: 10),
                                          child: const Text(
                                            "Invested",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          child: const Icon(
                                            Icons.lock,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, top: 12),
                                          child: Text(
                                            "Profit Amount: ${getINRTypeValue(rupees: double.parse((withdrawalListModel!.withdrawalData![index].profit ?? 0).toString()))}",
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 20),
                                          width: 130,
                                          child: ChoiceChip(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 10, left: 28),
                                            shape: const RoundedRectangleBorder(
                                                side: BorderSide(
                                                  width: 1,
                                                  color: Color.fromRGBO(
                                                      63, 81, 181, 1),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                )),
                                            selectedColor: const Color.fromRGBO(
                                                63, 81, 181, 1),
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    63, 81, 181, 1),
                                            label: Row(
                                              children: const [
                                                Text(
                                                  'Deposit',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                            selected: (choice == 'choice 1')
                                                ? true
                                                : false,
                                            onSelected: (bool value) {
                                              showOptionForDeposit(
                                                  withdrawalDatum:
                                                      withdrawalListModel!
                                                              .withdrawalData![
                                                          index]);
                                              setState(() {
                                                choice = 'choice 1';
                                              });
                                            },
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, top: 20),
                                          width: 130,
                                          child: ChoiceChip(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 10, left: 25),
                                            shape: const RoundedRectangleBorder(
                                                side: BorderSide(
                                                  width: 1,
                                                  color: Color.fromRGBO(
                                                      63, 81, 181, 1),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                )),
                                            backgroundColor: Colors.white,
                                            selectedColor: Colors.white,
                                            label: Row(
                                              children: const [
                                                Text(
                                                  'Withdraw',
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          63, 81, 181, 1),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                            selected: (choice == 'choice 2')
                                                ? true
                                                : false,
                                            onSelected: (bool value) {
                                              ///
                                              showOptionForWithdraw(
                                                  index: index);
                                              // PageNavigator.pushPage(context: context, page: const WithdrawScreen());
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
    );
  }

  Future<void> getWithdrawalData() async {
    withdrawalListModel =
        await WithdrawalRepository.getWithdrawalListData(context: context);
    changeState();
  }

  void changeState() {
    if (mounted) {
      setState(() {});
    }
  }

  void showOptionForDeposit({required WithdrawalDatum withdrawalDatum}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      elevation: 10,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.only(top: 20, bottom: 10),
                child: const Text(
                  "Select option for deposit",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              InkWell(
                onTap: () async {
                  RazorPayConfigModel? razorPayConfigModel =
                      await AppUpdateRepository.checkRazorPayConfiguration(
                          context: context);
                  if (razorPayConfigModel != null) {
                    PageNavigator.pop(context: context);
                    if (razorPayConfigModel.data.razorpayStatus == "enable") {
                      PageNavigator.pushPage(
                        context: context,
                        page: DepositScreen(
                          depositType: DepositType.online_deposit,
                          withdrawalDatum: withdrawalDatum,
                          razorPayConfigModel: razorPayConfigModel,
                        ),
                      ).whenComplete(() {
                        getWithdrawalData();
                      });
                    } else {
                      showToast(
                          context: context,
                          msg: "Online deposit will be available soon!",
                          isError: true);
                    }
                  }
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    children: const [
                      Expanded(child: Text("ONLINE DEPOSITE")),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  RazorPayConfigModel? razorPayConfigModel =
                      await AppUpdateRepository.checkRazorPayConfiguration(
                          context: context);
                  if (razorPayConfigModel != null) {
                    PageNavigator.pop(context: context);
                    PageNavigator.pushPage(
                      context: context,
                      page: DepositScreen(
                        depositType: DepositType.manual_deposit,
                        withdrawalDatum: withdrawalDatum,
                        razorPayConfigModel: razorPayConfigModel,
                      ),
                    ).whenComplete(() {
                      getWithdrawalData();
                    });
                  }
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    children: const [
                      Expanded(child: Text("MANUAL DEPOSIT")),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showOptionForWithdraw({required int index}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      elevation: 10,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.only(top: 20, bottom: 10),
                child: const Text(
                  "Select option for withdrawal",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              InkWell(
                onTap: () {
                  showBankOption(
                      withdrawType: WithdrawType.capital_withdrawal,
                      withdrawalDatum:
                          withdrawalListModel!.withdrawalData![index],
                      amount: double.parse((withdrawalListModel!
                                  .withdrawalData![index].invested ??
                              0)
                          .toString()));
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    children: const [
                      Expanded(child: Text("CAPITAL WITHDRAWAL")),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  showBankOption(
                      withdrawType: WithdrawType.profit_withdrawal,
                      withdrawalDatum:
                          withdrawalListModel!.withdrawalData![index],
                      amount: double.parse(
                          (withdrawalListModel!.withdrawalData![index].profit ??
                                  0)
                              .toString()));
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    children: const [
                      Expanded(child: Text("PROFIT WITHDRAWAL")),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showBankOption(
      {required double amount,
      required WithdrawType withdrawType,
      required WithdrawalDatum withdrawalDatum}) async {
    BankModel? bankModel = await BankRepository.getBankList(context: context);
    if (bankModel != null) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return bankModel.data!.isEmpty
              ? Container(
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(59, 6, 122, 1),
                      ),
                      child: TextButton(
                        onPressed: () {
                          PageNavigator.pushPage(
                              context: context,
                              page: AddBankAccountScreen(
                                  onAddBank: (v) {
                                    if (v) {
                                      print("CALL BACK FOR WITHDRAW PAGE ::");
                                      PageNavigator.pop(context: context);
                                      PageNavigator.pop(context: context);
                                      showBankOption(
                                          amount: amount,
                                          withdrawalDatum: withdrawalDatum,
                                          withdrawType: withdrawType);
                                    }
                                  },
                                  isForEdit: false));
                        },
                        child: const Center(
                          child: Text(
                            'Add Bank',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(
                  decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30)),
                      color: Colors.white),
                  child: ListView.builder(
                    itemCount: bankModel.data!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          PageNavigator.pushPage(
                            context: context,
                            page: WithdrawScreen(
                              withdrawType: withdrawType,
                              withdrawalDatum: withdrawalDatum,
                              bankDatum: bankModel.data![index],
                              maxAmount: amount,
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 15, top: 15, bottom: 15),
                          margin: const EdgeInsets.only(
                              top: 18, left: 20, right: 20),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 226, 224, 224),
                                blurRadius: 5.0,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Image.network(
                                bankModel.data![index].bankLogo ?? "--",
                                height: 50,
                                width: 50,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      bankModel.data![index]
                                              .bankAccountHolderName ??
                                          "--",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Text(
                                        "**********${bankModel.data![index].bankAccountNumber!.replaceRange(0, 8, "")}",
                                        style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 112, 108, 108),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      bankModel.data![index].bankName ?? "--",
                                      style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 112, 108, 108),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
        },
      );
    }
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
