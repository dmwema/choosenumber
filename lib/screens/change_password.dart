import 'package:choosenumber/widgets/loadingIndicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';
import '../res/colors.dart';
import '../widgets/inputTextWidget.dart';
import '../widgets/submitButton.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final TextEditingController _oldPass = TextEditingController();
  bool obscured1 = true;
  bool obscured2 = true;
  var auth = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text("Change Password",
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
          child: const Icon(Icons.arrow_back, color: primaryWhite),
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
          child: SingleChildScrollView(
            //controller: controller,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 25.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                    child: Container(
                      child: Material(
                        elevation: 15.0,
                        shadowColor: Colors.black,
                        borderRadius: BorderRadius.circular(15.0),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(right: 20.0, left: 15.0),
                          child: TextFormField(
                              obscureText: obscured1,
                              autofocus: false,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                suffix: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscured1 = !obscured1;
                                      });
                                    },
                                    icon: Icon(obscured1
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                                icon: const Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                  size: 32.0, /*Color(0xff224597)*/
                                ),
                                labelText: "Old password",
                                labelStyle: const TextStyle(
                                    color: Colors.black54, fontSize: 18.0),
                                hintText: '',
                                enabledBorder: InputBorder.none,
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black54),
                                ),
                                border: InputBorder.none,
                              ),
                              controller: _oldPass,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'tapez un mot de passe ';
                                } else if (val.length < 6) {
                                  return 'mot de passe doit etre > 6 caractère';
                                }

                                return null;
                              }),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                    child: Container(
                      child: Material(
                        elevation: 15.0,
                        shadowColor: Colors.black,
                        borderRadius: BorderRadius.circular(15.0),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(right: 20.0, left: 15.0),
                          child: TextFormField(
                              obscureText: obscured2,
                              autofocus: false,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                suffix: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscured2 = !obscured2;
                                      });
                                    },
                                    icon: Icon(obscured2
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                                icon: const Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                  size: 32.0, /*Color(0xff224597)*/
                                ),
                                labelText: "New password",
                                labelStyle: const TextStyle(
                                    color: Colors.black54, fontSize: 18.0),
                                hintText: '',
                                enabledBorder: InputBorder.none,
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black54),
                                ),
                                border: InputBorder.none,
                              ),
                              controller: _pass,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'tapez un mot de passe ';
                                } else if (val.length < 6) {
                                  return 'mot de passe doit etre > 6 caractère';
                                }

                                return null;
                              }),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                    child: Container(
                      child: Material(
                        elevation: 15.0,
                        shadowColor: Colors.black,
                        borderRadius: BorderRadius.circular(15.0),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(right: 20.0, left: 15.0),
                          child: TextFormField(
                              obscureText: obscured2,
                              autofocus: false,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                  size: 32.0, /*Color(0xff224597)*/
                                ),
                                labelText: "Confirm password",
                                labelStyle: TextStyle(
                                    color: Colors.black54, fontSize: 18.0),
                                hintText: '',
                                enabledBorder: InputBorder.none,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black54),
                                ),
                                border: InputBorder.none,
                              ),
                              controller: _confirmPass,
                              validator: (val) {
                                if (val!.isEmpty) return 'confirm password!!';
                                if (val != _pass.text)
                                  return 'Password incorrect';
                                return null;
                              }),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Obx(() {
                    return auth.retrieve_pass_process.isTrue
                        ? LoadingIndicator(text: "Changing...")
                        : SubmitButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                Map<String, String> user_pass = {
                                  "oldPassword": _oldPass.text,
                                  "newPassword": _pass.text
                                };
                                auth.changePassword(user_pass);
                              }
                            },
                            text: 'Change',
                            bgColor: primaryColor,
                          );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
