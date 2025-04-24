import 'package:dartz/dartz.dart';
import 'package:hr_attendance/core/networking/firebase_failures.dart';
import 'package:hr_attendance/features/main/data/model/empoloyee.dart';

abstract class MainRepo {
  Future<Either<Failure, EmployeeModel>> fetchEmployee();
}
