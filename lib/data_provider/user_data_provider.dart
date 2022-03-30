import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:resume_builder/utils/base_strings.dart';

import '../model/resume_model.dart';

class UserDataProvider {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<List<Resume>?> getResumeList() {
    List<Resume> resumeList;
    try{
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
            debugPrint('ERROR: $error');
            debugPrint(stackTrace.toString());
            sink.addError(error);
          }, handleDone: (_) {
            debugPrint('done');
          }));
    }catch(e){
      rethrow;
    }
  }

  Future<bool> deleteTask(String id) async {
    try {
      await db.collection(BaseStrings.resumeCollectionPath).doc(id).delete();
      return true;
    } catch (e) {
      debugPrint(e.toString());
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
      debugPrint(e.toString());
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
      debugPrint(e.toString());
      return false;
    }
  }
}
