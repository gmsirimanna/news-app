import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/data/widgets/custom_text_field.dart';
import 'package:news_app/helper/route_helper.dart';
import 'package:news_app/providers/auth_provider.dart';
import 'package:news_app/screens/signup_screen.dart';
import 'package:news_app/util/color_resources.dart';
import 'package:news_app/util/dimensions.dart';
import 'package:news_app/util/images.dart';
import 'package:news_app/util/styles.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double height, width;
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Consumer<AuthProvider>(builder: (context, authProvider, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.15),
                SizedBox(width: width * 0.5, child: Image.asset(Images.newsAppTitle)),
                SizedBox(height: height * 0.08),
                const Text(
                  'Sign in to continue',
                  style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: height * 0.08),
                const Text(
                  'Email',
                  style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomTextField(
                  controller: _emailController,
                  hintText: "Enter Email",
                  radius: 10.0,
                  fillColor: HexColor("#F5F8FD"),
                  isShowBorder: false,
                  isPassword: false,
                  isShowSuffixIcon: false,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'Password',
                  style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomTextField(
                  controller: _passwordController,
                  hintText: "Enter Password",
                  radius: 10.0,
                  fillColor: HexColor("#F5F8FD"),
                  isShowBorder: false,
                  isPassword: true,
                  isShowSuffixIcon: true,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                SizedBox(height: height * 0.25),
                InkWell(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(context, "/Main", (route) => false);
                    // String _email = _emailController.text.trim();
                    // String _password = _passwordController.text.trim();
                    // if (_email.isEmpty) {
                    //   showBotToast("Enter email", context);
                    // } else if (_password.isEmpty) {
                    //   showBotToast("Enter password", context);
                    // } else if (EmailChecker.isNotValid(_email)) {
                    //   showBotToast("Enter vaid email", context);
                    // } else {
                    //   authProvider.login(_email, _password).then((status) async {
                    //     if (status.isSuccess) {
                    //       Navigator.pushNamedAndRemoveUntil(context, "/Home", (route) => false);
                    //     } else {
                    //       showBotToast(status.message, context);
                    //     }
                    //   });
                    // }
                  },
                  child: Container(
                    height: 50.0,
                    width: width,
                    decoration: BoxDecoration(color: ColorResources.COLOR_PRIMARY_RED, borderRadius: BorderRadius.circular(25)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Sign in',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          authProvider.isLoading
                              ? const SizedBox(
                                  height: 20.0,
                                  width: 20.0,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3.0,
                                  ))
                              : const Icon(
                                  Icons.arrow_right_alt_rounded,
                                  color: Colors.white,
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 17.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(RouteHelper.register, arguments: const SignupScreen());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Create an Account? ",
                        style: nunitoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: ColorResources.COLOR_GREY),
                      ),
                      Text(
                        "Signup",
                        style: nunitoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: ColorResources.COLOR_SECONDARY_BLUE),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
