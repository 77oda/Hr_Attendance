import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceModel {
  final String status; // حضور / غياب / إجازة
  final String? checkIn;
  final String? checkOut;
  final String? note;
  final GeoPoint? location;

  AttendanceModel({
    required this.status,
    this.checkIn,
    this.checkOut,
    this.note,
    this.location,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      status: json['status'],
      checkIn: json['checkIn'],
      checkOut: json['checkOut'],
      note: json['note'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'checkIn': checkIn,
      'checkOut': checkOut,
      'note': note,
      'location': location,
    };
  }
}
