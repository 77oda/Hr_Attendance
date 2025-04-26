import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:hr_attendance/core/networking/firebase_failures.dart';
import 'package:hr_attendance/core/theming/constants.dart';
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
}
