import 'package:equatable/equatable.dart';
import 'package:to_do_app/blocs/bloc_exports.dart';

import '../../models/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
    on<MarkFavoriteOrUnfavoriteTask>(_onMarkFavoriteOrUnfavoriteTask);
    on<EditTask>(_onEditTask);
    on<RestoreTask>(_onRestoreTask);
    on<DeleteAllTasks>(_onDeleteAllTasks);

  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit){
    final state = this.state;
    emit(TasksState(
      pendingTasks: List.from(state.pendingTasks)..add(event.task),
      completeTasks: List.from(state.completeTasks),
      favoriteTasks: List.from(state.favoriteTasks),
      removedTasks: state.removedTasks
    ));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit){
    final state = this.state;
    final task = event.task;

    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completeTasks = state.completeTasks;
    task.isDone == false
    ? {
      pendingTasks = List.from(pendingTasks)..remove(task),
      completeTasks = List.from(completeTasks)..insert(0, task.copyWith(isDone: true))
    }
    : {
      completeTasks = List.from(completeTasks)..remove(task),
      pendingTasks = List.from(pendingTasks)..insert(0, task.copyWith(isDone: false))
    };

    emit(
        TasksState(
            pendingTasks: pendingTasks,
            completeTasks: completeTasks,
            favoriteTasks: state.favoriteTasks,
            removedTasks: state.removedTasks
        )
    );
  }
  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit){
    final state = this.state;
    emit(
        TasksState(
          pendingTasks: state.pendingTasks,
          completeTasks: state.completeTasks,
          favoriteTasks: state.favoriteTasks,
          removedTasks: List.from(state.removedTasks)..remove(event.task)
    ));
  }

  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit){
    final state = this.state;
    emit(TasksState(
        pendingTasks: List.from(state.pendingTasks)..remove(event.task),
        completeTasks: List.from(state.completeTasks)..remove(event.task),
        favoriteTasks: List.from(state.favoriteTasks)..remove(event.task),
        removedTasks: List.from(state.removedTasks)..add(event.task.copyWith(isDeleted : true))
    ));
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
      return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }


  void _onMarkFavoriteOrUnfavoriteTask( MarkFavoriteOrUnfavoriteTask event, Emitter<TasksState> emit){
    final state = this.state;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completeTasks = state.completeTasks;
    List<Task> favoriteTasks = state.favoriteTasks;
    if (event.task.isDone == false)
    {
      if (event.task.isFavorite == false) {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
      }else{
        var taskIndex = pendingTasks.indexOf (event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favoriteTasks.remove(event.task);
      }
    }else{
      var taskIndex = completeTasks.indexOf(event.task);
      completeTasks = List.from(completeTasks)
        ..remove(event.task)
        ..insert(taskIndex, event.task.copyWith(isFavorite: false));
      favoriteTasks.remove(event.task);

    }
    emit(TasksState(
      pendingTasks: pendingTasks,
      completeTasks: completeTasks,
      favoriteTasks: favoriteTasks,
      removedTasks: state.removedTasks,
    ));
  }


  void _onEditTask(EditTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> favouriteTasks = state.favoriteTasks;
    if (event.oldTask.isFavorite == true) {
      favouriteTasks
        ..remove(event.oldTask)
        ..insert(0, event.newTask);
    }
    emit(
        TasksState(
          pendingTasks: List.from(state.pendingTasks)
            ..remove(event.oldTask)
            ..insert(0, event.newTask),
          completeTasks: state.completeTasks..remove(event.oldTask), favoriteTasks: favouriteTasks,
          removedTasks: state.removedTasks,
        ),
    );// TasksState
    }


  void _onRestoreTask(RestoreTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        removedTasks: List.from(state.removedTasks)
          ..remove(event.task),
        pendingTasks: List.from(state.pendingTasks)
          ..insert(0,
              event.task.copyWith(
                isDeleted: false,
                isDone: false,
                isFavorite: false,
              )),
        completeTasks: state.completeTasks,
        favoriteTasks: state.favoriteTasks,
      ),
    );
  }

  void _onDeleteAllTasks(DeleteAllTasks event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        removedTasks: List.from(state.removedTasks)..clear(),
        pendingTasks: state.pendingTasks,
        completeTasks: state.completeTasks,
        favoriteTasks: state.favoriteTasks,
      ),
    );
  }
}




