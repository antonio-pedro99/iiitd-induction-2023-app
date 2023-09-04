class InfoStep {
  final String title;
  final String contents;
  final String? time;
  const InfoStep({required this.title, required this.contents, this.time});

  factory InfoStep.fromJson(Map<String, dynamic> json) {
    return InfoStep(
        title: json['title'], contents: json['contents'], time: json['time']);
  }
}
