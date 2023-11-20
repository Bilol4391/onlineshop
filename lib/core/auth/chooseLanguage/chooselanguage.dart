import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlineshop/core/auth/phone_number.dart';

class Chooselanguage extends StatefulWidget {
  const Chooselanguage({Key? key}) : super(key: key);

  @override
  State<Chooselanguage> createState() => _ChooselanguageState();
}

bool value1 = false;
bool lang = false;
String _language = 'uz';

class _ChooselanguageState extends State<Chooselanguage> {

  @override
  void initState() {
    super.initState();

    // Clear the login option when the page is initialized
    _clearLoginOption();
  }

  void _clearLoginOption() {
    setState(() {
      _language = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
            padding: const EdgeInsets.fromLTRB(25, 80, 25, 45),
            child: Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Center(
                  child: Image.asset('assets/icons/simple-icons_googletranslate.png'),
                ),
                SizedBox(
                  height: 50.h,
                ),
                const Text('Пожалуйста, выберите язык !!!'),
                SizedBox(
                  height: 15.h,
                ),
                const Text("Iltimos tilni tanlang !!!"),
                SizedBox(
                  height: 15.h,
                ),
                const Text("Please choose language !!!"),
                SizedBox(
                  height: 36.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: const Color(0xffCCEDFF))),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        lang = true;
                        _language = 'uz';
                        value1 = true;
                      });
                    },
                    child: ListTile(
                      horizontalTitleGap: 0,
                      leading: Image.asset("assets/icons/uzb.png"),
                      title: SizedBox(
                          child: Text(
                            "O’zbek (Lotin)",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w600),
                          )),
                      trailing: _language == 'uz' && lang
                          ? CircleAvatar(
                        radius: 12.r,
                        child: Icon(
                          Icons.check,
                          size: 14.sp,
                        ),
                      )
                          : Container(
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(149, 149, 149, 1),
                            shape: BoxShape.circle,
                            border: Border.all(width: 1.w)),
                        child: CircleAvatar(
                          backgroundColor: const Color(0xffFFFFFF),
                          radius: 10.r,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: const Color(0xffCCEDFF))),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        lang = true;
                        _language = 'rus';
                        value1 = true;
                      });
                    },
                    child: ListTile(
                      horizontalTitleGap: 0,
                      leading: Image.asset("assets/icons/rus.png"),
                      title: SizedBox(
                          child: Text(
                            "Русский",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w600),
                          )),
                      trailing: _language == 'rus' && lang
                          ? CircleAvatar(
                        radius: 12.r,
                        child: Icon(
                          Icons.check,
                          size: 14.sp,
                        ),
                      )
                          : Container(
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(149, 149, 149, 1),
                            shape: BoxShape.circle,
                            border: Border.all(width: 1.w)),
                        child: CircleAvatar(
                          backgroundColor: const Color(0xffFFFFFF),
                          radius: 10.r,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: const Color(0xffCCEDFF))),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        lang = true;
                        _language = 'en';
                        value1 = true;
                      });

                    },
                    child: ListTile(
                      horizontalTitleGap: 0,
                      leading: Image.asset("assets/icons/vecteezy_united-kingdom-flat-rounded-flag-icon-with-transparent_16328983_68 1.png"),
                      title: SizedBox(
                          child: Text(
                            "English",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w600),
                          )),
                      trailing: _language == 'en' && lang
                          ? CircleAvatar(
                        radius: 12.r,
                        child: Icon(
                          Icons.check,
                          size: 14.sp,
                        ),
                      )
                          : Container(
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(149, 149, 149, 1),
                            shape: BoxShape.circle,
                            border: Border.all(width: 1.w)),
                        child: CircleAvatar(
                          backgroundColor: const Color(0xffFFFFFF),
                          radius: 10.r,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    if (lang) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const PhoneNumber()));
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              title: Text("Tilni tanglang !!!  "),
                            );
                          });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: lang ? const Color(0xffEB6733) : const Color(0xffEB6733).withOpacity(0.58),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 48.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      // color: AppColors.buttonLinear
                    ),
                    child: Center(
                      child: Text(
                        "Keyingi",
                        style: TextStyle(
                            color: const Color(0xffFFFFFF), fontSize: 20.sp),
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
