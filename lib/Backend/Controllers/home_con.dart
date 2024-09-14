import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:helmsman/Backend/Api%20Service/api_urls.dart';
import 'package:helmsman/Backend/Models/user_details_model.dart';
import 'package:helmsman/Backend/Models/user_model.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var isLoading = true.obs;
  var userModel = UserModel().obs;
  var userDModel = UserDetailsModel().obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  void fetchUsers() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('${ApiUrls.userUrl}'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        userModel.value = UserModel.fromJson(data);
      } else {
        Get.snackbar('Failed', 'Failed to load users');
        print('Failed to load users');
      }
    } catch (error) {
      print('Error fetching users: $error');
    } finally {
      isLoading(false);
    }
  }

  void fetchUsersDetails(var uId) async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('${ApiUrls.userUrl}/$uId'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        log('da-->${data}');
        userDModel.value = UserDetailsModel.fromJson(data);
      } else {
        Get.snackbar('Failed', 'Failed to load users');
        print('Failed to load users');
      }
    } catch (error) {
      print('Error fetching users: $error');
    } finally {
      isLoading(false);
    }
  }

  void searchUsers(String query) async {
    searchQuery.value = query;
    isLoading(true);

    try {
      final response = await http.get(Uri.parse('${ApiUrls.searchUrl}?q=$query'));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (response.statusCode == 200) {
          userModel.value = UserModel.fromJson(data);
        } else {
          Get.snackbar('No Found', 'User not found');
          print('Failed to load users');
        }
      } else {
        Get.snackbar('Failed', 'Failed to load users');
        print('Failed to load users');
      }
    } catch (error) {
      Get.snackbar('Error', 'Error fetching users: $error');
      print('Error fetching users: $error');
    } finally {
      isLoading(false);
    }
  }

}
