import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kelas_kita/presentation/widgets/Button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../themes/Colors.dart';
import '../../../themes/FontsStyle.dart';
import '../info_kelas_controller.dart';

class AddInfoKelas extends StatelessWidget {
  AddInfoKelas({Key? key}) : super(key: key);

  TextEditingController descriptionController = TextEditingController();
  final InfoKelasController infoKelasController = Get.find();

  Future<void> _getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      infoKelasController.selectedImagePath.value = File(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                title: Text(
                  "Tambah Info Kelas",
                  style: tsHeader2(screenSize: screenWidth),
                ),
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Container(
                    decoration: BoxDecoration(
                      color: primeryColorMedium,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Divider(color: Colors.grey, thickness: 0.5),
              Container(
                margin: EdgeInsets.symmetric(vertical: screenHeight * 0.03),
                width: double.infinity,
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tambahkan \n Gambar",
                      style: tsSubHeader4(
                          screenSize: screenWidth,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: _getImageFromGallery,
                      child: Obx(
                            () => Container(
                          margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                          height: screenHeight * 0.2,
                          decoration: BoxDecoration(
                            color: infoKelasController.selectedImagePath.value != null
                                ? Colors.grey.shade200
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(5),
                            image: infoKelasController.selectedImagePath.value != null
                                ? DecorationImage(
                              image: FileImage(infoKelasController.selectedImagePath.value!),
                              fit: BoxFit.cover,
                            )
                                : null,
                          ),
                          child: infoKelasController.selectedImagePath.value == null
                              ? Container(
                            margin: EdgeInsets.all(15),
                            child: SvgPicture.asset("lib/assets/icons/pe_camera.svg"),
                          ) : null,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Deskripsi Pengumuman",
                      style: tsSubHeader4(screenSize: screenWidth, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                      child: TextField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                          hintText: "Tambahkan Pengumuman",
                          hintStyle: tsParagraft4(screenSize: screenWidth).copyWith(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                        ),
                        maxLines: null,
                        minLines: 5,
                        style: TextStyle(height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: screenHeight * 0.03),
                child: Button(
                  label: "Unggah Informasi",
                  textStyle: tsSubHeader4(screenSize: screenWidth),
                  textColor: Colors.white,
                  backgroundColor: primeryColorMedium,
                  side: BorderSide.none,
                  onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    String? token = prefs.getString('token'); // Adjust token retrieval as needed

                    // Access the InfoKelasController instance
                    final infoKelasController = Get.find<InfoKelasController>();

                    // Ensure biografiList is not empty before accessing it
                    if (infoKelasController.biografiList.isNotEmpty) {
                      // Get idKelas from the first item in biografiList
                      String idKelas = infoKelasController.biografiList[0].idKelas.toString();

                      if (token != null && idKelas.isNotEmpty) {
                        await infoKelasController.addAndPostInfoKelas(
                          infoKelasController.selectedImagePath.value,
                          descriptionController.text,
                          idKelas,
                          token,
                        );
                        infoKelasController.selectedImagePath.value = null;
                        Navigator.pop(context);
                      } else {
                        print('Token or idKelas not found');
                      }
                    } else {
                      print('biografiList is empty');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
