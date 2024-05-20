import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  const CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTabTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTabTapped,
      // backgroundColor: Color.fromARGB(255, 137, 151, 86),
      selectedItemColor: Colors.green.shade600,
      unselectedItemColor: const Color.fromARGB(255, 179, 179, 179),
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.apps),
          icon: Icon(Icons.apps),
          label: 'All',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.search),
          icon: Icon(Icons.search_outlined),
          label: 'Search',
        ),
        // BottomNavigationBarItem(
        //   activeIcon: Icon(Icons.all_lo),
        //   icon: Icon(Icons.all_inbox),
        //   label: 'All',
        // ),
        
        // BottomNavigationBarItem(
        //   activeIcon: Icon(Icons.people_alt),
        //   icon: Icon(Icons.people_alt_outlined),
        //   label: 'Anggota',
        // ),
      ],
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    );
  }
}
