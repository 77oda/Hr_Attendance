class EmployeeModel {
  final String name;
  final String phone;
  final String position;
  final String department;
  final String image;

  const EmployeeModel({
    required this.name,
    required this.phone,
    required this.position,
    required this.department,
    required this.image,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      position: json['position'] ?? '',
      department: json['department'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
