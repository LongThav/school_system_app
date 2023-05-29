import 'package:flutter/material.dart';
import 'package:project/constants/logger.dart';
import 'package:project/widgets/common_btn_create_user.dart';
import 'package:provider/provider.dart';

import '../../constants/color.dart';
import '../../constants/loading_status.dart';
import '../../controllers/teacher_controllers/notice_controller.dart';

class ViewNotic extends StatefulWidget {
  const ViewNotic({super.key});

  @override
  State<ViewNotic> createState() => _ViewNoticState();
}

class _ViewNoticState extends State<ViewNotic> {
  final TextEditingController _titleCtrl = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<NoticController>().fileBase64;
      context.read<NoticController>().localFile;
    });
    super.initState();
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    super.dispose();
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
        title: Text("Notice and Events".toUpperCase()),
        titleSpacing: -10,
      ),
      body: _buildBody(),
      bottomNavigationBar: _buildBottom(),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 15),
          child: const Text(
            "Enter Detials",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          padding: const EdgeInsets.only(
            left: 15,
          ),
          height: MediaQuery.of(context).size.height * 0.15,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.grey),
              borderRadius: BorderRadius.circular(12)),
          child: TextField(
            controller: _titleCtrl,
            textAlign: TextAlign.start,
            maxLines: null,
            expands: true,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Write something...',
                hintStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        GestureDetector(
          onTap: () {
            context.read<NoticController>().getFileBase64String(context);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: blue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text("Upload image"),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottom() {
    var file = context.watch<NoticController>().fileBase64;
    LoadingStatus loadingStatus =
        context.watch<NoticController>().createSolutionLoading;
    bool isLoading = loadingStatus == LoadingStatus.loading ? false : true;
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: BtnCreateUser(
            title: 'Send',
            // loading: isLoading,
            callback: () {
              // context.read<SolutionController>().setLoadingCreateSolution();
              'loading'.log();
              if (_titleCtrl.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please input something'),
                  ),
                );
              } else {
                context
                    .read<NoticController>()
                    .createNotic(_titleCtrl.text, file)
                    .then((value) {
                  if (value == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('created successfully...'),
                      ),
                    );
                    Future.delayed(const Duration(milliseconds: 600), () {
                      Navigator.pop(context);
                      if (!mounted) return;
                      context.read<NoticController>().setLoading();
                      context.read<NoticController>().readNotic();
                    });
                  } else {
                    _titleCtrl.text = '';
                    file = ' ';
                  }
                });
                'title: ${_titleCtrl.text}'.log();
                'file: $file'.log();
              }
            }));
  }
}
