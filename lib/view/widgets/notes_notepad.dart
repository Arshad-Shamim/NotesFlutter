import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes/model/note_question.dart';

class NotesPad extends StatefulWidget {

  final TextEditingController titleController;
  final TextEditingController noteController;
  final List<NoteQuestion>? quesList;

  const NotesPad({super.key, required this.titleController, required this.noteController, this.quesList});

  @override
  State<NotesPad> createState() => _NotesPadState();
}

class _NotesPadState extends State<NotesPad> {

  final double lineSpacing = 28.h;
  final double fontSize = 16.sp;


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
              controller: widget.titleController,
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                
                    TextField(
                      controller: widget.noteController,
                      maxLines: null,
                      style: TextStyle(
                        fontSize: fontSize,
                        height: lineSpacing / fontSize,
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
                
                    if (widget.quesList != null)
                      ListView.builder(
                        itemCount: widget.quesList!.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = widget.quesList![index];
                          
                          return Container(
                            margin: EdgeInsets.only(bottom: 12.h),
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Ques: ${item.question}",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  "Hint: ${item.hint}",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}