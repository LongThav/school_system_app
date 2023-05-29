import 'package:flutter/material.dart';
import 'package:project/constants/loading_status.dart';
import 'package:project/constants/logger.dart';
import 'package:project/constants/url_base.dart';
import 'package:project/controllers/teacher_controllers/solution_controller.dart';
import 'package:project/models/teacher_models/solution_model.dart';
import 'package:provider/provider.dart';

import '../../constants/color.dart';
import 'create_solution_view.dart';

class ListSolutionView extends StatefulWidget {
  const ListSolutionView({super.key});

  @override
  State<ListSolutionView> createState() => _ListSolutionViewState();
}

class _ListSolutionViewState extends State<ListSolutionView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<SolutionController>().setLoading();
      context.read<SolutionController>().readSolution();
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
            onPressed: () async {
              await Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return const SolutionView();
              }));
              if(!mounted) return;
              context.read<SolutionController>().setLoading();
              context.read<SolutionController>().readSolution();
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
        context.watch<SolutionController>().loadingStatus;
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
    List<Solution> solutionModel =
        context.watch<SolutionController>().solutionModel.data;
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<SolutionController>().setLoading();
          context.read<SolutionController>().readSolution();
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: ListView.builder(
              itemCount: solutionModel.length,
              itemBuilder: (context, index) {
                "image Url: ${mainUrlimg + solutionModel[index].file}".log();
                return Card(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            child: Text(
                              '${solutionModel[index].id}.',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              '${solutionModel[index].text}.',
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
                                    mainUrlimg + solutionModel[index].file),
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
