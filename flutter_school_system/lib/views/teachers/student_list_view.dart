import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/constants/url_base.dart';
import 'package:provider/provider.dart';

import '../../controllers/teacher_controllers/student_list_controller.dart';
import '../../models/teacher_models/student_list.dart';
import '/constants/color.dart';
import '/constants/loading_status.dart';
import '/constants/logger.dart';
import 'show_detail_view.dart';

class StudentListView extends StatefulWidget {
  const StudentListView({super.key});

  @override
  State<StudentListView> createState() => _StudentListViewState();
}

class _StudentListViewState extends State<StudentListView> {
  List<User> students = [];
  var img = '';
  var _imgBase64;
  void _getImageBase64()async{
    http.Response response = await http.get(Uri.parse(img));
    _imgBase64 = base64Encode(response.bodyBytes);
    'Image Base64: ${_imgBase64}'.log();
  }
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<TecherControllerStudentList>().setLoading();
      context.read<TecherControllerStudentList>().readStudentList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Text("List of Students".toUpperCase()),
        titleSpacing: -10,
      ),
      body: _checkStatus(),
    );
  }

  Widget _checkStatus() {
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
      return _buildBody();
    }
  }

  Widget _buildBody() {
    StudentList studentList =
        context.watch<TecherControllerStudentList>().studentList;
    students = [];
    for (var student in studentList.data.user) {
      if (student.roles.toLowerCase() == 'student') {
        students = [...students, student];
        // students.add(student);
      }
    }
    return RefreshIndicator(
      onRefresh: () async {
        context.read<TecherControllerStudentList>().setLoading();
        context.read<TecherControllerStudentList>().readStudentList();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              img = students[index].image;
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return  ShowDetailStudent(student: students[index],);
                  }));
                },
                child: Card(
                    borderOnForeground: true,
                    shadowColor: Colors.blue,
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    child: ListTile(
                      leading:  CircleAvatar(
                        radius: 25,
                        child: Image.network(mainUrlimg + students[index].image),
                      ),
                      title: Text(
                        students[index].fullname,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          students[index].studentId,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      trailing: Text(
                        students[index].roles,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
              );
            }),
      ),
    );
  }
}
