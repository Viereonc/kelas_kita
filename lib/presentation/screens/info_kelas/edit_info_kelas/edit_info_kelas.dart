import 'dart:io';
import 'package:flutter/material.dart';
import '../../../themes/Colors.dart';
import '../../../themes/FontsStyle.dart';
import '../../../widgets/Button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'edit_info_kelas_controller.dart';

class EditInfoKelasScreen extends StatelessWidget {
  final String description;
  final String imagePath;
  final int index;

  EditInfoKelasScreen({Key? key, required this.description, required this.imagePath, required this.index}) : super(key: key);

  final EditInfoKelasController controller = Get.put(EditInfoKelasController());

  @override
  Widget build(BuildContext context) {
    controller.initializeValues(description, imagePath);

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              AppBar(
                surfaceTintColor: Colors.white,
                title: Text("Edit Info Kelas", style: tsHeader2(screenSize: screenWidth),),
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
                    Text("Tambahkan \n Gambar", style: tsSubHeader4(screenSize: screenWidth, fontWeight: FontWeight.bold),),
                    GestureDetector(
                      onTap: () => controller.getImageFromGallery(),
                      child: Obx(() => Container(
                        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                        height: screenHeight * 0.2,
                        decoration: BoxDecoration(
                          color: controller.selectedImagePath.value != null
                              ? Colors.grey.shade200
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(5),
                          image: controller.selectedImagePath.value != null
                              ? DecorationImage(
                            image: FileImage(controller.selectedImagePath.value!),
                            fit: BoxFit.cover,
                          )
                              : null,
                        ),
                        child: controller.selectedImagePath.value == null
                            ? Container(
                          margin: EdgeInsets.all(15),
                          child: SvgPicture.asset("lib/assets/icons/pe_camera.svg"),
                        )
                            : null,
                        width: double.infinity,
                      )),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Deskripsi Pengumuman", style: tsSubHeader4(screenSize: screenWidth, fontWeight: FontWeight.bold),),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                      child: TextField(
                        controller: controller.descriptionController,
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
                  onPressed: () => controller.saveInfo(index, context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
