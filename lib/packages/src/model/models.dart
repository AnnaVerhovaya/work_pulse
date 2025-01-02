abstract class DatabaseObject {
  /// Назавание таблицы в БД, где хранятся объекты даного типа
  static const String? table = null;

  DatabaseObject();

  /// Десериализация данных, полученных из БД
  DatabaseObject.load(Map<String, dynamic> data);

  /// Сериализация данных для сохранения в БД
  Map<String, Object?> dump();
}

class WorkEntry extends DatabaseObject {
  final int id;
  final DateTime date;
  final double hoursWorked;
  final double hourRate;
  final double totalIncome;
  final bool isWorkingDay;

  WorkEntry({
    required this.id,
    required this.date,
    required this.hoursWorked,
    required this.hourRate,
    required this.totalIncome,
    required this.isWorkingDay,
  });

  WorkEntry.load(Map<String, dynamic> data)
      : date = DateTime.fromMillisecondsSinceEpoch(data["date"]),
        id = data["id"],
        hoursWorked = data["hoursWorked"],
        hourRate = data["hourRate"],
        totalIncome = data["totalIncome"],
        isWorkingDay = data["isWorkDay"] == 1;

  @override
  Map<String, Object?> dump() => <String, Object?>{
        "id": id,
        "timestamp": date,
        "hours": hoursWorked,
        "salary": hourRate,
        "total_income": totalIncome,
        "isWorkDay": isWorkingDay,
      };
}

class MonthSummary {
  int month;
  int year;
  double totalSalary;

  MonthSummary(
      {required this.month, required this.year, required this.totalSalary});
}
