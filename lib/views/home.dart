import 'package:flutter/material.dart';
import 'package:flutter_practice/models/post.dart';
import 'package:flutter_practice/services/remote_service.dart';
import 'package:flutter_practice/views//bottom_navs/home_screen.dart';
import 'package:flutter_practice/views/bottom_navs/profile_screen.dart';
import 'package:flutter_practice/views/bottom_navs/search_screen.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  int _currentIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const SearchScreen(),
    const ProfileScreen()
  ];

  final tabs = [
    // const Center(child: Text('Home')),
    Scaffold(

    ),
    const Center(child: Text('Search')),
    const Center(child: Text('Profile'))
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),

      body: _widgetOptions.elementAt(_currentIndex),

      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          )
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        }
      ),
    );
  }
}
