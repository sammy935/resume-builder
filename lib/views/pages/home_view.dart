import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/data_provider/user_data_provider.dart';
import 'package:resume_builder/model/resume_model.dart';
import 'package:resume_builder/utils/base_strings.dart';
import 'package:resume_builder/utils/routes.dart';
import 'package:resume_builder/widgets/appbar.dart';
import 'package:resume_builder/widgets/resume_list_tile.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Resume>? resumes;
  UserDataProvider userDataProvider = UserDataProvider();
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {});

    super.initState();
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'HOME'),
      body: resumes == null
          ? const Center(child: CircularProgressIndicator())
          : resumes!.isEmpty
              ? textWidget('No data found')
              : ReorderableListView.builder(
                  shrinkWrap: true,
                  onReorder: (oldIndex, newIndex) {
                    debugPrint("reorder caleed");
                    setState(() {
                      if (newIndex > oldIndex) {
                        newIndex = newIndex - 1;
                      }
                      final item = resumes!.removeAt(oldIndex);
                      resumes!.insert(newIndex, item);
                    });
                  },
                  itemCount: resumes!.length,
                  itemBuilder: (context, index) {
                    return ResumeListTile(
                      resume: resumes![index],
                      key: ValueKey(resumes![index]),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () => showAddTaskDialog(context),
        child: const Icon(Icons.add),
        mini: true,
        backgroundColor: const Color(0xFF27AEE4),
      ),
    );
  }

  void showAddTaskDialog(BuildContext context) {
    Get.toNamed(Routes.addEditResume, arguments: {BaseStrings.title: 'Add'});
  }

  Widget textWidget(String text) {
    return Center(
      child: Text(text),
    );
  }
}
