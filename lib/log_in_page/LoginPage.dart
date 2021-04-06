import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voting_app_final/services/auth.dart';

class LoginPage extends StatelessWidget {
  LoginPage({@required this.auth});
  final AuthBase auth;

  Future<void> _signInWithGoogle() async {
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.cyan[300],
            Colors.cyan[500],
            Colors.cyan[600],
          ]),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 80,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 40),),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Text("Welcome to E-Voting", style: TextStyle(color: Colors.white, fontSize: 18),),
                  )
                ],
              ),
            ),
            Expanded(child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  )
              ),
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 40,),
                    SizedBox(height: 10.0),
                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 50),

                      child: Center(
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          onPressed: () {
                            _signInWithGoogle();
                            //     Navigator.pushNamed(context, '/takeprofile');
                            //   }else{
                            //   Navigator.pushNamed(context, '/home');
                            // }
                          },
                          padding: EdgeInsets.only(left: 40.0, right: 40.0),
                          color: Colors.cyan,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                          ),
                          child: Text("Login",style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                          ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}