import 'package:choosenumber/controller/auth_controller.dart';
import 'package:choosenumber/res/colors.dart';
import 'package:choosenumber/widgets/loadingIndicator.dart';
import 'package:choosenumber/widgets/submitButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:choosenumber/widgets/inputTextWidget.dart';
import 'package:nb_utils/nb_utils.dart';

import 'homeScreen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen() : super();

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<LoginScreen> {
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  //final snackBar = SnackBar(content: Text('email ou mot de passe incorrect'));
  final _formKey = GlobalKey<FormState>();
  var authController = Get.find<AuthController>();
  bool isObscured = true;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const double r = (175 / 360); //  rapport for web test(304 / 540);
    final coverHeight = screenWidth * r;
    bool _pinned = false;
    bool _snap = false;
    bool _floating = false;

    final widgetList = [
      Row(
        children: [
          const SizedBox(
            width: 28,
          ),
          const Text(
            'Welcome',
            style: TextStyle(
              fontFamily: 'Segoe UI',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xffffffff),
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
      8.height,
      Flexible(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            'Login with your E-mail address and your password',
            style: TextStyle(
              fontFamily: 'Segoe UI',
              fontSize: 16,
              color: const Color(0xffffffff).withOpacity(.5),
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ),
      const SizedBox(
        height: 12.0,
      ),
      Form(
          key: _formKey,
          child: Column(
            children: [
              InputTextWidget(
                  controller: _emailController,
                  labelText: "Usernames",
                  icon: Icons.person,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress
              ),
              const SizedBox(
                height: 12.0,
              ),
              InputTextWidget(
                  controller: _pwdController,
                  labelText: "Password",
                  icon: CupertinoIcons.lock_fill,
                  obscureText: isObscured,
                  keyboardType: TextInputType.text,
                  suffix: InkWell(
                    child: Icon(
                      isObscured ? Icons.visibility : Icons.visibility_off,
                      size: 18,
                      color: Colors.white,
                    ),
                    onTap: () {
                      setState(() {
                        isObscured = !isObscured;
                      });
                    },
                  )),
              Padding(
                padding: const EdgeInsets.only(right: 25.0, top: 10.0),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          " ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700]),
                        ),
                      ),
                    )),
              ),
              Obx(() {
                return authController.login_process.isTrue
                    ? LoadingIndicator(text: "please wait..")
                    : SubmitButton(
                        onPressed: () {
                          //Get.to(() => HomeScreen());
                          var form = _formKey.currentState;
                          if (form!.validate()) {
                            Map<String, dynamic> creds = {
                              'username': _emailController.text,
                              'password': _pwdController.text,
                            };
                            authController.login(creds);
                          }
                        },
                        text: 'Log in',
                        bgColor: Colors.white ,
                      );
              })
            ],
          )),
      const SizedBox(
        height: 15.0,
      ),
      const SizedBox(
        height: 15.0,
      ),
    ];
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColorDarken,
        extendBodyBehindAppBar: true,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: _pinned,
              snap: _snap,
              floating: _floating,
              expandedHeight: /*coverHeight -25 */ 70, //304,
              backgroundColor: primaryColor,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/wlogo.png",
                        width: 100,
                        scale: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(),
                ),
                width: screenWidth,
                height: 25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: screenWidth,
                      height: 25,
                    )
                  ],
                ),
              ),
            ),
            SliverList(
                delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
                  return widgetList[index];
                }, childCount: widgetList.length))
          ],
        ),
      ),
    );
  }
}
