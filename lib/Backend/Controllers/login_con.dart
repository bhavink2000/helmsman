import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:helmsman/Backend/Api%20Service/api_urls.dart';
import 'package:http/http.dart' as http;

import '../../Frontend/Src/Dashboard/dashboard_src.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;

  final box = GetStorage();

  Future<void> login(String username, String password) async {
    isLoading.value = true;
    final url = Uri.parse(ApiUrls.loginUrl);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username.toString().trim(),
          'password': password.toString().trim(),
          'expiresInMins': 30,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        box.write('accessToken', data['token']);
        Get.to(()=>DashboardSrc());
      } else {
        Get.snackbar('Failed', data['message']);
      }
    } catch (error) {
      print("Error during login: $error");
    } finally {
      isLoading.value = false;
    }
  }
}
