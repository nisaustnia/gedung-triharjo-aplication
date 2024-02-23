class Event {
  final int idEvent;
  final String event;
  final String descripsi;
  final String jenis;
  final int organisasi;
  final int perorangan;

  Event({
    required this.idEvent,
    required this.event,
    required this.descripsi,
    required this.jenis,
    required this.organisasi,
    required this.perorangan,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      idEvent: json['idEvent'] ?? 1,
      event: json['event'] ?? "",
      descripsi: json['descripsi'] ?? "",
      jenis: json['jenis'] ?? "",
      organisasi: json['organisasi'] ?? 0,
      perorangan: json['perorangan'] ?? 0,
    );
  }
}
