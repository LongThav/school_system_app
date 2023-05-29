import 'package:flutter/material.dart';
import 'package:project/constants/logo.dart';
import 'package:project/views/login_view.dart';

import '../constants/color.dart';
import '../widgets/common_cover.dart';
import '../widgets/common_user.dart';

class TypeRoleUserView extends StatefulWidget {
  const TypeRoleUserView({super.key});

  @override
  State<TypeRoleUserView> createState() => _TypeRoleUserViewState();
}

class _TypeRoleUserViewState extends State<TypeRoleUserView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Stack(
        children: [
          const CommonCover(),
          Center(
            child: Container(
              margin: EdgeInsets.only(bottom: height * 0.13),
              child: const Text(
                "Choose your option",
                style: TextStyle(
                    color: green, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height * 0.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                      reverseTransitionDuration: const Duration(milliseconds: 400),
                      transitionDuration: const Duration(milliseconds: 600),
                        pageBuilder: (context, animation, animationDouble) {
                      return const LoginView();
                    }));
                  },
                  child: const CommonUser(
                    title: 'Student',
                    image: DecorationImage(image: AssetImage(male)),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, animation, animationDouble) {
                      return const LoginView();
                    }));
                  },
                  child: const CommonUser(
                    title: 'Teacher',
                    image: DecorationImage(image: AssetImage(guest)),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height * 0.7),
            child: Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation, animationDouble) {
                    return const LoginView();
                  }));
                },
                child: const CommonUser(
                  title: 'Guest',
                  image: DecorationImage(image: AssetImage(person)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
