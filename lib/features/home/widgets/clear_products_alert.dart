// import 'package:flutter/cupertino.dart' as cupertino;
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// void showClearConfirmationDialog() {
//   if (cupertino.CupertinoTheme.of(context).platform == TargetPlatform.iOS) {
//     showCupertinoDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return cupertino.CupertinoAlertDialog(
//           title: Text('Delete All Products?'),
//           content: Text('Are you sure you want to delete all products from the cart?'),
//           actions: [
//             cupertino.CupertinoDialogAction(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//                 clearCart(); // Clear the cart
//               },
//               child: Text('Continue'),
//             ),
//             cupertino.CupertinoDialogAction(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: Text('Cancel'),
//             ),
//           ],
//         );
//       },
//     );
//   } else {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Delete All Products?'),
//           content: Text('Are you sure you want to delete all products from the cart?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//                 clearCart(); // Clear the cart
//               },
//               child: Text('Continue'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: Text('Cancel'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
