import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:hr_attendance/core/networking/firebase_failures.dart';
import 'package:hr_attendance/core/theming/constants.dart';
import 'package:hr_attendance/features/main/data/model/attendance_model.dart';
import 'package:hr_attendance/features/main/data/model/empoloyee.dart';
import 'package:hr_attendance/features/main/data/repos/main_repo.dart';

class MainRepoImpl extends MainRepo {
  @override
  Future<Either<Failure, EmployeeModel>> fetchEmployee() async {
    try {
      final doc =
          await FirebaseFirestore.instance
              .collection('employees')
              .doc(phoneNumber)
              .get();

      if (doc.exists) {
        return Right(EmployeeModel.fromJson(doc.data()!));
      } else {
        return left(ServerFailure('الموظف غير موجود'));
      }
    } on FirebaseException catch (error) {
      return left(ServerFailure.fromFirebase(error));
    } catch (error) {
      return left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AttendanceModel>>> fetchAttendanceData() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection('employees')
              .doc(phoneNumber)
              .collection('attendance')
              .get();

      final List<AttendanceModel> attendanceList =
          snapshot.docs.map((doc) {
            return AttendanceModel(
              date: doc.id, // استخدام ID الوثيقة كـ "تاريخ اليوم"
              status:
                  doc['status'] ??
                  'غياب', // حالة الحضور (حضور، غياب، إجازة، ...).
              checkIn: doc['checkIn'] ?? '',
              checkOut: doc['checkOut'] ?? '',
            );
          }).toList();

      return right(attendanceList);
    } on FirebaseException catch (error) {
      return left(ServerFailure.fromFirebase(error));
    } catch (error) {
      return left(ServerFailure(error.toString()));
    }
  }
}
