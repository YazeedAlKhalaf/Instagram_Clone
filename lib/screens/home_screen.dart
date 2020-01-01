import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/models/user_data.dart';
import 'package:flutter_instagram_clone/screens/activity_screen.dart';
import 'package:flutter_instagram_clone/screens/create_post_screen.dart';
import 'package:flutter_instagram_clone/screens/feed_screen.dart';
import 'package:flutter_instagram_clone/screens/profile_screen.dart';
import 'package:flutter_instagram_clone/screens/search_screen.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthService _authService = AuthService();

  int _currentTab = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String currentUserId = Provider.of<UserData>(context).currentUserId;
    _chooseScreen(int index) {
      Widget chosenScreen;
      if (index == 0) {
        setState(() {
          chosenScreen = FeedScreen(
            currentUserId: currentUserId,
          );
        });
      } else if (index == 1) {
        setState(() {
          chosenScreen = SearchScreen();
        });
      } else if (index == 2) {
        setState(() {
          chosenScreen = ActivityScreen(
            currentUserId: currentUserId,
          );
        });
      } else if (index == 3) {
        setState(() {
          chosenScreen = ProfileScreen(
            userId: currentUserId,
            currentUserId: currentUserId,
          );
        });
      }

      return chosenScreen;
    }

    return Scaffold(
      body: _chooseScreen(_currentTab),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CreatePostScreen(),
            ),
          );
        },
        backgroundColor: Colors.white,
        tooltip: 'Create Post',
        child: Icon(Icons.add_a_photo),
        elevation: 2.0,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              iconSize: 30.0,
              color: _currentTab == 0 ? Colors.black : Colors.grey,
              icon: Icon(Icons.home),
              onPressed: () {
                setState(() {
                  _currentTab = 0;
                });
              },
            ),
            IconButton(
              iconSize: 30.0,
              color: _currentTab == 1 ? Colors.black : Colors.grey,
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  _currentTab = 1;
                });
              },
            ),
            IconButton(
              iconSize: 30.0,
              color: _currentTab == 2 ? Colors.black : Colors.grey,
              icon: Icon(Icons.notifications),
              onPressed: () {
                setState(() {
                  _currentTab = 2;
                });
              },
            ),
            IconButton(
              iconSize: 30.0,
              color: _currentTab == 3 ? Colors.black : Colors.grey,
              icon: Icon(Icons.account_circle),
              onPressed: () {
                setState(() {
                  _currentTab = 3;
                });
              },
            ),
          ],
        ),
        shape: CircularNotchedRectangle(),
        color: Colors.white,
      ),
    );
  }
}
