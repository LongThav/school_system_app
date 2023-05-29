import 'package:flutter/material.dart';
import 'package:project/constants/loading_status.dart';
import 'package:provider/provider.dart';

import '../controllers/auth_controller.dart';
import '../constants/color.dart';
import '../widgets/common_btn_create_user.dart';
import '../widgets/common_form_create_user.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {

  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController studentIdCtrl = TextEditingController();
  TextEditingController classCtrl = TextEditingController();
  TextEditingController sessionCtrl = TextEditingController();
  TextEditingController rolesCtrl = TextEditingController();

  @override
  void dispose() {
    usernameCtrl.dispose();
    phoneCtrl.dispose();
    passwordCtrl.dispose();
    emailCtrl.dispose();
    studentIdCtrl.dispose();
    classCtrl.dispose();
    sessionCtrl.dispose();
    rolesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: blue,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          "Create User",
          style: TextStyle(color: blue),
        ),
        titleSpacing: -13,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            CommonFormCreateuser(
              controller: usernameCtrl,
              text: 'Full name',
              hint: 'Input user name or IDCard',
            ),
            const SizedBox(height: 15),
            CommonFormCreateuser(
              controller: emailCtrl,
              text: 'Email',
              hint: 'Input email',
            ),
            const SizedBox(height: 15),
            CommonFormCreateuser(
              controller: classCtrl,
              text: 'Class',
              hint: 'Input class',
            ),
            const SizedBox(height: 15),
            CommonFormCreateuser(
              controller: sessionCtrl,
              text: 'Section',
              hint: 'Input Section',
            ),
            const SizedBox(height: 15),
            CommonFormCreateuser(
              controller: rolesCtrl,
              text: 'Role',
              hint: 'Input Role',
            ),
            const SizedBox(height: 15),
            CommonFormCreateuser(
              controller: studentIdCtrl,
              text: 'ID Card',
              hint: 'Input ID Card',
            ),
            const SizedBox(height: 15),
            CommonFormCreateuser(
              controller: passwordCtrl,
              text: 'Password',
              hint: 'Input password',
            ),
            const SizedBox(height: 15),
            CommonFormCreateuser(
              controller: phoneCtrl,
              text: 'Phone',
              hint: 'Input Phone',
            ),
            const SizedBox(height: 20),
            _buildButtonCreated(),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonCreated() {
    LoadingStatus loadingStatus = context.watch<AuthController>().createUserLoading;
    bool isLoading = loadingStatus == LoadingStatus.loading ? true : false;
    return BtnCreateUser(
      title: "Create User",
      loading: isLoading,
      callback: () {
        if (usernameCtrl.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please Input Username')));
        } else if (emailCtrl.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please Input Email')));
        } else if (classCtrl.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please Input Class')));
        } else if (sessionCtrl.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please Input Section')));
        } else if (studentIdCtrl.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please Input Id Card')));
        } else if (passwordCtrl.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please Input Password')));
        } else if (phoneCtrl.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please Input Phone Number')));
        } else if (rolesCtrl.text.isEmpty) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Please Input Role')));
        } else {
          context.read<AuthController>().setCreateUserLoading();
          Future.delayed(const Duration(milliseconds: 600));
          if (!mounted) return;
          context.read<AuthController>().createUser(
              usernameCtrl.text,
              phoneCtrl.text,
              passwordCtrl.text,
              emailCtrl.text,
              studentIdCtrl.text,
              classCtrl.text,
              sessionCtrl.text,
              rolesCtrl.text,
              context);
        }
      },
    );
  }
}
