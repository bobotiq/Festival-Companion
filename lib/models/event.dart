class Event {
  final String id;
  final String title;
  final String stage;
  final DateTime startTime;
  final DateTime endTime;
  bool isFavorite;

  Event({
    required this.id,
    required this.title,
    required this.stage,
    required this.startTime,
    required this.endTime,
    this.isFavorite = false,
  });
}
