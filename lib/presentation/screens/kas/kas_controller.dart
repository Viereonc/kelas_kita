import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/data/models/kas_kelas_model.dart';
import 'package:kelas_kita/data/models/riwayat_pembayaran_model.dart';
import 'package:kelas_kita/presentation/screens/kas/kas_view.dart';
import 'package:kelas_kita/presentation/screens/kas/metode_pembayaran.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constants.dart';
import '../../../data/models/biografi_model.dart';
import '../../../data/models/tagihan_kas.dart';
import 'package:uni_links2/uni_links.dart';

class KasController extends GetxController {
  RxList<InfoTagihanKasModel> tagihanKasList = <InfoTagihanKasModel>[].obs;
  RxList<InfoBiografiModel> biografiList = <InfoBiografiModel>[].obs;
  RxList<InfoHistoryBayarModel> historyBayarList = <InfoHistoryBayarModel>[].obs;
  late final MidtransSDK? midtrans;
  var isLoading = true.obs;
  var userStatus = ''.obs;
  RxDouble totalKas = 0.0.obs;
  RxString qrData = ''.obs;
  Timer? _timer;
  RxnInt biodataId = RxnInt();

  @override
  void onInit() {
    super.onInit();
    loadLoading();
    fetchBiografi();
    // fetchTagihanKas();
    fetchInfoHistoryBayar();
    _loadBiodataId();
    // _initSdk();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void updateTotalKas(double newTotal) {
    totalKas.value = newTotal;
  }

  Future<void> _loadBiodataId() async {
    biodataId.value = (await fetchBiodataId());
  }

  // Future<void> postPayment(int userName, double amount) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? token = prefs.getString('token');
  //   try {
  //     final response = await http.post(
  //       Uri.parse(baseUrl + payment),
  //       body: {
  //         'id_kelas': userName,
  //         'amount': amount.toString(),
  //       },
  //       headers: <String, String>{'Authorization': 'Bearer $token'},
  //     );
  //
  //     if (response.statusCode == 200) {
  //       print('Payment posted successfully');
  //     } else {
  //       print('Failed to post payment');
  //     }
  //   } catch (e) {
  //     print('Error posting payment: $e');
  //   }
  // }

  // void _initSdk() async {
  //   try {
  //     midtrans = await MidtransSDK.init(
  //       config: MidtransConfig(
  //         clientKey: dotenv.env['MIDTRANS_CLIENT_KEY'] ?? "",
  //         merchantBaseUrl: dotenv.env['BASE_URL_MIDTRANS'] ?? "",
  //         colorTheme: ColorTheme(
  //           colorPrimary: Colors.blue,
  //           colorPrimaryDark: Colors.blue,
  //           colorSecondary: Colors.blue,
  //         ),
  //       ),
  //     );
  //     midtrans?.setUIKitCustomSetting(skipCustomerDetailsPages: true);
  //     midtrans!.setTransactionFinishedCallback((result) {
  //       Get.snackbar('Success', 'Transaction completed');
  //     });
  //   } catch (e) {
  //     print('Midtrans SDK initialization error: $e');
  //     Get.snackbar('Error', 'Failed to initialize Midtrans SDK');
  //   }
  // }

  // void handleSuccessfulTransaction(int nominal, DateTime date) {
  //   // Create a new instance of TagihanKasModel with the transaction details
  //   final newTagihan = InfoTagihanKasModel(
  //     jumlah: [
  //       TagihanKasItem(
  //         nominal: nominal,
  //         tanggal: date,
  //       )
  //     ],
  //   );
  //
  //   // Add the new transaction to the list
  //   tagihanKasList.add(newTagihan);
  // }
  //
  // // Update your Midtrans callback
  // void initMidtrans() {
  //   midtrans?.setTransactionFinishedCallback((result) {
  //     if (result.transactionStatus == TransactionStatus.settlement) {
  //       // When the transaction is successful, call the method to save it
  //       handleSuccessfulTransaction(result.grossAmount, DateTime.now());
  //       Get.snackbar('Success', 'Transaction completed');
  //     }
  //   });
  // }

