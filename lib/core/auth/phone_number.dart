import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onlineshop/core/auth/sms_confirmation.dart';

import 'chooseLanguage/chooselanguage.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({super.key});

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  final GlobalKey _key = GlobalKey();
  final TextEditingController _phoneController =
  TextEditingController(text: '+998');

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final themeMode = EasyDynamicTheme.of(context).themeMode;

    return Scaffold(
      key: _scaffoldKey,
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
              20.r.verticalSpace,
              Center(
                child: Image.asset('assets/icons/storelingLogo.png'),
              ),
              SizedBox(
                height: 50.h,
              ),
              Center(
                child: Text(
                  "Login",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 32.sp,
                    color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff000000),
                  ),
                ),
              ),
              70.r.verticalSpace,
              Text(
                "Phone number",
                style: GoogleFonts.inter(
                    color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff222222),
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
              TextFormField(
                inputFormatters: [
                  TextInputMask(
                    mask: '\\+ 999 99 999 99 99',
                    placeholder: '_ ',
                    maxPlaceHolders: 13,
                  )
                ],
                key: _key,
                controller: _phoneController,
                onChanged: (e) {
                },
                keyboardType: TextInputType.number,
                keyboardAppearance: Brightness.dark,
                decoration: const InputDecoration(
                  hintText: '998  _ _  _ _ _  _ _  _ _ ',
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff222222))),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffEB6733)))
                ),
              ),
              15.r.verticalSpace,
              RichText(
                text: TextSpan(
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                      decorationColor: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff6C6C6C),
                      height: 1.5),
                  children: <TextSpan>[
                    TextSpan(
                        text: '“Keyingi” tugmasini bosish bilan siz ',
                        style: TextStyle(color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Color(0xff6C6C6C))),
                    TextSpan(
                      text: 'foydalanuvchi shartnomasi',
                      style: TextStyle(
                        color: themeMode == ThemeMode.dark ? const Color(0xff375FFF) : Color(0xff41509C), // Set the text color to blue
                      ),
                    ),
                    TextSpan(
                      text: ' shartlarini qabul qilgan bo’lasiz',
                      style: TextStyle(color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Color(0xff6C6C6C)),
                    )
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  final enteredPhoneNumber = _phoneController.text;
                  final phoneNumber = enteredPhoneNumber.toString().replaceAll(' ', '');
                  if (phoneNumber.isEmpty) {
                    // Show "Please enter Phone Number" Snackbar if the controller is empty
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter Phone Number'),
                      ),
                    );
                  } else if (phoneNumber != '+998994384391' &&
                      phoneNumber != '+998998073046') {
                    // Show "Phone number is incorrect" Snackbar if the entered phone number is not valid
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Phone number is incorrect'),
                      ),
                    );
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) =>
                          PhoneSmsConfirmation(phone: phoneNumber),
                    ));
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
