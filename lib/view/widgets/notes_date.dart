import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DateSection extends StatelessWidget {
  final String date;
  final String month;
  final String year;
  final String day;

  const DateSection({super.key,required this.date, required this.month, required this.year, required this.day});

  @override
  Widget build(BuildContext context) {
    // DateTime now = DateTime.now();

    // final String date = DateFormat("dd").format(now);
    // final String month = DateFormat("MMMM").format(now);
    // final String year = DateFormat("yyyy").format(now);
    // final String day = DateFormat("EEEE").format(now);

    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 20,horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 8,
            children: [
              Text(
                date,
                style: TextStyle(
                  fontSize: 38.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Text(
                month,
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Text(
            "$year, $day",
            style: TextStyle(fontSize: 20.sp, color: const Color.fromARGB(255, 206, 206, 205)),
          ),
        ],
      ),
    );
  }
}