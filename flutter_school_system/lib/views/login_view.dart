import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/loading_status.dart';
import '../views/signup_view.dart';
import '../constants/color.dart';
import '../constants/logo.dart';
import '../controllers/auth_controller.dart';
import '../widgets/common_btn.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController idStudentCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  bool passwordObscure = true;
  @override
  void dispose() {
    idStudentCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: width,
                height: height * 0.33,
                child: Stack(
                  children: [
                    Positioned(
                      top: -420,
                      child: Container(
                        width: width,
                        height: height,
                        decoration: const BoxDecoration(
                            color: green, shape: BoxShape.circle),
                      ),
                    ),
                    Positioned(
                      left: width * 0.24,
                      right: width * 0.24,
                      bottom: -90,
                      child: Container(
                        width: width * 0.5,
                        height: height * 0.5,
                        decoration: const BoxDecoration(
                            color: green, shape: BoxShape.circle),
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(logoII),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: width,
                height: height,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.05,
                    ),
                    _frmUserName(),
                    _fromPassword(),
                    SizedBox(
                      height: height * 0.1,
                    ),
                    _buildLogin(),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Center(
                      child: Text(
                        "Or",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return const SignUpView();
                        }));
                      },
                      child: const Center(
                        child: Text(
                          ' Create User',
                          style: TextStyle(
                              color: blue,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _frmUserName() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: 44,
      child: TextFormField(
        controller: idStudentCtrl,
        focusNode: emailFocusNode,
        decoration: InputDecoration(
            labelText: 'Username',
            labelStyle: const TextStyle(
              color: Color.fromRGBO(0, 0, 0, 0.87),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
            suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.email,
                  color: Color(0XFF828282),
                ))),
      ),
    );
  }

  Widget _fromPassword() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
      width: MediaQuery.of(context).size.width,
      height: 44,
      child: TextFormField(
        obscureText: passwordObscure,
        obscuringCharacter: '*',
        focusNode: passwordFocusNode,
        keyboardType: TextInputType.text,
        controller: passwordCtrl,
        decoration: InputDecoration(
          hintStyle: const TextStyle(
              fontWeight: FontWeight.w500, color: Color(0XFFCACACA)),
          suffixIcon: IconButton(
            icon: Icon(
              passwordObscure ? Icons.lock : Icons.lock,
              color: passwordObscure
                  ? const Color(0XFFCACACA)
                  : const Color(0XFF343434),
            ),
            onPressed: () {
              setState(() {
                passwordObscure = !passwordObscure;
              });
            },
          ),
          labelText: 'Password',
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          labelStyle: const TextStyle(
            color: Color.fromRGBO(0, 0, 0, 0.87),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildLogin() {
    final LoadingStatus loadingStatus =
        context.watch<AuthController>().loadingstatus;
    bool loading = loadingStatus == LoadingStatus.loading ? true : false;
    return ButtonClick(
      title: 'Login',
      loading: loading,
      callback: () async {
        if (idStudentCtrl.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please Input username')));
        } else if (passwordCtrl.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please Input password')));
        } else {
          var password = passwordCtrl.text;
          var idStudent = idStudentCtrl.text;
          context.read<AuthController>().setLoading();
          await Future.delayed(const Duration(milliseconds: 500), () {});
          if (!mounted) return;
          context
              .read<AuthController>()
              .loginController(password, idStudent, context);
        }
      },
    );
  }
}
