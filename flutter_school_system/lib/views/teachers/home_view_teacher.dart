import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/../constants/loading_status.dart';
import '/../constants/teacher_icons.dart';
import '/../controllers/auth_controller.dart';
import '../../constants/color.dart';
import '../../constants/logo.dart';
import '../../constants/url_base.dart';
import '../../models/login_model.dart';
import '../../widgets/common_option_teacher.dart';
import 'attendance_view.dart';
import 'home_work_list_view.dart';
import 'list_solution_view.dart';
import 'notic_view.dart';
import 'notice_event_view.dart';
import 'result_view.dart';
import 'create_solution_view.dart';
import 'student_list_view.dart';

class HomeViewTeacher extends StatefulWidget {
  const HomeViewTeacher({super.key});

  @override
  State<HomeViewTeacher> createState() => _HomeViewTeacherState();
}

class _HomeViewTeacherState extends State<HomeViewTeacher> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<AuthController>().setLoading();
      context.read<AuthController>().readLocalUser();
    });
    super.initState();
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
                    _buildViewImage(),
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
                              text: 'Hello Teacher!',
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
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                width: width,
                height: height,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // InkWell()
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
                              return const HomeWorkView();
                            }));
                          },
                          child: const CommonOptionTeacher(
                            image: DecorationImage(image: AssetImage(homework)),
                            title: 'Homework',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const ResultView();
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
                        const CommonOptionTeacher(
                          image:
                              DecorationImage(image: AssetImage(examrouting)),
                          title: 'Exam Routine',
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const ListSolutionView();
                            }));
                          },
                          child: const CommonOptionTeacher(
                            image: DecorationImage(image: AssetImage('assets/imgs/solution.png')),
                            title: 'Solution',
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const NoticEventView();
                            }));
                          },
                          child: const CommonOptionTeacher(
                            image: DecorationImage(image: AssetImage(question)),
                            title: 'Notice & Events',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const StudentListView();
                            }));
                          },
                          child: const CommonLogout(
                            title: 'List of Students',
                            icon: Icon(
                              Icons.person,
                              size: 50,
                              color: blue,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.1,
                        ),
                        InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0))),
                                      title: const Text('Do you want Logout?'),
                                      actions: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "No",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: blue.withOpacity(0.5)),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            context
                                                .read<AuthController>()
                                                .logoutController(context);
                                            if (!mounted) return;
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 15),
                                            child: Text(
                                              "Yes",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: blue),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        )
                                      ],
                                    );
                                  });
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: const CommonLogout(
                                title: 'Log out',
                                icon: Icon(
                                  Icons.logout,
                                  size: 50,
                                  color: blue,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildViewImage() {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    User loginModel = context.watch<AuthController>().localLogin.data.user;
    LoadingStatus loadingStatus = context.watch<AuthController>().loadingstatus;
    if (loadingStatus == LoadingStatus.none ||
        loadingStatus == LoadingStatus.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (loadingStatus == LoadingStatus.error) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Positioned(
        left: width * 0.27,
        right: width * 0.27,
        bottom: -90,
        child: Container(
          width: width * 0.5,
          height: height * 0.5,
          decoration: const BoxDecoration(color: green, shape: BoxShape.circle),
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(mainUrlimg + loginModel.image),
                )),
          ),
        ),
      );
    }
  }
}
