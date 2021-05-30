import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:linkable/linkable.dart';
import 'package:the_librarian/screens/floors/floor.dart';
import 'package:the_librarian/screens/user_info_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  final User user;

  Home(this.user);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late User _user;
  @override
  void initState(){
    super.initState();
    _user = widget.user;
  }


  List<int> floors = [-1, 0, 3, 4, 5];
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text('Hello ${_user.displayName}'),
              // decoration: BoxDecoration(
              //   color: Colors.blue,
              // ),
            ),
            ListTile(
                title: Text('Aran Library website'),
                onTap: () => launch('https://in.bgu.ac.il/aranne/Pages/default.aspx'),
                ),
            ListTile(
                title: Text('Log Out'),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => UserInfoScreen(
                        user: _user,
                      ),
                    ),
                  );
                }
            ),

          ],
        ),
      ),
      body: Stack(
        // alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/lib1.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Column(
            children: [
              IconButton(icon: Icon(Icons.menu),
                color: Colors.black,
                iconSize: 60.0,
                alignment: Alignment.topRight,
                onPressed: () => _globalKey.currentState!.openDrawer(),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: 40.0,),
              Container(
                child: Text(
                  'BGU Library',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    color: Colors.deepOrangeAccent[200],
                    // height: 0.1,
                  ),
                ),
                margin: EdgeInsets.symmetric(vertical: 20.0),
              ),
              SizedBox(height: 5.0),
              Expanded(
                // wrap in Expanded
                child: ListView(
                  children: [
                    for (var i in floors)
                      Column(
                        children: [
                          // ignore: deprecated_member_use
                          FlatButton.icon(
                            onPressed: () => Navigator.pushNamed(
                                context, '/floor' + i.toString()),
                            icon: Icon(Icons.arrow_forward_ios),
                            label: Text(
                              'Floor ' + i.toString(),
                              style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                              ),
                            ),
                            color: Colors.grey[200],
                            padding: EdgeInsets.symmetric(
                                horizontal: 60.0, vertical: 20.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                          ),
                          SizedBox(height: 15.0),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}