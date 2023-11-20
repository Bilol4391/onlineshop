import 'dart:async';

import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onlineshop/features/home/main_screen.dart';
import 'package:sms_autofill/sms_autofill.dart';

// ignore: must_be_immutable
class PhoneSmsConfirmation extends StatefulWidget {
  String? phone;
  PhoneSmsConfirmation({Key? key, required this.phone}) : super (key: key);

  @override
  State<PhoneSmsConfirmation> createState() => _PhoneSmsConfirmationState();
}

class _PhoneSmsConfirmationState extends State<PhoneSmsConfirmation> {

  final TextEditingController _controller = TextEditingController();

  String _code = "";
  int _secoundCount = 59;
  int _minutCount = 2;
  bool _timeOf = false;
  Timer? _timer;


  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        _secoundCount -= 1;
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final themeMode = EasyDynamicTheme.of(context).themeMode;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // appBar: AppBar(
      //   backgroundColor: const Color(0xffFFFFFF),
      //   elevation: 0.1,
      //   leading: GestureDetector(onTap: (){
      //     Navigator.pop(context);
      //   },child: Padding(padding: EdgeInsets.only(left: 20.sp), child: Icon(Icons.arrow_back, size: 22.sp, color: const Color(0xff323232),),)),
      // ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(19.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.r.verticalSpace,
              Center(child: Image.asset("assets/icons/storelingLogo.png")),
              50.r.verticalSpace,
              Center(
                child: Text(
                  "SMS Tasdiqlash",
                  style: GoogleFonts.inter(
                      color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                      fontSize: 32),
                ),
              ),
              13.r.verticalSpace,
              Text(
                "Sizga SMS xabar jo’natdik , dasturga kirish uchun SMS xabardagi kod bilan tasdiqlang ! ", textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff222222),
                    height: 1.6,
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp),
              ),
              25.r.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                child: PinFieldAutoFill(
                  controller: _controller,
                  decoration:  BoxLooseDecoration(
                    textStyle: TextStyle(fontSize: 20.sp, color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Colors.black),
                    strokeColorBuilder: const FixedColorBuilder(Color(0xffE4E4E4)),
                  ),
                  currentCode: _code, // prefill with a code
                  codeLength: 5, //code length, default 6
                  onCodeChanged: (code) {
                    setState(() {
                      _code = code!;
                    });
                  },
                ),
              ),
              30.r.verticalSpace,
              Center(
                child: Text(
                  _secoundCount > 9
                      ? "0$_minutCount:$_secoundCount"
                      : "0$_minutCount:0$_secoundCount",
                  style: GoogleFonts.inter(color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff222222), fontWeight: FontWeight.w500, fontSize: 16.sp),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    if (_timeOf) {
                      _timeOf = false;
                      _minutCount = 2;
                      _secoundCount = 59;
                      _timer = Timer.periodic(
                        const Duration(seconds: 1),
                            (timer) {
                          _secoundCount -= 1;
                          setState(() {});
                        },
                      );
                    }
                  },
                  child: Text(
                    "Qayta jo’natish",
                    style: TextStyle(
                        color: !_timeOf
                            ? themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff222222)
                            : themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff222222)),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: (){

                },
                child: ElevatedButton(
                  onPressed: () {
                    final phoneNumber = widget.phone.toString().replaceAll(' ', '');
                    // Add this line

                    if (phoneNumber == '+998994384391') {
                      if (_controller.text.toString() == '11111') {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (_) => const MainPage(),
                        )).then((_) {
                          // Remove all routes from the stack except PhoneNumber
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        });
                      } else {
                        if (_controller.text.isEmpty) {
                          // Show "Please enter the code" snackbar if the code is empty
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter the code'),
                            ),
                          );
                        } else if (_controller.text.length != 5) {
                          // Show "Invalid password" snackbar if the code length is not 5
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Invalid password'),
                            ),
                          );
                        } else {
                          // Show "Sms Code is incorrect" snackbar for other cases
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Sms Code is incorrect'),
                            ),
                          );
                        }
                      }
                    } else if (phoneNumber == '+998998073046') {
                      if (_controller.text.toString() == '22222') {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (_) => const MainPage(),
                        )).then((_) {
                          // Remove all routes from the stack except PhoneNumber
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        });
                      } else {
                        if (_controller.text.isEmpty) {
                          // Show "Please enter the code" snackbar if the code is empty
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter the code'),
                            ),
                          );
                        } else if (_controller.text.length != 5) {
                          // Show "Invalid password" snackbar if the code length is not 5
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Invalid password'),
                            ),
                          );
                        } else {
                          // Show "Sms Code is incorrect" snackbar for other cases
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Sms Code is incorrect'),
                            ),
                          );
                        }
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Phone number is incorrect'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffEB6733),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 48.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: Text(
                        "Next",
                        style: TextStyle(
                          color: const Color(0xffFFFFFF),
                          fontSize: 20.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
