
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/model/resume_model.dart';


class HomeView extends StatefulWidget {
  const HomeView({Key? key, }) : super(key: key);


  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // late TaskBloc taskBloc;
  List<Resume> resumes = <Resume>[];
  @override
  void initState() {
    super.initState();
    // taskBloc.add(GetTaskListEvent(widget.user.uid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading:const SizedBox.shrink(),
        title:const Text(
          'HOME',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leadingWidth: Get.width * 0.25,

      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: resumes.length,
              itemBuilder: (context, index) {
                return SizedBox.shrink();
                // return TaskWidget(
                //   task: resumes[index],
                //   userId: widget.user.uid,
                // );
              },
              separatorBuilder: (c, i) {
                return const Divider();
              },
            ),
          ),
          SizedBox(
            height: Get.height * 0.09,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () => showAddTaskDialog(context),
        child:const Icon(Icons.add),
        mini: true,
        backgroundColor:const Color(0xFF27AEE4),
      ),
    );
  }

  void showAddTaskDialog(BuildContext context) {
    // showDialog(
    //     context: context,
    //     builder: (context) => BlocProvider.value(
    //       value: taskBloc,
    //       child: AddEditTaskDialog(
    //         title: "Add",
    //         userId: widget.user.uid,
    //       ),
    //     ));
  }
}

/*BlocConsumer(
        bloc: taskBloc,
        listener: (context, state) {
          // if (state is AddTaskCompleted ||
          //     state is UpdateTaskCompleted ||
          //     state is DeleteTaskCompleted) {
          //   taskBloc.add(GetTaskListEvent());
          // }
          print("$state in main page");
        },
        buildWhen: (previous, current) {
          if (current is GetTaskListInProgress ||
              current is GetTaskListCompleted ||
              current is GetTaskListFailed ||
              current is AddTaskInProgress ||
              current is AddTaskFailed ||
              current is UpdateTaskInProgress ||
              current is UpdateTaskFailed ||
              current is DeleteTaskInProgress ||
              current is DeleteTaskFailed) {
            return true;
          } else {
            return false;
          }
        },
        builder: (context, state) {
          if (state is GetTaskListInProgress ||
              state is AddTaskInProgress ||
              state is UpdateTaskInProgress ||
              state is DeleteTaskInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetTaskListCompleted) {
            if (state.tasks.isEmpty || state.tasks.length == 0)
              return Center(
                child: Text("No task available"),
              );
            else {
              tasks = state.tasks;
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return TaskWidget(
                          task: tasks[index],
                          userId: widget.user.uid,
                        );
                      },
                      separatorBuilder: (c, i) {
                        return Divider();
                      },
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.09,
                  ),
                ],
              );
            }
          } else {
            return Center(
              child: Text("No task available"),
            );
          }
        },
      )*/