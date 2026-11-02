import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import '../viewmodels/task_viewmodel.dart';
import '../viewmodels/theme_viewmodel.dart';
import 'task_edit_screen.dart';
import 'widgets/color_picker_dialog.dart';
import 'widgets/task_item_widget.dart';

class TaskListScreen extends ConsumerWidget {
  const TaskListScreen({super.key});

  void _openColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const ColorPickerDialog(),
    );
  }

  void _navigateToEdit(BuildContext context, Task task) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TaskEditScreen(task: task),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeColor = ref.watch(themeViewModelProvider);
    final tasksAsync = ref.watch(taskListViewModelProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: themeColor,
        elevation: 0,
        title: const Text(
          'Quản lý công việc',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.palette_outlined,
              color: Colors.white,
            ),
            tooltip: 'Chọn màu thanh ứng dụng',
            onPressed: () => _openColorPicker(context),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: tasksAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Lỗi: $err'),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () =>
                    ref.read(taskListViewModelProvider.notifier).refresh(),
                child: const Text('Thử lại'),
              ),
            ],
          ),
        ),
        data: (tasks) {
          if (tasks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.assignment_turned_in_outlined,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Không có công việc nào',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return TaskItemWidget(
                task: task,
                onEdit: () => _navigateToEdit(context, task),
              );
            },
          );
        },
      ),
    );
  }
}
