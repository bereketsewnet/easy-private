import 'package:Easy/pages/auth%20pages/RegisterPage.dart';
import 'package:Easy/common/utils/colors.dart';
import 'package:Easy/provider/controller/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../common/custom_widget/CustomTtextFormFeild.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    final _formKey = GlobalKey<FormState>();
    AuthController loginController = Get.find();

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: size.width * 0.8,
            height: size.height * 0.45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 1,
                  blurRadius: 5,
                )
              ],
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                const Text(
                  'Login',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.email,
                            color: primary,
                          ),
                          CustomTextFormFeild(
                              lable: 'Email', controller: _emailController),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(
                            Icons.password,
                            color: primary,
                          ),
                          CustomTextFormFeild(
                              lable: 'Password',
                              controller: _passwordController),
                        ],
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            loginController.loginUser(context, _emailController.text, _passwordController.text);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 25),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width - 210,
                            height: 45,
                            child: Card(
                              elevation: 8,
                              margin: const EdgeInsets.all(0),
                              color: primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Center(
                                child: Text(
                                  'LogIn',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                        Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'You haven\'t an account? ',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterPage(),
                                ),
                              );
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
         const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.30,
                child: const Divider(
                  color: Colors.teal,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Or',
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.30,
                child: const Divider(
                  color: Colors.teal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.teal,
                child: FaIcon(
                  FontAwesomeIcons.facebook,
                  color: Colors.white,
                  size: 27,
                ),
              ),
              SizedBox(width: 15),
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.teal,
                child: FaIcon(
                  FontAwesomeIcons.google,
                  color: Colors.white,
                  size: 27,
                ),
              ),
              SizedBox(width: 15),
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.teal,
                child: FaIcon(
                  FontAwesomeIcons.apple,
                  color: Colors.white,
                  size: 27,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