  Future<void> createTransaction(int userId, int amount, int idKelas) async {
    print('Creating transaction with ID Biodata: $userId, ID Kelas: $idKelas, Amount: $amount');

    try {
      final response = await http.post(
        Uri.parse(baseUrl + payment),
        body: {
          'id_kelas': idKelas.toString(),
          'amount': amount.toString(),
          'id_biodata': userId.toString(),
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final snapToken = jsonResponse['snapToken'];
        print('API Response: $jsonResponse');

        final midtransUrl = 'https://app.sandbox.midtrans.com/snap/v2/vtweb/$snapToken';
        print('Url Midtrans : $midtransUrl');

        if (await canLaunchUrl(Uri.parse(midtransUrl))) {
          await launchUrl(
            Uri.parse(midtransUrl),
            mode: LaunchMode.externalApplication,
          );
          midtrans?.setUIKitCustomSetting(skipCustomerDetailsPages: true);
          midtrans!.setTransactionFinishedCallback((result) {
            Get.snackbar('Success', 'Transaction completed');
          });
        } else {
          throw 'Could not launch $midtransUrl';
        }
      } else {
        final jsonResponse = jsonDecode(response.body);
        print('API Response: $jsonResponse');
        Get.snackbar('Error', 'Failed to create transaction');
      }
    } catch (e) {
      print('Error occurred: $e');
      // Get.snackbar('Error', 'An error occurred');
    }
  }


  Future<void> createTransactionTunai(int userId, int amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? idKelass = prefs.getInt('id_kelas');
    print('ID Kelas : $idKelass');
    print('ID Biodata : $userId');
    print('Amount : $amount');

    try {
      final response = await http.post(
        Uri.parse('https://kelaskita.site/api/kas/$idKelass'),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'nominal': amount.toString(),
          'id_biodata': userId.toString(),
        },
      );

      // If the response is successful (status code 200)
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print('API Response: $jsonResponse');
        Get.snackbar('Success', 'Payment Successful');
        Get.back();
      }
      else {
        print('Error Response: ${response.statusCode}');
        print('Raw Response Body: ${response.body}');
        Get.snackbar('Error', 'Failed to create transaction');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  void loadLoading() async {
    await Future.delayed(Duration(seconds: 3));
    isLoading.value = false;
  }

  void openIconButtonPressed(BuildContext context) {
    showModalBottomSheet(context: context, builder: (ctx) => MetodePembayaran());
  }

  Future<void> fetchBiografi() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      int? userId = prefs.getInt('id_user');

      if (userId != null) {
        final response = await http.get(
          Uri.parse('$baseUrl$biodataEndpointGet$userId'),
          headers: <String, String>{'Authorization': 'Bearer $token'},
        );

        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);
          print('JSON Response: $jsonResponse');

          var fetchedData = InfoBiografiModel.fromJson(jsonResponse);
          biografiList.value = [fetchedData];

          userStatus.value = fetchedData.role.nama.toString();
          print('Successfully loaded biografi data: ${biografiList.length}');
        } else {
          print('Failed to load biografi, status code: ${response.statusCode}');
          throw Exception('Failed to load biografi');
        }
      } else {
        print('User ID is null. Unable to fetch biografi.');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }

  Future<void> fetchTagihanKas() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      int? userId = prefs.getInt('id_user');

      String? biodataIdString = prefs.getString('id_biodata');
      int? biodataId = biodataIdString != null ? int.tryParse(biodataIdString) : null;

      print('biodataId: $biodataId');
      if (userId != null) {
        final url = Uri.parse('$baseUrl$tagihanKasUserEndPoint$biodataId');
        print('Requesting URL: $url');

        final response = await http.get(
          url,
          headers: <String, String>{'Authorization': 'Bearer $token'},
        );

        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body) as List<dynamic>;
          print('JSON Response: $jsonResponse');

          var fetchedData = jsonResponse.map((data) => InfoTagihanKasModel.fromJson(data)).toList();
          tagihanKasList.value = fetchedData;
          print('Successfully loaded tagihan kas data: ${tagihanKasList.length}');
        } else {
          print('Failed to load tagihan kas, status code: ${response.statusCode}');
          throw Exception('Failed to load tagihan kas');
        }
      } else {
        print('biodataId is null or User ID is null. Unable to fetch tagihan kas.');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error E: $e');
    }
  }

  void fetchInfoHistoryBayar() async {
    try {
      isLoading.value = true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      int? idBiodata = prefs.getInt('id_biodata');

      final response = await http.get(
        Uri.parse('$baseUrl$getHistoryBayar$idBiodata'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        historyBayarList.value = infoHistoryBayarModelFromJson(response.body);
        print('Success to fetch History Pembayaran: ${response.statusCode}');
        isLoading.value = false;
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<String?> getName() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? name = prefs.getString('nama');
      return name;
    } catch (e) {
      print('Error fetching nama: $e');
      return null;
    }
  }

  Future<int?> fetchBiodataId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? biodataId = prefs.getInt('id_biodata');
      return biodataId;
    } catch (e) {
      print('Error fetching id_biodata: $e');
      return null;
    }
  }

  Future<int?> getIdKelas() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? idKelas = prefs.getInt('id_kelas');
      return idKelas;
    } catch (e) {
      print('Error fetching id_kelas: $e');
      return null;
    }
  }
}
