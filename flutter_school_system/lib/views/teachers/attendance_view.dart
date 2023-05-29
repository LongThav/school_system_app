import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/constants/loading_status.dart';
import 'package:project/models/teacher_models/student_list.dart';
import 'package:provider/provider.dart';
import '../../controllers/teacher_controllers/student_list_controller.dart';
import '/models/teacher_models/model_test.dart';
import '../../constants/color.dart';

class AttendanceView extends StatefulWidget {
  const AttendanceView({super.key});

  @override
  State<AttendanceView> createState() => _AttendanceViewState();
}

class _AttendanceViewState extends State<AttendanceView> {
  var dateTime = DateFormat.yMMMEd().format(DateTime.now());

  bool isSelect = false;

  List<StudentAttendance> userInfo = [
    StudentAttendance('False', 'LongThav SiPav', 'True', false, false),
    StudentAttendance('False', 'Chhan LeakNa', 'True', false, false),
    StudentAttendance('False', 'Da SoThea', 'True', false, false),
    StudentAttendance('False', 'Khea Borey', 'True', false, false),
    StudentAttendance('False', 'Seth Pisal', 'True', false, false),
    StudentAttendance('False', 'Long ChanTha', 'True', false, false),
    StudentAttendance('False', 'LongThav SiPav', 'True', false, false),
    StudentAttendance('False', 'Chhan LeakNa', 'True', false, false),
    StudentAttendance('False', 'Da SoThea', 'True', false, false),
    StudentAttendance('False', 'Khea Borey', 'True', false, false),
    StudentAttendance('False', 'Seth Pisal', 'True', false, false),
    StudentAttendance('False', 'Long ChanTha', 'True', false, false),
    StudentAttendance('False', 'LongThav SiPav', 'True', false, false),
    StudentAttendance('False', 'Chhan LeakNa', 'True', false, false),
    StudentAttendance('False', 'Da SoThea', 'True', false, false),
    StudentAttendance('False', 'Khea Borey', 'True', false, false),
    StudentAttendance('False', 'Seth Pisal', 'True', false, false),
    StudentAttendance('False', 'Long ChanTha', 'True', false, false),
    StudentAttendance('False', 'LongThav SiPav', 'True', false, false),
    StudentAttendance('False', 'Chhan LeakNa', 'True', false, false),
    StudentAttendance('False', 'Da SoThea', 'True', false, false),
    StudentAttendance('False', 'Khea Borey', 'True', false, false),
    StudentAttendance('False', 'Seth Pisal', 'True', false, false),
    StudentAttendance('False', 'Long ChanTha', 'True', false, false),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timings) {
      context.read<TecherControllerStudentList>().setLoading();
      context.read<TecherControllerStudentList>().readStudentList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: blue,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Attendance".toUpperCase()),
        titleSpacing: -10,
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.add)
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    LoadingStatus loadingStatus =
        context.watch<TecherControllerStudentList>().loadingStatus;
    if (loadingStatus == LoadingStatus.none ||
        loadingStatus == LoadingStatus.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (loadingStatus == LoadingStatus.error) {
      return const Center(
        child: Text("Error"),
      );
    } else {
      return _showItem();
    }
  }

  Widget _showItem() {
    List<User> user =
        context.watch<TecherControllerStudentList>().studentList.data.user;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.065,
            color: Colors.blue[300],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Class: Co2E1",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Date: $dateTime",
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Table(
            children: [
              TableRow(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  children: [_buildRow('Student Name', 'Present', 'absent')]),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: Table(
              border: TableBorder.all(width: 1, color: blue),
              children: List.generate(user.length, (index) {
                return TableRow(
                  children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Center(
                      child: Text(
                        user[index].fullname,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.5,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Center(
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (userInfo[index].absentSelect == true) {
                                  // nothing rebuild UI
                                } else {
                                  userInfo[index].presentSelect =
                                      !userInfo[index].presentSelect;
                                }
                              });
                            },
                            child: userInfo[index].presentSelect == false
                                ? Text(
                                    userInfo[index].present,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.5),
                                  )
                                : Text(
                                    userInfo[index].present,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.5,
                                        color: Colors.green[700]),
                                  ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Center(
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (userInfo[index].presentSelect == true) {
                                  // nothing rebuild UI
                                } else {
                                  userInfo[index].absentSelect =
                                      !userInfo[index].absentSelect;
                                }
                              });
                            },
                            child: userInfo[index].absentSelect == false
                                ? Text(
                                    userInfo[index].absent,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.5),
                                  )
                                : Text(
                                    userInfo[index].absent,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.5,
                                        color: Colors.red[700]),
                                  ))),
                  ),
                ]);
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String title, String present, String absent) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            padding: const EdgeInsets.only(
              left: 15,
              top: 15,
              bottom: 15,
            ),
            child: Text(
              title.toUpperCase(),
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )),
        Container(
            padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
            child: Text(
              present.toUpperCase(),
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.04,
        ),
        Container(
            padding: EdgeInsets.only(
                left: 0,
                top: 15,
                bottom: 15,
                right: MediaQuery.of(context).size.width * 0.1),
            child: Text(
              absent.toUpperCase(),
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )),
      ],
    );
  }
}
