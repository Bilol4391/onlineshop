import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlineshop/features/home/main_screen.dart';

class SuccedPage extends StatefulWidget {
  const SuccedPage({Key? key}) : super(key: key);

  @override
  State<SuccedPage> createState() => _SuccedPageState();
}

class _SuccedPageState extends State<SuccedPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: EdgeInsets.fromLTRB(25.w, 115.h, 25.w, 0.h),
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Center(
                child:Image.asset('assets/images/succesfull.png')
            ),
            SizedBox(height: 50.h,),
            Center(child: Text("Muvaffaqiyatli jo'natildi",style: TextStyle(fontSize: 18.sp),)),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MainPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffEB6733),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),

                  ),
                ),
                child:  Container(
                  width: 250.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    // color: AppColors.buttonLinear
                  ),
                  child: Center(
                    child: Text(
                      "Asosiyga qaytish",
                      style: TextStyle(color: const Color(0xffFFFFFF),fontSize: 20.sp),
                    ),
                  ),
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
