import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceModel {
  final String status; // حضور / غياب / إجازة
  final Timestamp? checkIn;
  final Timestamp? checkOut;
  final Timestamp? date;

  AttendanceModel({
    required this.status,
    this.checkIn,
    this.checkOut,
    this.date,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      status: json['status'],
      checkIn: json['checkIn'] != null ? json['checkIn'] as Timestamp : null,
      checkOut: json['checkOut'] != null ? json['checkOut'] as Timestamp : null,
      date: json['date'] != null ? json['date'] as Timestamp : null,
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
