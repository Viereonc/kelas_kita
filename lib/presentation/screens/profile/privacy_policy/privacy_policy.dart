import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kelas_kita/presentation/screens/profile/privacy_policy/privacy_policy_cpntroller.dart';

import '../../../themes/Colors.dart';
import '../../../themes/FontsStyle.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  PrivacyPolicyScreen({Key? key}) : super(key: key);

  final PrivacyPolicyController privacyPolicyController = Get.put(PrivacyPolicyController());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: Text(
              "Privacy Policy",
              style: tsHeader2(
                screenSize: screenWidth,
              ),
            ),
            centerTitle: true,
            leading: Container(
              child: IconButton(
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
          ),
        ),
      ),
      body: Obx(() {
        if (privacyPolicyController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05, bottom: screenHeight * 0.1),
              child: Column(
                children: [
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  Container(
                    height: screenHeight * 0.35,
                    margin: EdgeInsets.only(top: screenHeight * 0.03),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: screenHeight * 0.35,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Kelas Kita', style: tsHeader3(
                                screenSize: screenWidth,
                              ),),
                              SizedBox(height: screenHeight * 0.02,),
                              Text('Last updated: March 14, 2024 This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.', style: tsParagraft4(
                                screenSize: screenWidth,
                              ),),
                              SizedBox(height: screenHeight * 0.02,),
                              Text('We use Your Personal data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy. This Privacy Policy has been created with the help of the Privacy Policy Generator.', style: tsParagraft4(
                                screenSize: screenWidth,
                              ),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03,),
                  Container(
                    height: screenHeight * 1.5,
                    margin: EdgeInsets.only(top: screenHeight * 0.03),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: screenHeight * 1.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Interpretation and Definitions', style: tsHeader2(
                                screenSize: screenWidth,
                              ),),
                              Text('Interpretation', style: tsHeader3(
                                screenSize: screenWidth,
                              ),),
                              Text('The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.', style: tsParagraft4(
                                screenSize: screenWidth,
                              ),),
                              SizedBox(height: screenHeight * 0.001,),
                              Text('Definitions', style: tsHeader3(
                                screenSize: screenWidth,
                              ),),
                              Text(
                                'For the purposes of this Privacy Policy:',
                                style: tsParagraft4(
                                  screenSize: screenWidth,
                                ),
                              ),
                              Text(
                                '\u2022 Account means a unique account created for You to access our Service or parts of our Service.',
                                style: tsParagraft4(
                                  screenSize: screenWidth,
                                ),
                              ),
                              Text(
                                '\u2022 Affiliate means an entity that controls, is controlled by or is under common control with a party, where "control" means ownership of 50% or more of the shares, equity interest or other securities entitled to vote for election of directors or other managing authority.',
                                style: tsParagraft4(
                                  screenSize: screenWidth,
                                ),
                              ),
                              Text(
                                '\u2022 Application refers to KelasKita, the software program provided by the Company.',
                                style: tsParagraft4(
                                  screenSize: screenWidth,
                                ),
                              ),
                              Text(
                                '\u2022 Company (referred to as either "the Company", "We", "Us" or "Our" in this Agreement) refers to Kelasikan, Kudus, Besito.',
                                style: tsParagraft4(
                                  screenSize: screenWidth,
                                ),
                              ),
                              Text(
                                '\u2022 Country refers to: Indonesia',
                                style: tsParagraft4(
                                  screenSize: screenWidth,
                                ),
                              ),
                              Text(
                                '\u2022 Device means any device that can access the Service such as a computer, a cellphone or a digital tablet.',
                                style: tsParagraft4(
                                  screenSize: screenWidth,
                                ),
                              ),
                              Text(
                                '\u2022 Personal Data is any information that relates to an identified or identifiable individual.',
                                style: tsParagraft4(
                                  screenSize: screenWidth,
                                ),
                              ),
                              Text(
                                '\u2022 Service refers to the Application.',
                                style: tsParagraft4(
                                  screenSize: screenWidth,
                                ),
                              ),
                              Text(
                                '\u2022 Service Provider means any natural or legal person who processes the data on behalf of the Company. It refers to third-party companies or individuals employed by the Company to facilitate the Service, to provide the Service on behalf of the Company, to perform services related to the Service or to assist the Company in analyzing how the Service is used.',
                                style: tsParagraft4(
                                  screenSize: screenWidth,
                                ),
                              ),
                              Text(
                                '\u2022 Third-party Social Media Service refers to any website or any social network website through which a User can log in or create an account to use the Service.',
                                style: tsParagraft4(
                                  screenSize: screenWidth,
                                ),
                              ),
                              Text(
                                '\u2022 Usage Datarefers to data collected automatically, either generated by the use of the Service or from the Service infrastructure itself (for example, the duration of a page visit).',
                                style: tsParagraft4(
                                  screenSize: screenWidth,
                                ),
                              ),
                              Text(
                                '\u2022 You means the individual accessing or using the Service, or the company, or other legal entity on behalf of which such individual is accessing or using the Service, as applicable.',
                                style: tsParagraft4(
                                  screenSize: screenWidth,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03,),
                  Container(
                    height: screenHeight * 2,
                    margin: EdgeInsets.only(top: screenHeight * 0.03),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: screenHeight * 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Collecting and Using YourPersonal Data', style: tsHeader2(
                                screenSize: screenWidth,
                              ),),
                              Text('Types of Data Collected', style: tsHeader3(
                                screenSize: screenWidth,
                              ),),
                              Text('Personal Data', style: tsSubHeader3(
                                screenSize: screenWidth,
                              ),),
                              Text('While using Our Service, We may ask You to provide Us with certain personally identifiable information that can be used to contact or identify You. Personally identifiable information may include, but is not limited to:', style: tsParagraft4(
                                screenSize: screenWidth,
                              ),),
                              Text('\u2022 Email address', style: tsParagraft4(
                                screenSize: screenWidth,
                              ),),
                              Text('\u2022 First name and last name', style: tsParagraft4(
                                screenSize: screenWidth,
                              ),),
                              Text('\u2022 Phone number', style: tsParagraft4(
                                screenSize: screenWidth,
                              ),),
                              Text('\u2022 Address, State, Province, ZIP/Postal code, City', style: tsParagraft4(
                                screenSize: screenWidth,
                              ),),
                              Text('\u2022 Usage Data', style: tsParagraft4(
                                screenSize: screenWidth,
                              ),),
                              Text('Personal Data', style: tsSubHeader3(
                                screenSize: screenWidth,
                              ),),
                              Text('Usage Data is collected automatically when using the Service.', style: tsParagraft4(
                                screenSize: screenWidth,
                              ),),
                              Text('Usage Data may include information such as Your Devices Internet Protocol address (e.g. IP address), browser type, browser version, the pages of our Service that You visit, the time and date of Your visit, the time spent on those pages, unique device identifiers and other diagnostic data.', style: tsParagraft4(
                                screenSize: screenWidth,
                              ),),
                              Text('When You access the Service by or through a mobile device, We may collect certain information automatically, including, but not limited to, the type of mobile device You use, Your mobile device unique ID, the IP address of Your mobile device, Your mobile operating system, the type of mobile Internet browser You use, unique device identifiers and other diagnostic data.', style: tsParagraft4(
                                screenSize: screenWidth,
                              ),),
                              Text('We may also collect information that Your browser sends whenever You visit our Service or when You access the Service by or through a mobile device.', style: tsParagraft4(
                                screenSize: screenWidth,
                              ),),
                              Text('Information from Third-Party Social Media Services', style: tsSubHeader3(
                                screenSize: screenWidth,
                              ),),
                              Text('The Company allows You to create an account and log in to use the Service through the following Third-party Social Media Services:', style: tsParagraft4(
                                screenSize: screenWidth,
                              ),),
                              Text('\u2022 Google', style: tsParagraft4(
                                screenSize: screenWidth,
                              ),),
                              Text('\u2022 Facebook', style: tsParagraft4(
                                screenSize: screenWidth,
                              ),),
                              Text('\u2022 Instagram', style: tsParagraft4(
                                screenSize: screenWidth,
                              ),),
                              Text('\u2022 Twitter', style: tsParagraft4(
                                screenSize: screenWidth,
                              ),),
                              Text('\u2022 LinkedIn', style: tsParagraft4(
                                screenSize: screenWidth,
                              ),),
                              Text('If You decide to register through or otherwise grant us access to a Third-Party Social Media Service, We may collect Personal data that is already associated with Your Third-Party Social Media Services account, such as Your name, Your email address, Your activities or Your contact list associated with that account.', style: tsParagraft4(
                                screenSize: screenWidth,
                              ),),
                              Text('You may also have the option of sharing additional information with the Company through Your Third-Party Social Media Services account. If You choose to provide such information and Personal Data, during registration or otherwise, You are giving the Company permission to use, share, and store it in a manner consistent with this Privacy Policy.', style: tsParagraft4(
                                screenSize: screenWidth,
                              ),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      })
    );
  }
}
