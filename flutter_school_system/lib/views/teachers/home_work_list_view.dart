import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project/constants/url_base.dart';
import 'package:project/views/teachers/create_home_work.dart';
import 'package:provider/provider.dart';

import '/constants/loading_status.dart';
import '/constants/logger.dart';
import '/controllers/teacher_controllers/home_work_controller.dart';
import '/models/teacher_models/home_work_model.dart';
import '/widgets/common_btn_create_user.dart';
import '../../constants/color.dart';

class HomeWorkView extends StatefulWidget {
  const HomeWorkView({super.key});

  @override
  State<HomeWorkView> createState() => _HomeWorkViewState();
}

class _HomeWorkViewState extends State<HomeWorkView> {
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _fileCtrl = TextEditingController();
  File? image;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HomeWorkController>().setLoading();
      context.read<HomeWorkController>().readHomeWork();
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
        title: Text("Home Work".toUpperCase()),
        titleSpacing: -10,
        actions: [
          IconButton(
            onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const CreateHomeWork();
              }));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    LoadingStatus loadingStatus =
        context.watch<HomeWorkController>().loadingStatus;
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
      return _buildListHomeWork();
    }
  }

  Widget _buildListHomeWork() {
    List<HomeWork> homeWork =
        context.watch<HomeWorkController>().homeWorkModel.data;
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<HomeWorkController>().setLoading();
          context.read<HomeWorkController>().readHomeWork();
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: ListView.builder(
            itemCount: homeWork.length,
            itemBuilder: (context, index) {
              if (homeWork[index].file.isEmpty) {
                return Container();
              } else {
                homeWork[index].file;
              }
              return Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          child: Text(
                            '${homeWork[index].id}.',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            '${homeWork[index].text}.',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    _buildLoading(mainUrlimg + homeWork[index].file),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }


  Widget _buildLoading(String img) {
    LoadingStatus loadingStatus =
        context.watch<HomeWorkController>().loadingStatus;
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
      return Container(
        margin: const EdgeInsets.only(right: 30, left: 30, bottom: 15),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(image: NetworkImage(img), fit: BoxFit.fill)),
      );
    }
  }
}
