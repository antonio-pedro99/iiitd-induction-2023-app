class Schedule {
  final String date;

  Schedule({required this.date});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(date: json['date']);
  }
}
