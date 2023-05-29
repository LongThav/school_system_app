import 'package:flutter/material.dart';
import 'package:project/constants/url_base.dart';
import 'package:project/models/teacher_models/student_list.dart';

import '../../constants/color.dart';
import '../../widgets/common_form_create_user.dart';

class ShowDetailStudent extends StatefulWidget {
  final User student;
  const ShowDetailStudent({super.key, required this.student});

  @override
  State<ShowDetailStudent> createState() => _ShowDetailStudentState();
}

class _ShowDetailStudentState extends State<ShowDetailStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: const Text("View Profile Student"),
        titleSpacing: -10,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            children: [
               Center(
                child: CircleAvatar(
                  radius: 80,
                  child: Image.network(mainUrlimg + widget.student.image),
                ),
              ),
              CommonFormViewStudent(
                text: 'Full name',
                hint: widget.student.fullname,
              ),
              const SizedBox(height: 15),
              CommonFormViewStudent(
                text: 'Email',
                hint: widget.student.email,
              ),
              const SizedBox(height: 15),
              CommonFormViewStudent(
                text: 'Class',
                hint: widget.student.userClass,
              ),
              const SizedBox(height: 15),
              CommonFormViewStudent(
                text: 'Section',
                hint: widget.student.session,
              ),
              const SizedBox(height: 15),
              CommonFormViewStudent(
                text: 'Role',
                hint: widget.student.roles,
              ),
              const SizedBox(height: 15),
              CommonFormViewStudent(
                text: 'ID Card',
                hint: widget.student.studentId,
              ),
              const SizedBox(height: 15),
              CommonFormViewStudent(
                text: 'Phone',
                hint: widget.student.phone,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
