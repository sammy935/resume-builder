import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:resume_builder/data_provider/user_data_provider.dart';
import 'package:resume_builder/model/resume_model.dart';
import 'package:resume_builder/utils/base_extension.dart';

part 'resume_event.dart';
part 'resume_state.dart';

class ResumeBloc extends Bloc<ResumeEvent, ResumeState> {
  final UserDataProvider userDataProvider;
  late StreamSubscription? streamSubscription;

  ResumeBloc({required this.userDataProvider}) : super(ResumeInitial()) {
    on<ResumeEvent>((event, emit) {
      if (event is GetTaskListEvent) {
        if (emit.isDone) {
          emit.call(GetTaskListInProgress());
        }
        // streamSubscription?.cancel();
        try {
          streamSubscription = userDataProvider.getResumeList().listen((event) {
            if (event != null) {
              if (emit.isDone) {
                emit.call(GetTaskListCompleted(resumes: event));
              }
            }
          });
        } catch (e) {
          if (emit.isDone) {
            emit.call(const GetTaskListFailed(message: 'Error occurred'));
          }
        }
      }
    });
  }

  void handleGetTaskListEvent(Emitter emit) {}
}
