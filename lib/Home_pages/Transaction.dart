import 'package:atm/Home_pages/Home.dart';
import 'package:atm/Home_pages/withdraw_tab.dart';
import 'package:atm/models/transaction/transaction_model.dart';
import 'package:atm/repository/transaction_repository.dart';
import 'package:atm/utils/loading_view.dart';
import 'package:atm/withdraw/withdraw_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaction extends StatefulWidget {
  const Transaction({Key? key}) : super(key: key);

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  TransactionModel? _transactionModel;

  @override
  void initState() {
    getTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _transactionModel == null
          ? const Center(child: LoadingView())
          : SingleChildScrollView(
              child: Stack(
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
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 40, right: 150),
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const home(),
                                          ));
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back_ios_new,
                                      color: Colors.white,
                                    )),
                              ),
                              SafeArea(
                                child: Container(
                                  padding:
                                      const EdgeInsets.only(left: 15, top: 0),
                                  child: const Text(
                                    "Transaction",
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
                  _transactionModel!.transactionData!.isEmpty
                      ? Column(
                          children: [
                            Center(
                              child: Container(
                                padding: EdgeInsets.only(top: 400),
                                child: const Text(
                                  "No transactions found yet!",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ...List.generate(
                                _transactionModel!.transactionData!.length,
                                (index) => Container(
                                      height: 100,
                                      width: 400,
                                      margin: EdgeInsets.only(
                                          top: index == 0 ? 180 : 10,
                                          left: 10,
                                          right: 10),
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 226, 224, 224),
                                              blurRadius: 5.0,
                                            ),
                                          ]),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 10, left: 15),
                                            child: Text(
                                              _transactionModel!
                                                      .transactionData![index]
                                                      .transactionId ??
                                                  "--",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                child: Image.asset(
                                                  "assets/Transaction_image2.png",
                                                  height: 70,
                                                  width: 70,
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 5, right: 8),
                                                      child: Text(
                                                        "Interested From ${_transactionModel!.transactionData![index].planName ?? "--"}",
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 3),
                                                      child: Text(
                                                        DateFormat(
                                                                "dd MMM  yyyy")
                                                            .format(
                                                                DateTime.now()),
                                                        style: const TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 35),
                                                child: Text(
                                                  "+${_transactionModel!.transactionData![index].amount}",
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ))
                          ],
                        )
                ],
              ),
            ),
    );
  }

  Future<void> getTransactions() async {
    _transactionModel =
        await TransactionRepository.getTransactions(context: context);
    changeState();
  }

  void changeState() {
    if (mounted) {
      setState(() {});
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
