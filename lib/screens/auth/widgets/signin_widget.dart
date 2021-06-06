import 'package:flutter/material.dart';
import 'package:news_app_demo/functions/session.dart';
import 'package:news_app_demo/screens/auth/widgets/text_input_widget.dart';
import 'package:news_app_demo/screens/home/home_screen_wraper.dart';
import 'package:news_app_demo/services/auth_api.dart';

class SignInWidget extends StatefulWidget {
  final Function changeView;
  SignInWidget({required this.changeView});
  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showProgress = false;
  AuthApiRepo authApiRepo = AuthApiRepo();

  @override
  Widget build(BuildContext context) {
    double initialChildSize = 0.55;
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
                  Text("Sign In", style: TextStyle(color: Colors.blue[900], fontSize: 25, fontWeight: FontWeight.bold)),
                  TextInputField(controller: emailController, hintText: "Email:"),
                  TextInputField(controller: passwordController, hintText: "Password:", isPasswordField: true),
                  Padding(
                    padding: EdgeInsets.only(right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    height: 45,
                    child: TextButton(
                      onPressed: onSignInBtnClicked,
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue[300],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: showProgress
                          ? SizedBox(width: 15, height: 15, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : Text("Sign In", style: TextStyle(color: Colors.white)),
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
                                child: Text("Or Sign In With", style: TextStyle(fontSize: 12, color: Colors.black)),
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
                      Text("Don't have an account? ", style: TextStyle(color: Colors.grey)),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            this.widget.changeView();
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Text("Sign up", style: TextStyle(color: Colors.amber)),
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

  void onSignInBtnClicked() async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (!showProgress) {
      if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
        setState(() {
          showProgress = true;
        });
        try {
          String res = await authApiRepo.signIn(email: emailController.text, password: passwordController.text);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
          if (res == "Success!") {
            await Session.setTimeOut();
            Navigator.pushNamedAndRemoveUntil(context, HomeScreenWrapper.routeName, (route) => false);
          }
        } catch (e) {
          print(e);
        }
        setState(() {
          showProgress = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Fill all details')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please wait..')));
    }
  }
}
