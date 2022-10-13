import 'package:atm/models/bank/bank_model.dart' as bm;
import 'package:atm/models/bank/get_bank_name_logo_model.dart';
import 'package:atm/repository/bank_repository.dart';
import 'package:atm/utils/page_navigator.dart';
import 'package:flutter/material.dart';

class AddBankAccountScreen extends StatefulWidget {
  const AddBankAccountScreen(
      {Key? key,
      required this.onAddBank,
      required this.isForEdit,
      this.bankModel})
      : super(key: key);

  final Function(bool) onAddBank;
  final bool isForEdit;
  final bm.BankDatum? bankModel;

  @override
  State<AddBankAccountScreen> createState() => _AddBankAccountScreenState();
}

class _AddBankAccountScreenState extends State<AddBankAccountScreen> {
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountHolderController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController confirmAccountNumberController =
      TextEditingController();
  final TextEditingController ifscCodeController = TextEditingController();
  GetBankNameLogoModel? getBankNameLogoModel;
  String? bank;

  List<String>? bankName;

  @override
  void initState() {
    setData();
    setBankNameData();
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
              children: [
                InkWell(
                  onTap: () {
                    PageNavigator.pop(context: context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 25),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child:
                        const Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    widget.isForEdit ? "Edit Bank Account" : "Add Bank Account",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Expanded(
                    child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 24,
                            margin: const EdgeInsets.only(left: 20),
                            child: const Text(
                              "Bank Name",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            )),
                        bankName != null
                            ? Container(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                height: 60,
                                margin:
                                    const EdgeInsets.only(left: 19, right: 19),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: const Color.fromRGBO(63, 81, 181, 1),
                                    width: 1.5,
                                  ),
                                ),
                                child: Center(
                                  child: DropdownButton<String>(
                                    value: bank,
                                    underline: Container(),
                                    isExpanded: true,
                                    hint: const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Select bank'),
                                    ),
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: bankName!.map((e) {
                                      return DropdownMenuItem(
                                        value: e.toString(),
                                        child: Text(
                                          e,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      );
                                    }).toList(),
                                    selectedItemBuilder:
                                        (BuildContext context) => bankName!
                                            .map(
                                              (e) => Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  e,
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        bank = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                            height: 24,
                            margin: const EdgeInsets.only(left: 20),
                            child: const Text(
                              "Account Holder Name",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            )),
                        Container(
                          padding: const EdgeInsets.only(left: 19, right: 19),
                          child: TextField(
                            controller: accountHolderController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(63, 81, 181, 1),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(63, 81, 181, 1),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hintText: 'Holder name',
                              hintStyle: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                            height: 24,
                            margin: const EdgeInsets.only(left: 20),
                            child: const Text(
                              "Account Number",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            )),
                        Container(
                          padding: const EdgeInsets.only(left: 19, right: 19),
                          child: TextField(
                            controller: accountNumberController,
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(63, 81, 181, 1),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(63, 81, 181, 1),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hintText: 'Account number',
                              hintStyle: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        //third text field=-=--=-=-=-=--=----=-=-=-=-=-=--=

                        Container(
                            height: 24,
                            margin: const EdgeInsets.only(left: 20),
                            child: const Text(
                              "Confirm Account Number",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            )),
                        Container(
                          padding: const EdgeInsets.only(left: 19, right: 19),
                          child: TextField(
                            controller: confirmAccountNumberController,
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(63, 81, 181, 1),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(63, 81, 181, 1),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hintText: 'Confirm account number',
                              hintStyle: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        //fourth text field=-=-=---==-=-=-=-=--=--=-==-=-=-=-=
                        Container(
                            height: 24,
                            margin: const EdgeInsets.only(left: 20),
                            child: const Text(
                              "IIFC",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            )),
                        Container(
                          padding: const EdgeInsets.only(left: 19, right: 19),
                          child: TextField(
                            controller: ifscCodeController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(63, 81, 181, 1),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(63, 81, 181, 1),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hintText: 'IIFC',
                              hintStyle: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            if (widget.isForEdit) {
                              await BankRepository.editBank(
                                  context: context,
                                  bankId: widget.bankModel!.userBankId!,
                                  bankName: bank!,
                                  bankAccountName: accountHolderController.text,
                                  bankAccountNumber:
                                      accountNumberController.text,
                                  confirmBankNumber:
                                      confirmAccountNumberController.text,
                                  bankIFSC: ifscCodeController.text,
                                  onAddBank: widget.onAddBank);
                            } else {
                              await BankRepository.addBank(
                                  context: context,
                                  bankName: bank!,
                                  bankAccountName: accountHolderController.text,
                                  bankAccountNumber:
                                      accountNumberController.text,
                                  confirmBankNumber:
                                      confirmAccountNumberController.text,
                                  bankIFSC: ifscCodeController.text,
                                  onAddBank: widget.onAddBank);
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            decoration: const BoxDecoration(
                                color: Color.fromRGBO(63, 81, 181, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Center(
                              child: Text(
                                widget.isForEdit ? "EDIT BANK" : "ADD BANK",
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  setData() {
    if (widget.isForEdit) {
      bank = widget.bankModel!.bankName!;
      accountHolderController.text = widget.bankModel!.bankAccountHolderName!;
      accountNumberController.text = widget.bankModel!.bankAccountNumber!;
      confirmAccountNumberController.text =
          widget.bankModel!.bankAccountNumber!;
      ifscCodeController.text = widget.bankModel!.bankIfsc!;
      changeState();
    }
  }

  setBankNameData() async {
    getBankNameLogoModel =
        await BankRepository.getBankNameLogo(context: context);
    bankName = getBankNameLogoModel!.bankData!
        .map((e) => e.bankName.toString())
        .toList();
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
