import 'package:atm/First_pages/Login_page.dart';
import 'package:atm/First_pages/My_drawer.dart';
import 'package:atm/First_pages/deposite_screen.dart';
import 'package:atm/Home_pages/Profile.dart';
import 'package:atm/Home_pages/Refer.dart';
import 'package:atm/Home_pages/Transaction.dart';
import 'package:atm/Home_pages/withdraw_tab.dart';
import 'package:atm/models/app_update/razorpay_config_model.dart';
import 'package:atm/models/dashboard/dashboard_model.dart';
import 'package:atm/models/withdrawal/get_withdrawal_list_model.dart';
import 'package:atm/repository/app_update_repository.dart';
import 'package:atm/repository/home_repository.dart';
import 'package:atm/utils/loading_view.dart';
import 'package:atm/utils/page_navigator.dart';
import 'package:atm/utils/show_toast.dart';
import 'package:atm/utils/type_strings.dart';
import 'package:flutter/material.dart';

// import 'package:atm/drawer/my_drawer.dart';
class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  DashboardModel? _dashboardModel;

  @override
  void initState() {
    getDashboardData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Investments"),
        elevation: 0,
        backgroundColor: Color.fromRGBO(63, 81, 181, 1),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [my_drawer(), mydrawerList()],
            ),
          ),
        ),
      ),
      body: _dashboardModel == null
          ? const Center(child: LoadingView())
          : Stack(
              children: [
                ClipPath(
                  clipper: CustomShape(),
                  child: Container(
                    height: 165,
                    width: MediaQuery.of(context).size.width,
                    color: Color.fromRGBO(63, 81, 181, 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: 7,
                                      right: 7,
                                    ),
                                    margin: EdgeInsets.only(left: 10, top: 20),
                                    height: 60,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Text(
                                              "Deposits Above 500 Require KYC"),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Container(
                                            padding: EdgeInsets.only(
                                                left: 4, right: 4),
                                            height: 40,
                                            decoration: const BoxDecoration(
                                              color: Color.fromRGBO(
                                                  228, 230, 234, 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(7)),
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  child: Text("Verify Now"),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Container(
                                                  child:
                                                      Icon(Icons.info_outline),
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              )
                              // Container(
                              //   padding: const EdgeInsets.only(
                              //     top: 105,
                              //     left: 15,
                              //   ),
                              //   child: Text(
                              //     getINRTypeValue(
                              //         rupees:
                              //             _dashboardModel!.balance!.toDouble()),
                              //     style: const TextStyle(
                              //         color: Colors.white,
                              //         fontSize: 30,
                              //         fontWeight: FontWeight.w500),
                              //   ),
                              // ),
                              // Container(
                              //   padding: const EdgeInsets.only(
                              //     right: 7,
                              //     left: 15,
                              //   ),
                              //   child: const Text(
                              //     "Total Balance",
                              //     style: TextStyle(
                              //       color: Colors.grey,
                              //       fontSize: 18,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        // Container(
                        //   padding: const EdgeInsets.only(top: 5, right: 15),
                        //   child: ClipRRect(
                        //     borderRadius: BorderRadius.circular(20),
                        //     child: SizedBox.fromSize(
                        //       size: const Size.fromRadius(30),
                        //       child: Image.asset("assets/children.png",
                        //           fit: BoxFit.cover),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          bottom: 10, left: 10, right: 10, top: 10),
                      margin:
                          const EdgeInsets.only(top: 100, left: 10, right: 10),
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
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 15,
                                    width: 15,
                                    decoration: const BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10),
                                        child: const Text(
                                          "Active plan",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 5),
                                        child: Text(
                                          getINRTypeValue(
                                              rupees: _dashboardModel!
                                                  .totalCapital!
                                                  .toDouble()),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 15,
                                    width: 15,
                                    decoration: const BoxDecoration(
                                        color: Color.fromRGBO(63, 81, 181, 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 10),
                                        child: const Text(
                                          "Wallet Balance",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 5),
                                        child: Text(
                                          getINRTypeValue(
                                              rupees: _dashboardModel!
                                                  .totalEarning!
                                                  .toDouble()),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const Divider(
                            height: 20,
                            thickness: 0.10,
                            indent: 0,
                            endIndent: 0,
                            color: Colors.black,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 15,
                                    width: 15,
                                    decoration: const BoxDecoration(
                                        color: Color.fromRGBO(63, 81, 181, 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10),
                                        child: const Text(
                                          "Your Deposit",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 5),
                                        child: Text(
                                          getINRTypeValue(
                                              rupees: _dashboardModel!
                                                  .totalCapital!
                                                  .toDouble()),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 15,
                                    width: 15,
                                    decoration: const BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(right: 25),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: const Text(
                                                "Total Erned",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 10, top: 5),
                                              child: Text(
                                                getINRTypeValue(
                                                    rupees: _dashboardModel!
                                                        .totalEarning!
                                                        .toDouble()),
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // Column(
                          //   children: [
                          //     Text(
                          //       "You spent  ₹1,200 on dining out this month. Let's try to make it lower",
                          //       style: TextStyle(
                          //           fontSize: 16,
                          //           fontWeight: FontWeight.w300,
                          //           color: Colors.grey.shade600),
                          //     ),
                          //     Container(
                          //       padding: const EdgeInsets.only(top: 5),
                          //       alignment: Alignment.topLeft,
                          //       child: TextButton(
                          //         onPressed: () {},
                          //         child: const Text(
                          //           "Tell me more",
                          //           style: TextStyle(
                          //             color: Color(0xff224389),
                          //             fontSize: 15,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 15),
                      child: const Text("Investment Plans",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600)),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: _dashboardModel!.planData!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 10),
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(255, 226, 224, 224),
                                  blurRadius: 40.0,
                                ),
                              ],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                              image: DecorationImage(
                                  image: NetworkImage(
                                    _dashboardModel!
                                        .planData![index].planBanner!,
                                  ),
                                  fit: BoxFit.cover),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    _dashboardModel!
                                            .planData![index].planName ??
                                        "--",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Row(
                                    children: [
                                      Container(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: const Icon(Icons.access_time)),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  right: 8,
                                                  bottom: 3,
                                                  left: 10),
                                              child: Text(
                                                "${_dashboardModel!.planData![index].planMonthlyMinReturn ?? "--"}-${_dashboardModel!.planData![index].planMonthlyMaxReturn ?? "--"}% Monthly",
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text(
                                                "Min Deposit: ₹${_dashboardModel!.planData![index].planMinimumAmount ?? "--"}",
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          height: 35,
                                          width: 100,
                                          margin:
                                              const EdgeInsets.only(left: 35),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: const Color.fromRGBO(
                                                    63, 81, 181, 1),
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5))),
                                          child: TextButton(
                                            onPressed: () {
                                              showOptionForDeposit(
                                                withdrawalDatum:
                                                    WithdrawalDatum(
                                                  planId: _dashboardModel!
                                                      .planData![index].planId,
                                                  planName: _dashboardModel!
                                                      .planData![index]
                                                      .planName,
                                                  planDescription:
                                                      _dashboardModel!
                                                          .planData![index]
                                                          .planDescription,
                                                  planMinimumAmount:
                                                      _dashboardModel!
                                                          .planData![index]
                                                          .planMinimumAmount,
                                                  planMonthlyMinReturn:
                                                      _dashboardModel!
                                                          .planData![index]
                                                          .planMonthlyMinReturn,
                                                  planMonthlyMaxReturn:
                                                      _dashboardModel!
                                                          .planData![index]
                                                          .planMonthlyMaxReturn,
                                                  planBanner: _dashboardModel!
                                                      .planData![index]
                                                      .planBanner,
                                                  invested: _dashboardModel!
                                                      .planData![index]
                                                      .invested,
                                                  profit: _dashboardModel!
                                                      .planData![index].profit,
                                                ),
                                              );
                                            },
                                            child: const Text(
                                              "Invest",
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    63, 81, 181, 1),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  Future<void> getDashboardData() async {
    _dashboardModel = await HomeRepository.getDashboardData(context: context);
    refreshState();
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
                        getDashboardData();
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
                      getDashboardData();
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

  void refreshState() {
    if (mounted) {
      setState(() {});
    }
  }

  Widget mydrawerList() {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          menuItem(),
        ],
      ),
    );
  }

  Widget menuItem() {
    return Material(
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.home),
              title: Text(
                "Home",
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => home()));
              },
            ),
            ListTile(
              leading: Icon(Icons.assignment),
              title: Text(
                "Transactions",
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Transaction()));
              },
            ),
            ListTile(
              leading: Icon(Icons.card_giftcard),
              title: Text(
                "Refer n Eaen",
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Refer()));
              },
            ),
            ListTile(
              leading: Icon(Icons.domain_verification),
              title: Text(
                "Withdraw Profit",
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WithdrawTab()));
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_support),
              title: Text(
                "Help & Support",
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                // Navigator.push(context,
                //           MaterialPageRoute(builder: (context) => ()));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                "Settings",
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.input_outlined,
              ),
              title: Text(
                "Logout",
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ],
        ),
      ),
    );
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
