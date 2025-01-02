class CalendarService {
  List<DateTime> getDates(int year, int month) {
    List<DateTime> dates = [];
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    DateTime lastDayOfMonth = DateTime(year, month + 1, 0);
    for (int day = firstDayOfMonth.day; day <= lastDayOfMonth.day; day++) {
      dates.add(DateTime(year, month, day));
    }
    return dates;
  }
}