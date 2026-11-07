class AbsensiInfo {
  final int userId;
  final int id;
  final String title;
  final String body;


  const AbsensiInfo({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });


  // Factory constructor untuk mengonversi Map JSON ke Objek AbsensiInfo
  factory AbsensiInfo.fromJson(Map<String, dynamic> json) {
    return AbsensiInfo(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}