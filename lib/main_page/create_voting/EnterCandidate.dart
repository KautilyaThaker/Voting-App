import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_app_final/services/auth.dart';
import 'package:voting_app_final/services/database.dart';
import 'dart:math';
import 'package:wc_form_validators/wc_form_validators.dart';


class EnterCandidate extends  StatelessWidget {


  EnterCandidate({this.Candidatename,this.Slogan});
  String Candidatename;
  String Slogan;

  DatabaseService databaseService;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    var creatorName=user.name;


    //Add candidate to Creating Voting
    return  Scaffold(
      body: SafeArea(
        child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      autofocus:true,
                      decoration: InputDecoration(
                        labelText: 'Candidate Name',
                      ),
                      onChanged: (value){
                        Candidatename=value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'CandidateName is Required';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Enter Slogan',
                      ),
                      onChanged: (value){
                        Slogan=value;
                      },
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        // ignore: deprecated_member_use
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              DatabaseService().AddCandidate(Candidatename: Candidatename,Slogan: Slogan,creatorName: creatorName);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Processing Data')
                                ),
                              );
                              Navigator.pushReplacementNamed(context, '/cv');
                            }
                          },
                          child: Text('Add Candidate'),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
      ),
    );
  }
}

