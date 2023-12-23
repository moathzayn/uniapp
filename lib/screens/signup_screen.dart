import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uniapp/resources/auth_methods.dart';
import 'package:uniapp/uitls/utils.dart';
import 'package:uniapp/widgets/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/login/background_login_dark.svg',
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),
                  Image.asset('assets/logo/logo_light.jpg'),
                  const SizedBox(
                    height: 24,
                  ),
                  Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 50,
                              backgroundImage: MemoryImage(_image!))
                          : const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 50,
                              backgroundImage: AssetImage(
                                  'assets/signup/account_circle.png'),
                            ),
                      Positioned(
                          bottom: -12,
                          right: -12,
                          child: IconButton(
                              onPressed: selectImage,
                              icon: const Icon(Icons.add_a_photo)))
                    ],
                  ),
                  TextFieldInput(
                    hintText: 'Enter Your Username',
                    textEditingController: _usernameController,
                    textInputType: TextInputType.emailAddress,
                    icon: const Icon(Icons.account_circle),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldInput(
                    hintText: 'Enter Your Email',
                    textEditingController: _emailController,
                    textInputType: TextInputType.emailAddress,
                    icon: const Icon(Icons.email),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldInput(
                    hintText: 'Enter Your password',
                    textEditingController: _passwordController,
                    textInputType: TextInputType.text,
                    isPass: true,
                    icon: const Icon(Icons.password),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldInput(
                    hintText: 'Enter Your bio',
                    textEditingController: _bioController,
                    textInputType: TextInputType.emailAddress,
                    icon: const Icon(Icons.abc_sharp),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () async {
                      String res = await AuthMethods().signUpUser(
                        email: _emailController.text,
                        password: _passwordController.text,
                        username: _usernameController.text,
                        bio: _bioController.text,
                        file: _image!,
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          color: Colors.blue),
                      child: const Text('Sign Up'),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 2,
                    color: Colors.black,
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text('Do you have an account?  '),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),
                ],
              ),
              //SvgPicture.asset('assets/login/background_login_dark.svg')
            ),
          ),
        ],
      ),
    );
  }
}
