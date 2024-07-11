import 'dart:async';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Messages {
  static String get appTitle => Intl.message('Мои дела', name: 'appTitle');
  static String get save => Intl.message('СОХРАНИТЬ', name: 'save');
  static String get newTaskHint =>
      Intl.message('Что надо сделать...', name: 'newTaskHint');
  static String get priority => Intl.message('Приоритет', name: 'priority');
  static String get high => Intl.message('! Высокий', name: 'high');
  static String get medium => Intl.message('Средний', name: 'medium');
  static String get low => Intl.message('Низкий', name: 'low');
  static String get selectDate =>
      Intl.message('Выбрать дату', name: 'selectDate');
  static String get delete => Intl.message('Удалить', name: 'delete');
  static String get completed => Intl.message('Выполнено', name: 'completed');
  static String get visibilityOn =>
      Intl.message('Показать завершённые', name: 'visibilityOn');
  static String get visibilityOff =>
      Intl.message('Скрыть завершённые', name: 'visibilityOff');
  static String get newTask => Intl.message('Новое', name: 'New');
  static String get ddmmyy => Intl.message('дд/мм/гг', name: 'dd/mm/yy');
  static String get doBefore => Intl.message('До', name: 'do before');
  static String get saveButton => Intl.message('СОХРАНИТЬ', name: 'SAVE');
}

Future<void> initializeMessages() async {
  await initializeDateFormatting();
  Intl.defaultLocale = Intl.systemLocale;
}
