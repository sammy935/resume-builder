import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resume_builder/utils/baseStrings.dart';

import '../model/resume_model.dart';

class UserDataProvider {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<List<Resume>?> getResumeList() {
    List<Resume> resumeList;
    return db
        .collection(BaseStrings.resumeCollectionPath)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .transform(StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
                List<Resume>>.fromHandlers(
            handleData: (QuerySnapshot<Map<String, dynamic>> docSnap,
                EventSink<List<Resume>> sink) {
          resumeList = List<Resume>.from(
            docSnap.docs.map(
              (snapshot) {
                if (snapshot.exists) {
                  return Resume.fromJson(snapshot.data());
                }
              },
            ),
          );
          sink.add(resumeList);
        }, handleError: (error, stackTrace, sink) {
          print('ERROR: $error');
          print(stackTrace);
          sink.addError(error);
        }, handleDone: (_) {
          print('done');
        }));
  }

  Future<bool> deleteTask(String id) async {
    try {
      await db.collection(BaseStrings.resumeCollectionPath).doc(id).delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addResume(Resume newTask) async {
    try {
      await db
          .collection(BaseStrings.resumeCollectionPath)
          .doc(newTask.id)
          .set(newTask.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateTask(Resume newTask) async {
    try {
      await db.collection(BaseStrings.resumeCollectionPath).doc(newTask.id).set(
            newTask.toJson(),
            SetOptions(merge: true),
          );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
