import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/data_provider/user_data_provider.dart';
import 'package:resume_builder/model/resume_model.dart';
import 'package:resume_builder/utils/baseStrings.dart';
import 'package:resume_builder/utils/routes.dart';

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
  UserDataProvider _userDataProvider = UserDataProvider();

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
      contentPadding:
          EdgeInsets.only(left: Get.width * .10, bottom: Get.width * .02),
      subtitle: Text(
        subtitle,
        textScaleFactor: 0.8,
      ),
      title: Text(
        "Email: ${widget.resume.emailAddress ?? ''}",
        style: _taskStyle,
      ),
      trailing: PopupMenuButton(
        iconSize: Get.width * .10,
        onSelected: (newValue) {
          switch (newValue) {
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
            buildPopupMenuItem(Icons.delete, "Delete", 1),
            buildPopupMenuItem(Icons.edit, "Edit", 3),
          ];
        },
      ),
    );
  }

  PopupMenuItem<int> buildPopupMenuItem(
      IconData iconData, String text, int value) {
    return PopupMenuItem(
      value: value,
      padding: EdgeInsets.zero,
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        leading: Icon(
          iconData,
          color: Colors.black.withOpacity(0.5),
          size: 20.0,
        ),
        title: Text(text),
      ),
    );
  }

  TextStyle get _taskStyle {
    return const TextStyle(decoration: TextDecoration.none);
  }

  deleteResume() {
    _userDataProvider.deleteTask(widget.resume.id!);
  }

  void editResume() {
    Get.toNamed(Routes.addEditResume, arguments: {
      BaseStrings.title: "Edit",
      BaseStrings.updatedResume: widget.resume,
    });
  }
}
