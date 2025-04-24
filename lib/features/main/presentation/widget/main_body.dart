import 'package:flutter/material.dart';
import 'package:hr_attendance/features/main/presentation/widget/employee_info.dart';

class MainBody extends StatelessWidget {
  const MainBody({super.key});

  Color _getStatusColor(String status) {
    switch (status) {
      case 'حضور':
        return Colors.green;
      case 'غياب':
        return Colors.red;
      case 'إجازة':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          EmployeeInfo(),
          SizedBox(height: 24),
          const Align(
            alignment: Alignment.centerRight,
            child: Text('جدول الحضور الشهري', style: TextStyle(fontSize: 18)),
          ),
          const SizedBox(height: 12),
          Expanded(
            // child: BlocBuilder<AttendantCubit, AttendantState>(
            //   builder: (context, state) {
            //     if (state is AttendantLoading) {
            //       return const Center(child: CircularProgressIndicator());
            //     } else if (state is AttendantLoaded) {
            //       final days = state.attendanceList;
            // return
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                // final day = days[index];
                // final date = DateTime.parse(day.checkIn ?? '');
                final statusColor = _getStatusColor('حضور');
                return Container(
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      // DateFormat('d').format(date)
                      '2025/4/30',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                );
              },
            ),
            //     } else {
            //       return const Text('فشل تحميل الجدول');
            //     }
            //   },
            // ),
          ),
        ],
      ),
    );
  }
}
