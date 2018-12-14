import 'package:flutter/material.dart';
import '../model/user.dart';
import '../database/database_user.dart';

///Funtion to get the db user information.
Future<User> fetchEmployeesFromDatabase() async {
  var dbHelper = DatabaseHelper();
  Future<User> employees = dbHelper.fetchItem();
  return employees;
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> lidList = [];
  var db = DatabaseHelper();

  void getData() async {
    var info = await fetchEmployeesFromDatabase();
    lidList = info.lids;
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent.shade100,
        title: Row(
          children: <Widget>[
            Expanded(
                child: new Divider(
              color: Colors.transparent,
            )),
            Text(
              "WELCOME BACK!",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      
      drawer: new Drawer(
        child: new Container(
          color: Colors.lightBlueAccent.shade100,
          child: new FutureBuilder<User>(
            future: fetchEmployeesFromDatabase(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Center(
                              child: new DrawerHeader(
                                child: new CircleAvatar(
                                  child:
                                      new Image.asset("assets/Programer.jpg"),
                                  radius: 70.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 2.0),
                              child: new Text(snapshot.data.name,
                                  style: new TextStyle(
                                      fontSize: 24.0, color: Colors.white)),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 2.0),
                              child: new Text(snapshot.data.profile,
                                  style: new TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: new Container(
                                alignment: Alignment(1.0, 0.0),
                                child: IconButton(
                                  iconSize: 70.0,
                                  icon: new Icon(
                                    Icons.exit_to_app,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      db.deleteUsers();
                                      Navigator.of(context)
                                          .pushReplacementNamed('/');
                                    });
                                  },
                                  color: const Color(0xFF454545),
                                ),
                              ),
                            )
                          ]);
                    });
              } else if (snapshot.hasError) {
                return new Text("${snapshot.error}");
              }
              return new Container(
                alignment: AlignmentDirectional.center,
                child: new CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
      
      body: Column(
        children: <Widget>[
          new Container(
            height: 230.0,
            child: ListView.builder(
              itemCount: lidList.length,
              itemBuilder: (context, index) {
                return ListTile(
                    leading: Icon(
                      Icons.feedback,
                      size: 40.0,
                      color: Colors.green,
                    ),
                    title: new Row(
                      children: <Widget>[
                        Text(
                          '${lidList[index]}',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 30.0,
                          ),
                        ),
                        Expanded(
                            child: new Divider(
                          color: Colors.transparent,
                        )),
                        IconButton(
                          icon: Icon(
                            Icons.cancel,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              lidList.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
