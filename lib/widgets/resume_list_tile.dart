import 'package:flutter/material.dart';
import 'package:resume_builder/model/resume_model.dart';

class ResumeListTile extends StatefulWidget {
  final Resume resume;

  const ResumeListTile({
    required Key key,
    required this.resume,
  }) : super(key: key);

  @override
  _ResumeListTileState createState() => _ResumeListTileState();
}

class _ResumeListTileState extends State<ResumeListTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String subtitle = '';
    subtitle = widget.resume.profileSummary?.isNotEmpty ?? false
        ? "Profile: ${widget.resume.profileSummary}" +
            '\nCreated at:${widget.resume.createdAt?.toLocal()}'
        : 'Created at:${widget.resume.createdAt?.toLocal()}';
    return ListTile(
      subtitle: Text(
        subtitle,
        textScaleFactor: 0.8,
      ),
      title: Text(
        "Skills: ${widget.resume.skills?.join(' ,') ?? ''}",
        style: _taskStyle,
      ),
      trailing: PopupMenuButton(
        onSelected: (newValue) {
          switch (newValue) {
            case 0:
              viewResume();
              break;
            case 1:
              deleteResume();
              break;
            case 3:
              editResume();
              break;
          }
        },
        onCanceled: () {},
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              value: 0,
              padding: EdgeInsets.zero,
              child: ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.remove_red_eye,
                  color: Colors.black.withOpacity(0.5),
                  size: 20.0,
                ),
                title: Text("View"),
              ),
            ),
            PopupMenuItem(
              value: 1,
              padding: EdgeInsets.zero,
              child: ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.delete,
                  color: Colors.black.withOpacity(0.5),
                  size: 20.0,
                ),
                title: Text("Delete"),
              ),
            ),
            PopupMenuItem(
              value: 3,
              padding: EdgeInsets.zero,
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.edit,
                  color: Colors.black.withOpacity(0.5),
                  size: 20.0,
                ),
                title: Text("Edit"),
              ),
            )
          ];
        },
      ),
    );
  }

  TextStyle get _taskStyle {
    return const TextStyle(decoration: TextDecoration.none);
  }

  deleteResume() {
    // taskBloc.add(DeleteTaskEvent(taskId: widget.task.id!));
  }

  viewResume() {
    // taskBloc.add(DeleteTaskEvent(taskId: widget.task.id!));
  }

  void editResume() {
    // TaskModel updatedTask = TaskModel(
    //   id: widget.task.id,
    //   description: widget.task.description,
    //   createdAt: widget.task.createdAt,
    //   weight: widget.task.weight,
    // );
    //
    // showDialog(
    //     context: context,
    //     builder: (context) => BlocProvider.value(
    //       value: taskBloc,
    //       child: AddEditTaskDialog(
    //         title: "Edit",
    //         updateTask: updatedTask,
    //         userId: widget.userId,
    //       ),
    //     ));
  }
}
