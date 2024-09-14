import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helmsman/Frontend/Utils/app_helper.dart';
import '../../../Backend/Controllers/login_con.dart';

class LoginSrc extends StatefulWidget {
  const LoginSrc({super.key});

  @override
  State<LoginSrc> createState() => _LoginSrcState();
}

class _LoginSrcState extends State<LoginSrc> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final LoginController _loginController = Get.put(LoginController());
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: ColorHelper.primaryColor,
        body: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Sign in to Helmsman and continue',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 28),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Enter your username and password below to continue to the The Growing Developer and let the learning begin!',
                    textAlign: TextAlign.center,
                    style:
                    TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(height: 50),
                  _buildTextField(usernameController, Icons.account_circle, 'Username', false,(value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null; // Validation successful
                  }),
                  SizedBox(height: 20),
                  _buildTextField(passwordController, Icons.lock, 'Password', true,(value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null; // Validation successful
                  }),
                  SizedBox(height: 20),
                  Obx((){
                    if (_loginController.isLoading.value) {
                      return CircularProgressIndicator(color: Colors.white,);
                    } else {
                      return MaterialButton(
                        elevation: 0,
                        minWidth: double.maxFinite,
                        height: 50,
                        color: Colors.teal,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            String username = usernameController.text;
                            String password = passwordController.text;
                            _loginController.login(username, password);
                          }
                        },
                        child: Text('Login',
                            style: TextStyle(color: Colors.white, fontSize: 16)),
                        textColor: Colors.white,
                      );
                    }
                  }),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        )
    );
  }

  _buildTextField(
      TextEditingController controller,
      IconData icon,
      String labelText,
      bool obSecure,
      String? Function(String?)? validator) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: ColorHelper.secondaryColor,
        border: Border.all(color: Colors.blue),
      ),
      child: TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: obSecure,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white),
          icon: Icon(icon, color: Colors.white),
          border: InputBorder.none,
          errorStyle: TextStyle(color: Colors.white)
        ),
        validator: validator, // Adding validation function
      ),
    );
  }


}
