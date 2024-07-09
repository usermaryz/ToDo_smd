import '/feature/domain/entities/task_entity.dart';

abstract class TaskRepository {
  List<TaskEntity> getTasks();
  void addTask(TaskEntity task, int revision);
  void updateTask(TaskEntity task, int revision);
  void deleteTask(String id, int revision);
  void doneTask(TaskEntity task, int revision);
  void doneList(TaskEntity doneTask, int revision);
}
