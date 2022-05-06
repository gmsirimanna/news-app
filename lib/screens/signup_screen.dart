import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/data/widgets/custom_app_bar.dart';
import 'package:news_app/data/widgets/custom_text_field.dart';
import 'package:news_app/providers/auth_provider.dart';
import 'package:news_app/util/color_resources.dart';
import 'package:news_app/util/dimensions.dart';
import 'package:news_app/util/images.dart';
import 'package:news_app/util/styles.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final FocusNode _fullNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _numberFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool email = true;
  bool phone = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _numberController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Create an Account",
        isBackButtonExist: true,
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_LARGE,
          ),
          child: Consumer<AuthProvider>(builder: (context, authProvider, child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Image.asset(Images.newsAppTitle),
                    ),
                  ),
                  const SizedBox(height: 30),
                  _signupField("User Name", Images.user),
                  const SizedBox(height: 15),
                  _signupField("Phone Number", Images.user),
                  const SizedBox(height: 15),
                  _signupField("Email", Images.user),
                  const SizedBox(height: 15),
                  _signupField("Password", Images.user),
                  const SizedBox(height: 15),
                  _signupField("Confirm Password", Images.user),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: Dimensions.PADDING_SIZE_SMALL),
                    child: Container(
                      height: 50.0,
                      width: double.infinity,
                      decoration: BoxDecoration(color: ColorResources.COLOR_PRIMARY_RED, borderRadius: BorderRadius.circular(25)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Register',
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
                  const SizedBox(height: 15),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: nunitoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: ColorResources.COLOR_GREY),
                        ),
                        Text(
                          "Login",
                          style: nunitoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: ColorResources.border_blue),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          })),
    );
  }

  _signupField(title, image) => CustomTextField(
        hintText: title,
        radius: 10,
        isShowBorder: true,
        isShowPrefixIcon: true,
        prefixIconUrl: Container(
            padding: const EdgeInsets.all(15),
            width: 20,
            height: 20,
            child: SvgPicture.asset(
              image,
              color: Colors.black45,
              fit: BoxFit.contain,
            )),
      );
}
