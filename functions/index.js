const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

const db = admin.firestore();

exports.markAbsences = functions.pubsub.schedule('every day 23:59')
  .timeZone('Africa/Cairo')
  .onRun(async (context) => {
    const employeesSnapshot = await db.collection('employees').get();

    const today = new Date();
    const todayDate = today.toISOString().split('T')[0]; // YYYY-MM-DD

    // تحقق هل اليوم موجود في الإجازات الرسمية
    const holidayDoc = await db.collection('official_holidays').doc(todayDate).get();
    const isOfficialHoliday = holidayDoc.exists;

    // تحقق هل اليوم جمعة أو سبت
    const dayOfWeek = today.getDay();
    const isWeekend = (dayOfWeek === 5 || dayOfWeek === 6); // الجمعة = 5 ، السبت = 6

    for (const employeeDoc of employeesSnapshot.docs) {
      const employeeId = employeeDoc.id;

      const attendanceDoc = await db.collection('employees')
        .doc(employeeId)
        .collection('attendance')
        .doc(todayDate)
        .get();

      if (!attendanceDoc.exists) {
        const isHoliday = isWeekend || isOfficialHoliday;

        await db.collection('employees')
          .doc(employeeId)
          .collection('attendance')
          .doc(todayDate)
          .set({
            status: isHoliday ? 'إجازة' : 'غياب',
            checkIn: null,
            checkOut: null,
            date: todayDate,
          });

        console.log(`سجلت ${isHoliday ? 'إجازة' : 'غياب'} للموظف: ${employeeId}`);
      }
    }

    console.log('انتهى تسجيل الغيابات والإجازات');
    return null;
  });
