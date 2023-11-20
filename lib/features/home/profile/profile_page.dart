import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onlineshop/core/auth/phone_number.dart';
import 'package:onlineshop/features/home/feedback/feedback_page.dart';
import 'package:onlineshop/features/home/profile/get_carts.dart';
import 'package:onlineshop/features/home/profile/get_users.dart';
import 'package:onlineshop/presentation/widgets/header_component.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

bool value1 = false;
bool lang = false;
String _language = 'uz';

bool _iconBool = false;

IconData _iconLight = Icons.wb_sunny;
IconData _iconDark = Icons.nights_stay;

class _ProfilePageState extends State<ProfilePage> {

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
    final themeMode = EasyDynamicTheme.of(context).themeMode;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            const HeaderWidget(),
            30.r.verticalSpace,
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const FeedbackPage()));
              },
              child: Row(
                children: [
                  30.r.horizontalSpace,
                  Icon(Icons.sms_outlined, color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Color(0xff323232),),
                  8.r.horizontalSpace,
                  Text("Feedback", style: GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 16.sp, color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff222222)),)
                ],
              ),
            ),
            20.r.verticalSpace,
            GestureDetector(
              onTap: (){
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 35),
                      child: SizedBox(
                        height: 380.h, // Adjust the height as needed
                        child: Column(
                          children: [
                            Text("Please choose language !!!", style: GoogleFonts.sansitaSwashed(fontSize: 22.sp),),
                            SizedBox(
                              height: 16.h,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xffDB4F2B))),
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
                                  border: Border.all(color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xffDB4F2B))),
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
                                  border: Border.all(color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xffDB4F2B))),
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
                                  Navigator.pop(context);
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
                  },
                );
              },
              child: Row(
                children: [
                  30.r.horizontalSpace,
                  Icon(Icons.language, color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff323232),),
                  8.r.horizontalSpace,
                  Text("Language", style: GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 16.sp, color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff222222)),)
                ],
              ),
            ),
            20.r.verticalSpace,
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const UserList()));
              },
              child: Row(
                children: [
                  30.r.horizontalSpace,
                  Icon(Icons.person_outlined, color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Color(0xff323232),),
                  8.r.horizontalSpace,
                  Text("Users", style: GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 16.sp, color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff222222)),)
                ],
              ),
            ),
            20.r.verticalSpace,
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CartList()));
              },
              child: Row(
                children: [
                  30.r.horizontalSpace,
                  Icon(Icons.shopping_basket_outlined, color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Color(0xff323232),),
                  8.r.horizontalSpace,
                  Text("Users Cards", style: GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 16.sp, color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff222222)),)
                ],
              ),
            ),
            16.r.verticalSpace,
            Row(
              children: [
              30.r.horizontalSpace,
                Icon( _iconBool ? _iconLight : _iconLight),
              8.r.horizontalSpace,
              Text(
                _iconBool ? "Light Mode" : "Dark Mode",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff222222),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Switch.adaptive(
                  // applyCupertinoTheme: true,
                  value: EasyDynamicTheme.of(context).themeMode == ThemeMode.dark,
                  onChanged: (value) {
                    setState(() {
                      // Toggle the theme mode
                      EasyDynamicTheme.of(context).changeTheme();
                    });
                  },
                ),
              ),
          ],
        ),
        16.r.verticalSpace,
            GestureDetector(
              onTap: (){
                showLogoutAlertDialog();
              },
              child: Row(
                children: [
                  30.r.horizontalSpace,
                  const Icon(Icons.logout, color: Colors.red,),
                  8.r.horizontalSpace,
                  Text("Logout", style: GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 16.sp, color: Colors.red),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showLogoutAlertDialog() {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('LogOut App?'),
            content: const Text('Are you sure you want to logut the app?'),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const PhoneNumber()),
                  );
                },
                child: const Text('Continue'),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Cancel'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete All Products?'),
            content: const Text('Are you sure you want to delete all products from the cart?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const PhoneNumber()),
                  );
                },
                child: const Text('Continue'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Cancel'),
              ),
            ],
          );
        },
      );
    }
  }

}
