import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/auth_controller.dart';
import 'controllers/form_controller.dart';
import 'controllers/teacher_controllers/home_work_controller.dart';
import 'controllers/teacher_controllers/notice_controller.dart';
import 'controllers/teacher_controllers/solution_controller.dart';
import 'controllers/teacher_controllers/student_list_controller.dart';
import 'views/splash_view.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthController()),
        ChangeNotifierProvider(create: (context) => FormController()),
        ChangeNotifierProvider(create: (context) => TecherControllerStudentList()),
        ChangeNotifierProvider(create: (context) => HomeWorkController()),
        ChangeNotifierProvider(create: (context) => SolutionController()),
        ChangeNotifierProvider(create: (context)=> NoticController()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}