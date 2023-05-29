import 'package:flutter/material.dart';
import 'package:project/constants/loading_status.dart';
import 'package:project/constants/logger.dart';
import 'package:project/controllers/teacher_controllers/notice_controller.dart';
import 'package:project/models/teacher_models/notic_event_model.dart';
import 'package:provider/provider.dart';

import '../../constants/color.dart';
import '../../constants/url_base.dart';
import 'notic_view.dart';

class NoticEventView extends StatefulWidget {
  const NoticEventView({super.key});

  @override
  State<NoticEventView> createState() => _NoticEventViewState();
}

class _NoticEventViewState extends State<NoticEventView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<NoticController>().setLoading();
      context.read<NoticController>().readNotic();
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
        title: Text("Solution".toUpperCase()),
        titleSpacing: -10,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const ViewNotic();
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
        context.watch<NoticController>().loadingStatus;
    switch (loadingStatus) {
      case LoadingStatus.none:
      case LoadingStatus.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case LoadingStatus.error:
        return const Center(
          child: Text("Error"),
        );
      case LoadingStatus.done:
        return _buildListItem();
    }
  }

  Widget _buildListItem() {
    List<Notic> notic = context.watch<NoticController>().noticModel.data;
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<NoticController>().setLoading();
          context.read<NoticController>().readNotic();
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: ListView.builder(
              itemCount: notic.length,
              itemBuilder: (context, index) {
                "image Url: ${mainUrlimg + notic[index].file}".log();
                return Card(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            child: Text(
                              '${notic[index].id}.',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              '${notic[index].text}.',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            right: 30, left: 30, bottom: 15),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                                image: NetworkImage(
                                    mainUrlimg + notic[index].file),
                                fit: BoxFit.fill)),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
