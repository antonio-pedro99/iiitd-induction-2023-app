class Event {
  final String title;
  final String description;
  final String? image;
  final String date;
  final String time;
  final String? venue;

  Event({
    required this.title,
    required this.description,
    this.image,
    required this.date,
    required this.time,
    this.venue,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['title'],
      description: json['description'],
      image: json['image'],
      date: json['date'],
      time: json['time'],
      venue: json['venue'],
    );
  }

  // dummy data
  static List<Event> items() {
    final List<Event> events = [
      Event(
          title: "Candance",
          description:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In bibendum vel lorem ut lobortis. Phasellus maximus felis ex, vel vehicula ante vulputate vel. Aenean faucibus tristique velit id luctus. Curabitur vitae consequat leo. Duis a sodales sapien, sit amet lobortis urna. Maecenas luctus lacus quis neque rutrum gravida. ",
          image: "",
          date: "",
          time: "12:30 AM",
          venue: ""),
      Event(
          title: "Odyssey",
          description:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In bibendum vel lorem ut lobortis. Phasellus maximus felis ex, vel vehicula ante vulputate vel. Aenean faucibus tristique velit id luctus. Curabitur vitae consequat leo. Duis a sodales sapien, sit amet lobortis urna. Maecenas luctus lacus quis neque rutrum gravida. ",
          image: "",
          date: "",
          time: "12:30 AM",
          venue: ""),
      Event(
          title: "Essya",
          description:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In bibendum vel lorem ut lobortis. Phasellus maximus felis ex, vel vehicula ante vulputate vel. Aenean faucibus tristique velit id luctus. Curabitur vitae consequat leo. Duis a sodales sapien, sit amet lobortis urna. Maecenas luctus lacus quis neque rutrum gravida. ",
          image: "",
          date: "",
          time: "12:30 AM",
          venue: ""),
      Event(
          title: "Something",
          description:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In bibendum vel lorem ut lobortis. Phasellus maximus felis ex, vel vehicula ante vulputate vel. Aenean faucibus tristique velit id luctus. Curabitur vitae consequat leo. Duis a sodales sapien, sit amet lobortis urna. Maecenas luctus lacus quis neque rutrum gravida. ",
          image: "",
          date: "",
          time: "12:30 AM",
          venue: "")
    ];
    return events;
  }
}
