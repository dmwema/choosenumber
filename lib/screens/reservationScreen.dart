import 'package:choosenumber/constants.dart';
import 'package:choosenumber/controller/reservation_controller.dart';
import 'package:choosenumber/res/colors.dart';
import 'package:choosenumber/widgets/card_option.dart';
import 'package:choosenumber/widgets/inputTextWidget.dart';
import 'package:choosenumber/widgets/loadingIndicator.dart';
import 'package:choosenumber/widgets/radio_options.dart';
import 'package:choosenumber/widgets/submitButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  final _formKey = GlobalKey<FormState>();
  var resController = Get.put(ReservationController());
  String resType = reservationTypes.first;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    //saleController.process_sale.value = false;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text("Reservation",
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
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          width: screenWidth,
          height: screenHeight,
          child: SingleChildScrollView(
            //controller: controller,
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
                  CardOption(
                      row: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MyRadioOption(
                            value: reservationTypes.first,
                            groupValue: resType,
                            label: reservationTypes.first,
                            onChanged: ((value) {
                              setState(() {
                                resType = value!;
                              });
                            }),
                          ),
                          MyRadioOption(
                            value: reservationTypes.last,
                            groupValue: resType,
                            label: reservationTypes.last,
                            onChanged: ((value) {
                              setState(() {
                                resType = value!;
                              });
                            }),
                          ),
                        ],
                      ),
                      textheader: "Type"),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 0.5,
                      color: secondaryColor,
                      child: Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: Column(
                            children: [
                              resType == reservationTypes.first
                                  ? Column(
                                      children: [
                                        InputTextWidget(
                                          controller: resController
                                              .clientFirstName.value,
                                          labelText: "First Name",
                                          icon: Icons.person,
                                          obscureText: false,
                                          keyboardType: TextInputType.name,
                                          readOnly: false,
                                        ),
                                        const SizedBox(
                                          height: 12.0,
                                        ),
                                        InputTextWidget(
                                          controller: resController
                                              .clientMiddleName.value,
                                          labelText: "Middle Name",
                                          icon: Icons.person,
                                          obscureText: false,
                                          keyboardType: TextInputType.name,
                                          readOnly: false,
                                        ),
                                        const SizedBox(
                                          height: 12.0,
                                        ),
                                        InputTextWidget(
                                          controller: resController
                                              .clientLastName.value,
                                          labelText: "Last Name",
                                          icon: Icons.person,
                                          obscureText: false,
                                          keyboardType: TextInputType.name,
                                          readOnly: false,
                                        ),
                                        const SizedBox(
                                          height: 12.0,
                                        ),
                                        InputTextWidget(
                                          controller: resController
                                              .clientCurrentMobileNumber.value,
                                          labelText: "Mobile number",
                                          icon: Icons.phone,
                                          obscureText: false,
                                          keyboardType: TextInputType.phone,
                                          readOnly: false,
                                        ),
                                        const SizedBox(
                                          height: 12.0,
                                        ),
                                        InputTextWidget(
                                            controller: resController
                                                .clientEmailAdress.value,
                                            labelText: "Email",
                                            icon: Icons.text_decrease,
                                            obscureText: false,
                                            keyboardType:
                                                TextInputType.emailAddress),
                                        const SizedBox(
                                          height: 12.0,
                                        ),
                                        InputTextWidget(
                                            controller: resController
                                                .clientAdress.value,
                                            labelText: "Address",
                                            icon: Icons.home,
                                            obscureText: false,
                                            keyboardType:
                                                TextInputType.emailAddress),
                                        const SizedBox(
                                          height: 12.0,
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        InputTextWidget(
                                            controller:
                                                resController.idnat.value,
                                            labelText: "National ID",
                                            icon: Icons.perm_identity,
                                            obscureText: false,
                                            keyboardType: TextInputType.text),
                                        const SizedBox(
                                          height: 12.0,
                                        ),
                                        InputTextWidget(
                                            controller:
                                                resController.rccm.value,
                                            labelText: "RCCM",
                                            icon: Icons.sell,
                                            obscureText: false,
                                            keyboardType: TextInputType.text),
                                        const SizedBox(
                                          height: 12.0,
                                        ),
                                        InputTextWidget(
                                            controller: resController
                                                .adressCompany.value,
                                            labelText: "Company address",
                                            icon: Icons.location_city,
                                            obscureText: false,
                                            keyboardType:
                                                TextInputType.emailAddress),
                                        const SizedBox(
                                          height: 12.0,
                                        ),
                                      ],
                                    ),
                              InputTextWidget(
                                  controller: resController.numberPurpose.value,
                                  labelText: "Purpose",
                                  icon: Icons.text_snippet,
                                  obscureText: false,
                                  keyboardType: TextInputType.emailAddress),
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
                                return Column(children: [
                                  const SizedBox(
                                    height: 25.0,
                                  ),
                                  resController.process_create.isTrue
                                      ? LoadingIndicator(text: "Sending...")
                                      : SubmitButton(
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              resController.create();
                                            }
                                          },
                                          text: "Save",
                                          bgColor: primaryColor,
                                        ),
                                ]);
                              })
                            ],
                          ))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
