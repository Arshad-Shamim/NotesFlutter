import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotesPad extends StatefulWidget {
  const NotesPad({super.key});

  @override
  State<NotesPad> createState() => _NotesPadState();
}

class _NotesPadState extends State<NotesPad> {

  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          padding: EdgeInsets.all(16.w),
          decoration:BoxDecoration(
            color: Color(0xFFFFFBF2),
            borderRadius: BorderRadius.circular(16.r),
          ),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                hintText: "Title",
                border: InputBorder.none,
              ),
            ),
            SizedBox(height: 8,),
            Expanded(
              child: Stack(
                children: [
                  CustomPaint(
                    painter: NotebookLinesPainter(),
                    size: Size.infinite,
                  ),
                                  
                  // Text Field
                  TextField(
                    controller: noteController,
                    maxLines: null,
                    expands: true,
                    style: TextStyle(
                      fontSize: 16.sp,
                      height: 1.5,
                    ),
                    decoration: InputDecoration(
                      hintText: "Start writing your notes...",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 8.h,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NotebookLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.withOpacity(0.2)
      ..strokeWidth = 1;

    var lineSpacing = 28.h;

    for (double y = 0; y < size.height; y += lineSpacing) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}