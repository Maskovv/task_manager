import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/task_list/task_list_cubit.dart';
import '../cubit/task_list/task_list_cubit_state.dart';
import '../widgets/task_list_item.dart';
import '../widgets/task_filter_chip.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  static const String path = '/tasks';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Задачи'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<TaskListCubit>().loadTasks(),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.go('/settings'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/new-task'),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const TaskFilterChips(),
          Expanded(
            child: BlocBuilder<TaskListCubit, TaskListCubitState>(
              builder: (context, state) {
                if (state is TaskListStateLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                if (state is TaskListStateSuccess) {
                  if (state.taskList.isEmpty) {
                    return const Center(
                      child: Text('Нет задач для выбранного фильтра'),
                    );
                  }
                  
                  return ListView.builder(
                    itemCount: state.taskList.length,
                    itemBuilder: (context, index) {
                      final task = state.taskList[index];
                      return Dismissible(
                        key: Key(task.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 16),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (_) => 
                          context.read<TaskListCubit>().removeTask(task),
                        child: TaskListItem(
                          task: task,
                          onToggleComplete: () => 
                            context.read<TaskListCubit>().changeCompleteStatusTask(task),
                          onDelete: () => 
                            context.read<TaskListCubit>().removeTask(task),
                        ),
                      );
                    },
                  );
                }
                
                if (state is TaskListStateFailure) {
                  return Center(
                    child: Text(
                      'Ошибка: ${state.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}