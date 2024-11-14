// lib/screens/layout.dart
import 'package:flutter/material.dart';
import '../Home/home_screen.dart';
import '../Search/search_screen.dart';
import '../Profile/profile_screen.dart';
import '../../styles/colors.dart';

class Layout extends StatefulWidget {
  final Widget body;
  final int currentIndex;
  final ValueChanged<int>? onTabSelected;
  final bool showBottomNav;

  const Layout({
    super.key,  // Super parámetro
    required this.body,
    this.currentIndex = 0,
    this.onTabSelected,
    this.showBottomNav = true,
  });

  @override
  LayoutState createState() => LayoutState();  // Clase de estado pública
}

class LayoutState extends State<Layout> {  // Clase pública
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Definir las rutas a las pantallas
    Widget nextScreen;
    switch (index) {
      case 0:
        nextScreen = const HomeScreen();
        break;
      case 1:
        nextScreen = const SearchScreen();
        break;
      case 2:
        nextScreen = const ProfileScreen();
        break;
      default:
        nextScreen = const HomeScreen();
        break;
    }

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => Layout(body: nextScreen, currentIndex: index)),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.body,
      bottomNavigationBar: widget.showBottomNav
          ? BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, size: 35),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search, size: 35),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person, size: 35),
                  label: '',
                ),
              ],
              currentIndex: _currentIndex,
              selectedItemColor: AppColors.iconSelected,
              unselectedItemColor: AppColors.iconUnselected,
              backgroundColor: AppColors.primary,
              onTap: _onTabTapped,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
            )
          : null,
    );
  }
}
