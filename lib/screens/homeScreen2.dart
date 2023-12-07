import 'package:choosenumber/constants.dart';
import 'package:choosenumber/controller/auth_controller.dart';
import 'package:choosenumber/controller/reservation_controller.dart';

import 'package:choosenumber/res/colors.dart';
import 'package:choosenumber/res/strings.dart';

import 'package:choosenumber/screens/change_password.dart';
import 'package:choosenumber/screens/reservationScreen.dart';
import 'package:choosenumber/screens/tableScreen.dart';
import 'package:choosenumber/screens/homeScreen2.dart';

import 'package:choosenumber/utils/sizes.dart';
import 'package:choosenumber/utils/theme_helper.dart';
import 'package:choosenumber/widgets/card_option.dart';
import 'package:choosenumber/widgets/inputParentWidget.dart';
import 'package:choosenumber/widgets/inputTextWidget.dart';
import 'package:choosenumber/widgets/loadingIndicator.dart';
import 'package:choosenumber/widgets/radio_options.dart';
import 'package:choosenumber/widgets/submitButton.dart';
import 'package:choosenumber/widgets/text_styled.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:choosenumber/res/colors.dart' as res;

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final authController = Get.find<AuthController>();
  String citeria = criteriaList.first.text;
  var searchCtr = TextEditingController();
  var resController = Get.put(ReservationController());
  String category = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return SafeArea(
      child: Scaffold(
        /* floatingActionButton: FloatingActionButton(
          mini: true,
          backgroundColor: whiteColor.withOpacity(0.8),
          child: const Icon(
            Icons.sync,
            color: primaryColor,
          ),
          onPressed: () {
            print("pressed");

            //Get.to(()=>const AgentsScreen());
          },
        ),*/
        key: _key,
        //drawer: ExampleSidebarX(controller: _controller),
        body: Container(
          height: Get.height,
          width: Get.width,
          decoration: const BoxDecoration(
              /*image: DecorationImage(
                image: AssetImage('assets/images/wa_bg.jpg'),
                fit: BoxFit.cover),*/
              color: primaryWhite),
          child: Container(
            child: Stack(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            //Get.to(() => WelcomeScreen());
                            //_key.currentState!.openDrawer();
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: boxDecorationWithRoundedCorners(
                              backgroundColor: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.2)),
                            ),
                            child: const Icon(
                              Icons.menu,
                              color: primaryColor,
                            ),
                          )),
                      GestureDetector(
                          onTap: (() {
                            authController.logoff();
                          }),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: boxDecorationWithRoundedCorners(
                              backgroundColor: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.2)),
                            ),
                            alignment: Alignment.center,
                            child:
                                const Icon(Icons.logout, color: res.errorColor),
                          ))
                    ],
                  ).paddingOnly(left: 16, right: 16, bottom: 16),
                  Text('${authController.user.value!.name},',
                          style: secondaryTextStyle())
                      .paddingOnly(left: 16, right: 16),
                  /*Text('Benay Mampuya,', style: secondaryTextStyle())
                      .paddingOnly(left: 16, right: 16),*/
                  /* Text('bnseye', style: boldTextStyle(size: 20))
                      .paddingOnly(left: 16, right: 16),*/
                  20.height,

                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              textStyled("Choose numbers", 30, primaryColor,
                                  secondaryColor),
                              20.height,
                              CardOption(
                                  row: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      MyRadioOption(
                                        value: criteriaList.first.text,
                                        groupValue: citeria,
                                        label: criteriaList.first.text,
                                        onChanged: ((value) {
                                          setState(() {
                                            citeria = value!;
                                          });
                                        }),
                                      ),
                                      MyRadioOption(
                                        value: criteriaList[1].text,
                                        groupValue: citeria,
                                        label: criteriaList[1].text,
                                        onChanged: ((value) {
                                          setState(() {
                                            citeria = value!;
                                          });
                                        }),
                                      ),
                                      MyRadioOption(
                                        value: criteriaList.last.text,
                                        groupValue: citeria,
                                        label: criteriaList.last.text,
                                        onChanged: ((value) {
                                          setState(() {
                                            citeria = value!;
                                          });
                                        }),
                                      )
                                    ],
                                  ),
                                  textheader: "Criteria"),
                              8.height,
                              Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  elevation: 0.5,
                                  color: secondaryColor,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 20, bottom: 20),
                                    child: Column(
                                      children: [
                                        InputParentWidget(
                                            child: DropdownSearch<String>(
                                          items: const [
                                            "Normal",
                                            "Golden",
                                            "Sylver",
                                            "Platinum",
                                            "Super Platinum",
                                          ],
                                          dropdownDecoratorProps:
                                              const DropDownDecoratorProps(
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                              icon: Icon(
                                                Icons.arrow_downward,
                                                color: primaryColor,
                                                size:
                                                    32.0, /*Color(0xff224597)*/
                                              ),
                                              labelText: "Category (optional)",
                                              labelStyle: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 18.0),
                                              hintText: '',
                                              enabledBorder: InputBorder.none,
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black54),
                                              ),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                          onChanged: (zn) {
                                            if (zn != null) {
                                              category = zn;
                                              resController.category.value = zn;
                                            } else {
                                              resController.category.value = zn;
                                            }
                                          },
                                          clearButtonProps:
                                              const ClearButtonProps(
                                            icon: Icon(Icons.clear),
                                            isVisible: true,
                                            autofocus: true,
                                          ),
                                          //selectedItem: "M",
                                          validator: (item) {
                                            /*if (item == null) {
                                    return "Required field";
                                  } else {
                                    return null;
                                  }*/
                                          },
                                        )),
                                        25.height,
                                        InputTextWidget(
                                            controller:
                                                resController.search.value,
                                            labelText: citeria,
                                            icon: Icons.search,
                                            obscureText: false,
                                            keyboardType: TextInputType.number),
                                        25.height,
                                        Obx(() {
                                          return resController
                                                  .process_load_avail.isTrue
                                              ? LoadingIndicator(
                                                  text: "please wait..")
                                              : SubmitButton(
                                                  onPressed: () {
                                                    //Get.to(() => HomeScreen2());
                                                    var form =
                                                        _formKey.currentState;
                                                    if (form!.validate()) {
                                                      resController.crieria
                                                          .value = citeria;
                                                      resController
                                                          .findNumbers();
                                                      /*Get.to(
                                                          () => TableScreen());*/
                                                    }
                                                  },
                                                  text: 'Search',
                                                  bgColor: primaryColor,
                                                );
                                        })
                                      ],
                                    ),
                                  )),
                            ],
                          )),
                    ),
                  ),
                  //const Spacer(),
                ],
              ),
              /* Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Image.asset(
                      "assets/images/africell_logo.png",
                      width: 100,
                    )),
              )*/
            ]),
          ),
        ),
      ),
    );
  }
}
