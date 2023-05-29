import 'package:flutter/material.dart';
import 'package:project/constants/loading_status.dart';
import 'package:project/constants/url_base.dart';
import 'package:project/widgets/common_btn_create_user.dart';
import 'package:provider/provider.dart';

import '../../constants/color.dart';
import '../../controllers/teacher_controllers/home_work_controller.dart';
import '../../models/teacher_models/home_work_model.dart';

class HomeWorkStudentView extends StatefulWidget {
  const HomeWorkStudentView({super.key});

  @override
  State<HomeWorkStudentView> createState() => _HomeWorkStudentViewState();
}

class _HomeWorkStudentViewState extends State<HomeWorkStudentView> {
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
      return _showItem();
    }
  }

  Widget _showItem() {
    List<HomeWork> homeWork =
        context.watch<HomeWorkController>().homeWorkModel.data;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15),
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
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child:  Text(
                          homeWork[index].text,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 14,
                              color: blue,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
                        width: width,
                        height: height * 0.2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey,
                            image: DecorationImage(
                              image: NetworkImage(mainUrlimg + homeWork[index].file),
                              fit: BoxFit.fill
                            )
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      BtnCreateUser(
                          title: 'Download your homework', callback: () {})
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
