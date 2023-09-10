// import 'dart:convert';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nbb_app/model/team.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  List<Team> teams=[];
  Future getTeams() async{
    var response = await http.get(Uri.https('balldontlie.io','api/v1/teams'));
    // print(response.body);
    var jsonData = jsonDecode(response.body);

    for (var eachTeam in jsonData['data']){
      final team= Team(
        abbreviation: eachTeam['abbreviation'],
        city: eachTeam['city']);
      teams.add(team);
    }
    // print(teams.length);
      
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    getTeams();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 36, 59, 186),
        centerTitle: true,
        title: Text('NBA TEAMS'),
      ),
      body:FutureBuilder(
        future:getTeams(),
        builder: (context,snapshot){
          //If done loading, show the data of teams
          if (snapshot.connectionState == ConnectionState.done ){
            return ListView.builder(
              itemCount: teams.length,
              itemBuilder: (context, index){

              return Padding(padding: EdgeInsets.all(12),
              child:Container(
                decoration: BoxDecoration(
                  color:Colors.grey[200],
                  borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  title: Text(teams[index].abbreviation,), 
                  subtitle: Text(teams[index].city)),
              ));
            });
          }
          else{
            return Center(child: CircularProgressIndicator());
          }
        })
    );
  }
}