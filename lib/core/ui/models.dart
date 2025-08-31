class AttendanceDataPoint {
  final String date;
  final String shortDate;
  final int presentCount;
  final int absentCount;
  final int lateCount;
  final int excusedCount;

  AttendanceDataPoint({
    required this.date,
    required this.shortDate,
    required this.presentCount,
    required this.absentCount,
    required this.lateCount,
    required this.excusedCount,
  });
}
