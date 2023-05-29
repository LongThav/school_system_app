import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/color.dart';
import '../../constants/logo.dart';
import '../../controllers/auth_controller.dart';
import '../../models/login_model.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<AuthController>().setCreateUserLoading();
      context.read<AuthController>().readLocalUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    User loginModel = context.watch<AuthController>().localLogin.data.user;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: width,
              height: height * 0.36,
              child: Stack(
                children: [
                  Positioned(
                    top: -390,
                    child: Container(
                      width: width,
                      height: height * 0.9,
                      decoration: const BoxDecoration(
                          color: green, shape: BoxShape.circle),
                    ),
                  ),
                  Positioned(
                    left: width * 0.27,
                    right: width * 0.27,
                    bottom: -90,
                    child: GestureDetector(
                      onTap: () {},
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
                                image: AssetImage(happy),
                              )),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.centerLeft,
              child: Text(
                "ID: ${loginModel.studentId}",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: blue,
                    letterSpacing: 1.5),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(children: [
                  const TextSpan(
                    text: 'Full Name: \n',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: blue,
                        letterSpacing: 1.5),
                  ),
                  TextSpan(
                    text: loginModel.fullname,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: blue,
                        letterSpacing: 1.5),
                  )
                ]),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(children: [
                  const TextSpan(
                    text: 'Class: \n',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: blue,
                        letterSpacing: 1.5),
                  ),
                  TextSpan(
                    text: loginModel.userClass,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: blue,
                        letterSpacing: 1.5),
                  )
                ]),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(children: [
                  const TextSpan(
                    text: 'Role: \n',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: blue,
                        letterSpacing: 1.5),
                  ),
                  TextSpan(
                    text: loginModel.roles,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: blue,
                        letterSpacing: 1.5),
                  )
                ]),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(children: [
                  const TextSpan(
                    text: 'Email: \n',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: blue,
                        letterSpacing: 1.5),
                  ),
                  TextSpan(
                    text: loginModel.email,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: blue,
                        letterSpacing: 1.5),
                  )
                ]),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(children: [
                  const TextSpan(
                    text: 'Contact: \n',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: blue,
                        letterSpacing: 1.5),
                  ),
                  TextSpan(
                    text: loginModel.phone,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: blue,
                        letterSpacing: 1.5),
                  )
                ]),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(children: [
                  const TextSpan(
                    text: 'Section: \n',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: blue,
                        letterSpacing: 1.5),
                  ),
                  TextSpan(
                    text: loginModel.session,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: blue,
                        letterSpacing: 1.5),
                  )
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildWidget(String value){
  //   return
  // }
}
