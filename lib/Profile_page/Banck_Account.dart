import 'package:atm/Profile_page/Add_bank_account.dart';
import 'package:atm/models/bank/bank_model.dart';
import 'package:atm/repository/bank_repository.dart';
import 'package:atm/utils/loading_view.dart';
import 'package:atm/utils/page_navigator.dart';
import 'package:flutter/material.dart';

class BankAccountScreen extends StatefulWidget {
  const BankAccountScreen({Key? key}) : super(key: key);

  @override
  State<BankAccountScreen> createState() => _BankAccountScreenState();
}

class _BankAccountScreenState extends State<BankAccountScreen> {
  BankModel? bankModel;

  @override
  void initState() {
    getBankList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            clipper: CustomShape(),
            child: Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              color: const Color.fromRGBO(63, 81, 181, 1),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SafeArea(
                    child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: IconButton(
                      onPressed: () {
                        PageNavigator.pop(context: context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      )),
                )),
                Container(
                    alignment: Alignment.centerLeft,
                    padding:
                        const EdgeInsets.only(top: 10, bottom: 10, left: 20),
                    child: const Text(
                      "Bank Account",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                Expanded(
                  child: bankModel == null
                      ? const Center(
                          child: LoadingView(),
                        )
                      : bankModel!.data!.isEmpty
                          ? Column(
                              children: [
                                Center(
                                  child: Container(
                                    padding: const EdgeInsets.only(top: 200),
                                    child: const Text(
                                      "No bank found yet!",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : ListView.builder(
                              itemCount: bankModel!.data!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.only(
                                      left: 15, top: 15, bottom: 15),
                                  margin: const EdgeInsets.only(
                                      top: 18, left: 20, right: 20),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromARGB(
                                              255, 226, 224, 224),
                                          blurRadius: 5.0,
                                        ),
                                      ]),
                                  child: Row(
                                    children: [
                                      Image.network(
                                        bankModel!.data![index].bankLogo ??
                                            "--",
                                        height: 50,
                                        width: 50,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              bankModel!.data![index]
                                                      .bankAccountHolderName ??
                                                  "--",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              child: Text(
                                                "**********${bankModel!.data![index].bankAccountNumber!.replaceRange(0, 8, "")}",
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 112, 108, 108),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              bankModel!
                                                      .data![index].bankName ??
                                                  "--",
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 112, 108, 108),
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
                                      PopupMenuButton<int>(
                                        color: Colors.white,
                                        onSelected: (item) async {
                                          if (item == 0) {
                                            PageNavigator.pushPage(
                                                context: context,
                                                page: AddBankAccountScreen(
                                                  isForEdit: true,
                                                  bankModel:
                                                      bankModel!.data![index],
                                                  onAddBank: (v) {
                                                    if (v) {
                                                      getBankList();
                                                      PageNavigator.pop(
                                                          context: context);
                                                    }
                                                  },
                                                ));
                                          } else if (item == 1) {
                                            await BankRepository.deleteBank(
                                                context: context,
                                                bankId: bankModel!
                                                    .data![index].userBankId!,
                                                onDelete: (v) async {
                                                  if (v) {
                                                    await getBankList();
                                                  }
                                                });
                                          }
                                        },
                                        child: const Icon(Icons.more_vert),
                                        itemBuilder: (context) => [
                                          const PopupMenuItem<int>(
                                            value: 0,
                                            child: Text('Edit'),
                                          ),
                                          const PopupMenuItem<int>(
                                            value: 1,
                                            child: Text('Delete'),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                );
                              }),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(63, 81, 181, 1),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        PageNavigator.pushPage(
                            context: context,
                            page: AddBankAccountScreen(
                              isForEdit: false,
                              bankModel: null,
                              onAddBank: (v) {
                                if (v) {
                                  getBankList();
                                  PageNavigator.pop(context: context);
                                }
                              },
                            ));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: const Text(
                          "ADD BANK ACCOUNT",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> getBankList() async {
    bankModel = await BankRepository.getBankList(context: context);
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
