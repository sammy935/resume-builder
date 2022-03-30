import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/utils/base_extension.dart';

String? validateEmpty({required String? name, required String element}) {
  if (name?.isEmpty ?? true) {
    return "$element can't be empty";
  } else {
    return null;
  }
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator(),
        Container(
            margin: const EdgeInsets.only(left: 15),
            child: const Text("Loading...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showSuccess(String operation) {
  Get.showSnackbar(GetSnackBar(
    title: '$operation was success',
    backgroundColor: Colors.green,
  ));
}

showError(String operation) {
  Get.showSnackbar(GetSnackBar(
    title: '$operation was success',
    backgroundColor: Colors.red,
  ));
}

String? validateEmail({required String? email}) {
  RegExp emailRegExp = RegExp(
      r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");

  if (email?.isEmpty ?? true) {
    return 'Email can\'t be empty';
  } else if (!emailRegExp.hasMatch(email!)) {
    return 'Enter a correct email';
  }

  return null;
}

dynamic dateTimeToJson(DateTime? object) {
  // print("to json of custom timestamp");
  return object != null ? Timestamp.fromDate(object) : null;
}

DateTime? dateTimeFromJson(dynamic val) {
  // print("from json of custom timestamp");
  Timestamp? timestamp;
  if (val is Timestamp) {
    timestamp = val;
  } else if (val is Map) {
    throw "val is not timestamp";
  }
  if (timestamp != null) {
    return timestamp.toDate();
  } else {
    'Unable to parse Timestamp from $val'.toLog;
    return null;
  }
}
