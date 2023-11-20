import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlineshop/features/home/feedback/succed_page.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final themeMode = EasyDynamicTheme.of(context).themeMode;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // Dismiss the keyboard when tapping anywhere on the screen
        FocusScope.of(context).unfocus();
      },

      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.1,
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text(
            "O'z taklifingizni qoldiring",
            style: TextStyle(color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Color(0xff1F1F1F)),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Color(0xff323232),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(32.w, 18.h, 32.w, 40.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 18.h,
                ),
                const Center(
                  child:  Text("Dasturga baxo bering",style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {

                      },
                      child: Image.asset('assets/images/sad.png'),
                    ),
                    GestureDetector(
                      onTap: () {

                      },
                      child: Image.asset('assets/images/normal.png'),
                    ),
                    GestureDetector(
                      onTap: () {

                      },
                      child: Image.asset('assets/images/happy.png'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 54.h,
                ),
                const Text("Talab takliflar bo’lsa yozing",style: TextStyle(fontWeight: FontWeight.bold),),
                7.r.verticalSpace,
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Colors.black26),
                      borderRadius: BorderRadius.circular(4.r)),
                  child: Container(
                    padding: EdgeInsets.only(left: 16.w),
                    child: TextFormField(
                      onChanged: (e) {
                        // if (e.length > 0) {
                        //   _descriptionOnClick = true;
                        //   _descriptionColor = Colors.grey;
                        // } else {
                        //   _descriptionOnClick = false;
                        //   _descriptionColor = Colors.red;
                        // }
                        setState(() {});
                      },
                      controller: descriptionController,
                      maxLines: 10,
                      decoration: InputDecoration(
                        hintText:
                        'Shu yerga xabaringizni batafsil yozing ...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 14.sp, color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Colors.grey),
                      ),
                      cursorColor: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Colors.grey.shade800,
                      cursorWidth: 1.5.w,
                    ),
                  ),
                ),
                50.r.verticalSpace,
                GestureDetector(
                  onTap: () async {

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SuccedPage()));
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(23.w, 45.h, 23.w, 10.h),
                    child: Container(
                      width: 250.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: const Color(0xffEB6733)),
                      child: Center(
                          child: Text(
                            "Jo’natish",
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w400, color: const Color(0xffFFFFFF)),
                          )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
