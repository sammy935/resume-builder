import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:resume_builder/data_provider/user_data_provider.dart';
import 'package:resume_builder/model/resume_model.dart';
import 'package:resume_builder/utils/base_extension.dart';

part 'resume_event.dart';
part 'resume_state.dart';

class ResumeBloc extends Bloc<ResumeEvent, ResumeState> {
  ResumeBloc() : super(ResumeInitial()) {
    final UserDataProvider userDataProvider = UserDataProvider();
    late StreamSubscription? streamSubscription;

    void handleGetTaskListEvent(Emitter emit) {
      emit(GetTaskListInProgress());
      streamSubscription?.cancel();
      try {
        streamSubscription = userDataProvider.getResumeList().listen((event) {
          if (event != null) {
            emit(GetTaskListCompleted(resumes: event));
          }
        });
      } catch (e) {
        emit(const GetTaskListFailed(message: 'Error occurred'));
      }
    }

    on<ResumeEvent>((event, emit) {
      if (event is GetTaskListEvent) {
        handleGetTaskListEvent(emit);
      }
    });
    close();
  }
}
