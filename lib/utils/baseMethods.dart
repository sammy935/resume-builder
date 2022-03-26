import 'package:cloud_firestore/cloud_firestore.dart';

String? validateEmpty({required String? name, required String message}) {
  if (name?.isEmpty ?? true) {
    return message;
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
    print('Unable to parse Timestamp from $val');
    return null;
  }
}
