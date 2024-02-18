import 'package:choosenumber/constants.dart';
import 'package:choosenumber/controller/auth_controller.dart';
import 'package:choosenumber/controller/reservation_controller.dart';
import 'package:choosenumber/res/colors.dart';
import 'package:choosenumber/screens/reservationsScreen.dart';
import 'package:choosenumber/utils/sizes.dart';
import 'package:choosenumber/widgets/card_option.dart';
import 'package:choosenumber/widgets/inputParentWidget.dart';
import 'package:choosenumber/widgets/inputTextWidget.dart';
import 'package:choosenumber/widgets/loadingIndicator.dart';
import 'package:choosenumber/widgets/radio_options.dart';
import 'package:choosenumber/widgets/submitButton.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:choosenumber/res/colors.dart' as res;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final authController = Get.find<AuthController>();
  String citeria = criteriaList.first.text;
  var searchCtr = TextEditingController();
  var resController = Get.put(ReservationController());
  String category = "";
  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    //saleController.process_sale.value = false;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () {
                  _key.currentState!.openDrawer();
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: boxDecorationWithRoundedCorners(
                    backgroundColor: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.withOpacity(0.2)),
                  ),
                  child: const Icon(
                    Icons.menu,
                    color: primaryColor,
                  ),
                )),
            16.width,
            const Expanded(
                child: Center(
                    child: Text("Choose numbers",
                        style: TextStyle(
                          color: primaryWhite,
                          fontFamily: 'Segoe UI',
                          fontSize: 25,
                          shadows: [
                            Shadow(
                              color: Color(0xba000000),
                              offset: Offset(0, 3),
                              blurRadius: 6,
                            )
                          ],
                        )))),
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
                    border: Border.all(color: Colors.grey.withOpacity(0.2)),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.logout, color: res.errorColor),
                ))
          ],
        ),
        /*const Text("Choose numbers",
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
            ))*/
        //centerTitle: true,
        /* leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back, color: primaryWhite),
        ),*/
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

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text('Welcome,', style: secondaryTextStyle())
                  .paddingOnly(left: 16, right: 16),
              Text('${authController.user.value!.name}',
                  style: boldTextStyle(size: 20))
                  .paddingOnly(left: 16, right: 16),
              20.height,

              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          20.height,
                          CardOption(
                              row: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                              textheader: "Criteria"
                          ),
                          8.height,
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
                                            size: 32.0, /*Color(0xff224597)*/
                                          ),
                                          labelText: "Category (optional)",
                                          labelStyle: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 18.0),
                                          hintText: '',
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: UnderlineInputBorder(
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
                                      clearButtonProps: const ClearButtonProps(
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
                                        controller: resController.search.value,
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
                                                //Get.to(() => HomeScreen());
                                                var form =
                                                    _formKey.currentState;
                                                if (form!.validate()) {
                                                  resController.crieria.value =
                                                      citeria;
                                                  resController.findNumbers();
                                                  /*Get.to(
                                                          () => TableScreen());*/
                                                }
                                              },
                                              text: 'Search',
                                              bgColor: primaryColor,
                                            );
                                    }),
                                    20.height,
                                    SubmitButton(
                                      onPressed: () {
                                        Get.to(() => ReservationsScreen());
                                      },
                                      text: 'Reservations List',
                                      bgColor: primaryBlack,
                                    )
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

          //controller: controller,
        ),
      ),
    );
  }
}
