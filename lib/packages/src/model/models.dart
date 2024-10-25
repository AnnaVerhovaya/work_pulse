abstract class DatabaseObject {
  /// Назавание таблицы в БД, где хранятся объекты даного типа
  static const String? table = null;

  DatabaseObject();

  /// Десериализация данных, полученных из БД
  DatabaseObject.load(Map<String, dynamic> data);

  /// Сериализация данных для сохранения в БД
  Map<String, Object?> dump();
}

class WorkDay extends DatabaseObject {
  final DateTime timestamp;
  final double hours;
  final double salary;

  WorkDay({required this.timestamp, required this.hours, required this.salary});

  WorkDay.load(Map<String, dynamic> data)
      : timestamp = data["timestamp"],
        hours = data["hours"],
        salary = data["salary"];

  @override
  Map<String, Object?> dump() => <String, Object?>{
        "timestamp": timestamp,
        "hours": hours,
        "salary": salary,
      };
}

class MonthSummary {
  int month;
  int year;
  double totalSalary;

  MonthSummary({required this.month, required this.year, required this.totalSalary});
}