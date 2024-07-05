import '/feature/domain/entities/task_entity.dart';

abstract class TaskRepository {
  List<TaskEntity> getTasks();
  void addTask(TaskEntity task);
  void updateTask(TaskEntity task);
  void deleteTask(int id);
  void doneTask(TaskEntity task);
  void doneList(TaskEntity doneTask);
}
