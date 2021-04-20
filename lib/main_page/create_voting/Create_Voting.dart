import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_app_final/main_page/create_voting/Candidate_List.dart';
import 'package:voting_app_final/main_page/create_voting/Voting_info.dart';
import 'package:voting_app_final/services/database.dart';

class CreateVoting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // int UniqueKey =60;// Random().nextInt(999999);

    return StreamProvider<List<Candi>>.value(
      value: DatabaseService().Candidate,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blueAccent,
          leading: FlatButton.icon(
            icon: Icon(
              Icons.home,
              size: 20,
            ),
            label: Text(''),
            onPressed: () {
              Navigator.pushNamed(context, '/mainp');
            },
          ),
          title: Center(child: Text('Candidate')),
          actions: [
            FlatButton.icon(
                onPressed: () {},
                icon: Icon(
                Icons.play_arrow,
                  color: Colors.lightGreen,
            ),
                label: Text(''),
            ),
            FlatButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.stop_circle_outlined,
                color: Colors.red,
              ),
              label: Text(''),
            ),
          ],

        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.pushNamed(context, '/candidate');
            // Navigator.push(context,
            // MaterialPageRoute(builder: (context) => EnterCandidate())
            // );
            // showModalBottomSheet<void>(
            //   context: context,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            //   ),
            //   backgroundColor: Colors.grey[300],
            //   builder: (BuildContext Context) {
            //     return EnterCandidate();
            //   },
            // );
          },
        ),
        body: Candidate_List(),
      ),
    );
  }
}
