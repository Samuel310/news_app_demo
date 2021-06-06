import 'package:flutter/material.dart';
import 'package:news_app_demo/screens/auth/widgets/text_input_widget.dart';
import 'package:news_app_demo/services/auth_api.dart';

class SignUpWidget extends StatefulWidget {
  final Function changeView;
  SignUpWidget({required this.changeView});
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  bool showProgress = false;
  AuthApiRepo authApiRepo = AuthApiRepo();
  @override
  Widget build(BuildContext context) {
    double initialChildSize = 0.6;
    double height = MediaQuery.of(context).size.height * initialChildSize;
    return DraggableScrollableSheet(
      initialChildSize: initialChildSize,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
          ),
          child: SingleChildScrollView(
            child: Container(
              height: height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Sign Up", style: TextStyle(color: Colors.blue[900], fontSize: 25, fontWeight: FontWeight.bold)),
                  TextInputField(controller: emailController, hintText: "Email:"),
                  TextInputField(controller: usernameController, hintText: "Username:"),
                  TextInputField(controller: passwordController, hintText: "Password:", isPasswordField: true),
                  TextInputField(controller: rePasswordController, hintText: "Re-enter Password:", isPasswordField: true),
                  SizedBox(
                    width: 120,
                    height: 45,
                    child: TextButton(
                      onPressed: onSignupBtnClicked,
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue[300],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      ),
                      child: showProgress
                          ? SizedBox(width: 15, height: 15, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : Text("Sign Up", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      height: 30,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              children: [Expanded(child: Container(height: 1, color: Colors.grey[200]))],
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 120,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              color: Colors.white,
                              child: Center(
                                child: Text("Or Sign Up With", style: TextStyle(fontSize: 12, color: Colors.black)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: AssetImage("assets/images/google.png"), width: 35),
                      SizedBox(width: 20),
                      Image(image: AssetImage("assets/images/facebook.png"), width: 35),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Have an account? ", style: TextStyle(color: Colors.grey)),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            this.widget.changeView();
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Text("Sign in", style: TextStyle(color: Colors.amber)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void onSignupBtnClicked() async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (!showProgress) {
      if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty && rePasswordController.text.isNotEmpty && usernameController.text.isNotEmpty) {
        if (passwordController.text == rePasswordController.text) {
          setState(() {
            showProgress = true;
          });
          try {
            String res = await authApiRepo.signUp(email: emailController.text, username: usernameController.text, password: passwordController.text, cnfPassword: rePasswordController.text);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
          } catch (e) {
            print(e);
          }
          setState(() {
            showProgress = false;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password does not match')));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Fill all details')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please wait..')));
    }
  }
}
