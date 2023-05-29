import 'package:flutter/material.dart';
import 'package:project/models/login_model.dart';
import 'package:provider/provider.dart';

import '../../constants/color.dart';
import '../../constants/logo.dart';
import '../../constants/teacher_icons.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/common_option_teacher.dart';
import '../teachers/attendance_view.dart';
import 'exam_routing_student_view.dart';
import 'home_work_student_view.dart';
import 'profile_view.dart';
import 'quize_view_student.dart';
import 'result_view_student.dart';
import 'solution_student_view.dart';

class HomeViewStudent extends StatefulWidget {
  const HomeViewStudent({super.key});

  @override
  State<HomeViewStudent> createState() => _HomeViewStudentState();
}

class _HomeViewStudentState extends State<HomeViewStudent> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<AuthController>().setCreateUserLoading();
      context.read<AuthController>().readLocalUser();
    });
    super.initState();
  }

  void _createDrawer() {
    _key.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: _buildBody(),
      drawerEnableOpenDragGesture: false,
      drawer: _buildDrawer(),
    );
  }

  Widget _buildBody() {
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
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const ProfileView();
                        }));
                      },
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
                      onPressed: _createDrawer,
                      icon: const Icon(
                        Icons.menu,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              height: height * 0.13,
              width: width,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(12, 70, 196, 1),
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                            text: 'Welcome Stuent!',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: '\n \nLet\'s start your class...',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ]),
                    ),
                    Container(
                      padding: const EdgeInsets.all(60),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(happy),
                          )),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              width: width,
              height: height,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const AttendanceView();
                          }));
                        },
                        child: const CommonOptionTeacher(
                          image: DecorationImage(
                              image: AssetImage(
                            attendance,
                          )),
                          title: 'Attendance',
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const HomeWorkStudentView();
                          }));
                        },
                        child: const CommonOptionTeacher(
                          image: DecorationImage(image: AssetImage(homework)),
                          title: 'Homework',
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const ResultStudentView();
                          }));
                        },
                        child: const CommonOptionTeacher(
                          image: DecorationImage(image: AssetImage(result)),
                          title: 'Result',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const ExamRoutinViewStudent();
                          }));
                        },
                        child: const CommonOptionTeacher(
                          image:
                              DecorationImage(image: AssetImage(examrouting)),
                          title: 'Exam Routine',
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const SolutionViewStudent();
                          }));
                        },
                        child: const CommonOptionTeacher(
                          image: DecorationImage(image: AssetImage(solution)),
                          title: 'Solution',
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const QuizViewStudent();
                          }));
                        },
                        child: const CommonOptionTeacher(
                          image: DecorationImage(image: AssetImage(question)),
                          title: 'Quiz',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    User loginModel = context.watch<AuthController>().localLogin.data.user;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Drawer(
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          DrawerHeader(
            margin: const EdgeInsets.only(bottom: 0),
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: Row(
              children: [
                Container(
                    alignment: Alignment.centerLeft, child: Image.asset(happy)),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: loginModel.fullname,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '\n${loginModel.email}',
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            width: width,
            height: height,
            color: blue,
            child: Column(
              children: List.generate(userInfo.length, (index) {
                return GestureDetector(
                  onTap: () {
                    if (userInfo[index]['name'] == "Logout" ||
                        userInfo[index]['img'] == logout) {
                      context.read<AuthController>().logoutController(context);
                      if (!mounted) return;
                    }
                  },
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
                        child: Image.asset(userInfo[index]['img']),
                      ),
                      Text(
                        userInfo[index]['name'],
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
