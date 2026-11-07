class Student {
  final int id;
  final String nim;
  final String name;
  final String major;
  final int semester;
  final String email;
  final int attendance;

  const Student({
    required this.id,
    required this.nim,
    required this.name,
    required this.major,
    required this.semester,
    required this.email,
    required this.attendance,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] as int,
      nim: json['nim'] as String,
      name: json['name'] as String,
      major: json['major'] as String,
      semester: json['semester'] as int,
      email: json['email'] as String,
      attendance: json['attendance'] as int,
    );
  }
}