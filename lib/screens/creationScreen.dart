import 'package:choosenumber/constants.dart';
import 'package:choosenumber/controller/reservation_controller.dart';
import 'package:choosenumber/res/colors.dart';
import 'package:choosenumber/widgets/card_option.dart';
import 'package:choosenumber/widgets/inputDecoration.dart';
import 'package:choosenumber/widgets/inputTextNoPadding.dart';
import 'package:choosenumber/widgets/inputTextWidget.dart';
import 'package:choosenumber/widgets/loadingIndicator.dart';
import 'package:choosenumber/widgets/radio_options.dart';
import 'package:choosenumber/widgets/submitButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class CreationScreen extends StatefulWidget {
  const CreationScreen({super.key});

  @override
  State<CreationScreen> createState() => _CreationScreenState();
}

class _CreationScreenState extends State<CreationScreen> {
  var resController = Get.find<ReservationController>();
  String resType = reservationTypes.first;
  var msisdnContrllers = <TextEditingController>[];
  var iccidContrllers = <TextEditingController>[];

  final _formKey = GlobalKey<FormState>();

  getTextEditControllers() {
    int i = 0;
    print('length: ${resController.listChosen.value.length}');
    resController.listChosen.value.forEach((element) {
      iccidContrllers.add(TextEditingController());
      iccidContrllers[i] = TextEditingController();
      i++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    //saleController.process_sale.value = false;
    print(resController.rerseveListChosen.value.length);

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text("Creation",
            style: TextStyle(
              color: primaryWhite,
              fontFamily: 'Segoe UI',
              fontSize: 30,
              shadows: [
                Shadow(
                  color: Color(0xba000000),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                )
              ],
            )),
        //centerTitle: true,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back, color: primaryWhite),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          width: screenWidth,
          height: screenHeight,
          child:
              //controller: controller,
              Container(
                  child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 30.0,
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Expanded(
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 0.5,
                        color: secondaryColor,
                        child: Padding(
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            child: resController.rerseveListChosen.value.isEmpty
                                ? Text("Empty List")
                                : Column(
                                    children: [
                                      Expanded(
                                          child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: resController
                                            .rerseveListChosen.value.length,
                                        itemBuilder: (context, index) {
                                          print(index);
                                          msisdnContrllers
                                              .add(TextEditingController());
                                          /*msisdnContrllers[index] =
                                            TextEditingController();*/

                                          msisdnContrllers[index].text =
                                              resController.rerseveListChosen
                                                  .value[index].msisdn!;
                                          return Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 12),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 12,
                                                            right: 12),
                                                    child: Text(
                                                        '${resController.rerseveListChosen.value[index].msisdn!}'),
                                                  ),
                                                  Expanded(
                                                      child: TextFormField(
                                                    validator: (value) => value !=
                                                                null &&
                                                            (value!.length <
                                                                    10 ||
                                                                value!.length >
                                                                    10)
                                                        ? "Must be 10 digits"
                                                        : null,
                                                    controller: resController
                                                        .rerseveListChosen
                                                        .value[index]
                                                        .iccidController,
                                                    decoration: inputDecoration(
                                                        "ICCID",
                                                        Icons.sim_card),
                                                  )
                                                      /* child: InputTextNoPadding(
                                                          controller:
                                                              resController
                                                                  .adressCompany
                                                                  .value,
                                                          labelText: "ICCID",
                                                          icon: Icons
                                                              .text_snippet,
                                                          obscureText: false,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number)*/
                                                      ),
                                                  10.width
                                                ],
                                              ));
                                        },
                                      )),
                                      const SizedBox(
                                        height: 12.0,
                                      ),

                                      /*InputTextWidget(
                      controller: saleController.iccidEnd.value,
                      labelText: "ICCID end",
                      icon: Icons.sim_card,
                      obscureText: false,
                      keyboardType: TextInputType.number,

                      ),*/

                                      Obx(() {
                                        //calculQty();
                                        return resController
                                                .process_add_creations.isTrue
                                            ? LoadingIndicator(
                                                text: "Sending...")
                                            : SubmitButton(
                                                onPressed: () async {
                                                  print(resController
                                                      .rerseveListChosen
                                                      .value[0]
                                                      .iccidController
                                                      .text);
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    resController
                                                        .rerseveListChosen.value
                                                        .forEachIndexed(
                                                            (element, index) {
                                                      element.iccid =
                                                          resController
                                                              .rerseveListChosen
                                                              .value[index]
                                                              .iccidController
                                                              .text;
                                                    });
                                                    print(resController
                                                        .rerseveListChosen
                                                        .value
                                                        .last
                                                        .iccid);
                                                  }
                                                  resController.addCreation();
                                                },
                                                text: "Save",
                                                bgColor: primaryColor,
                                              );
                                      })
                                    ],
                                  )))),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
