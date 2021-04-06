import 'package:flutter/material.dart';
import 'package:voting_app_final/services/auth.dart';

class MainPage extends StatefulWidget {
  MainPage({@required this.auth});
  final AuthBase auth;

  Future<void> _signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('E-voting'),
        // leading: Icon(
        //   Icons.android,
        // ),
        automaticallyImplyLeading: false,
        actions: [
          // ignore: deprecated_member_use
          FlatButton(
              child: Text(
                  'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                ),
              ),
            onPressed: () {
              widget._signOut();
            },
          )
        ],
        elevation: 0.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Image.asset('assets/create.jpg'),
                iconSize: 150,
                onPressed: () {},
              ),
              IconButton(
                icon: Image.asset('assets/vote.jpg'),
                iconSize: 150,
                onPressed: () {
                  Navigator.pushNamed(context, '/getid');
                },
              ),
            ],
          ),

          SizedBox(height: 30.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Image.asset('assets/result.png'),
                iconSize: 150,
                onPressed: () {
                  Navigator.pushNamed(context, '/getid');
                },
              ),
              IconButton(
                icon: Image.asset('assets/profile.png'),
                iconSize: 150,
                onPressed: () {
                  Navigator.pushNamed(context, '/profilep');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
