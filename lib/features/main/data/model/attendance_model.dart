import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceModel {
  final String status; // حضور / غياب / إجازة
  final String? checkIn;
  final String? checkOut;
  final String? date;

  AttendanceModel({
    required this.status,
    this.checkIn,
    this.checkOut,
    this.date,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      status: json['status'],
      checkIn: json['checkIn'],
      checkOut: json['checkOut'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'checkIn': checkIn,
      'checkOut': checkOut,
      'date': date,
    };
  }
}
