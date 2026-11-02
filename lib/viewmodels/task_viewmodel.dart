import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/database_helper.dart';
import '../models/task_model.dart';

part 'task_viewmodel.g.dart';

@riverpod
class TaskListViewModel extends _$TaskListViewModel {
  @override
  FutureOr<List<Task>> build() async {
    return await DatabaseHelper.instance.getAllTasks();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => DatabaseHelper.instance.getAllTasks());
  }

  Future<void> updateTask(Task task) async {
    await DatabaseHelper.instance.updateTask(task);
    await refresh();
  }
}
