// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:kelas_kita/presentation/themes/FontsStyle.dart';
//
// Widget bottomSheet (BuildContext context) {
//
//   double screenHeight = MediaQuery.of(context).size.height;
//   double screenWidth = MediaQuery.of(context).size.width;
//
//   return Container(
//     width: double.infinity,
//     height: screenHeight * 0.2,
//     margin: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
//     child: Column(
//       children: [
//         Text('Pilih Foto Profile', style: tsSubHeader3(fontWeight: FontWeight.w700),),
//         SizedBox(height: screenHeight * 0.03,),
//         InkWell(
//           child: Column(
//             children: [
//               Icon(Icons.image, size: 40,),
//               SizedBox(height: screenHeight * 0.01,),
//               Text('Gallery', style: tsSubHeader4(fontWeight: FontWeight.w700),)
//             ],
//           ),
//           onTap: () {takePhoto(ImageSource.gallery)},
//         )
//       ],
//     ),
//   );
// }