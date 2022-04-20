import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:resume_builder/bloc/resume_bloc.dart';
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
  late ResumeBloc resumeBloc;

  @override
  void initState() {
    resumeBloc = BlocProvider.of<ResumeBloc>(context);
    resumeBloc.add(GetTaskListEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'HOME'),
      body: BlocBuilder<ResumeBloc, ResumeState>(
        builder: (context, state) {
          if (state is GetTaskListInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetTaskListFailed) {
            return textWidget('Error occurs');
          } else if (state is GetTaskListCompleted) {
            return state.resumes.isNotEmpty
                ? buildReOrderableListView(resumes!)
                : textWidget('No data found');
          } else {
            return textWidget('No data found');
          }
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

  ReorderableListView buildReOrderableListView(List resumes) {
    return ReorderableListView.builder(
      shrinkWrap: true,
      onReorder: (oldIndex, newIndex) {
        debugPrint("reorder caleed");
        setState(() {
          if (newIndex > oldIndex) {
            newIndex = newIndex - 1;
          }
          final item = resumes.removeAt(oldIndex);
          resumes.insert(newIndex, item);
        });
      },
      itemCount: resumes.length,
      itemBuilder: (context, index) {
        return ResumeListTile(
          resume: resumes[index],
          key: ValueKey(resumes[index]),
        );
      },
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
