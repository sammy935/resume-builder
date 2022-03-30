part of 'resume_bloc.dart';

abstract class ResumeEvent extends Equatable {
  const ResumeEvent();

  // class UpdateTaskListEvent extends TaskEvent {
  // final List<TaskModel> tasks;
  //
  // UpdateTaskListEvent({required this.tasks});
  // @override
  // String toString() => 'UpdateTaskListEvent';
  // }
  //
  // class AddTaskEvent extends TaskEvent {
  // final String description;
  // final String userId;
  // final double weight;
  // final DateTime createdTime;
  //
  // AddTaskEvent({
  // required this.weight,
  // required this.description,
  // required this.createdTime,
  // required this.userId,
  // });
  //
  // @override
  // String toString() => 'AddTaskEvent';
  // }
  //
  // class UpdateTaskEvent extends TaskEvent {
  // final TaskModel updatedTask;
  //
  // UpdateTaskEvent({required this.updatedTask});
  //
  // @override
  // String toString() => 'UpdateTaskEvent';
  // }
  //
  // class DeleteTaskEvent extends TaskEvent {
  // final String taskId;
  // DeleteTaskEvent({required this.taskId});
  // @override
  // String toString() => 'DeleteTaskEvent';
  // }

}

abstract class GetTaskListEvent extends ResumeEvent {
  const GetTaskListEvent(this.id);
  final String id;
  @override
  String toString() => 'GetTaskListEvent';
}
