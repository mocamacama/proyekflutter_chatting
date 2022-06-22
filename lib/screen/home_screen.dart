import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyek_chatting/pages/chat_page.dart';
import 'package:proyek_chatting/pages/contact_page.dart';
import 'package:proyek_chatting/pages/profile_page.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final ValueNotifier<int> index = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier("Message");

  final pages = const [ChatPage(), ContactPage(), ProfilePage()];

  final pageTitles = const [
    'Message',
    'Contact',
    'Profile',
  ];

  void _onNavigationItemSelector(indexes) {
    title.value = pageTitles[indexes];
    index.value = indexes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: ValueListenableBuilder(
          valueListenable: title,
          builder: (BuildContext context, String value, _) {
            return Center(
              child: Text(
                value,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            );
          },
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: index,
        builder: (BuildContext context, int value, _) {
          return pages[value];
        },
      ),
      bottomNavigationBar: _BottomNavigationBar(
        onItemSelected: _onNavigationItemSelector,
      ),
    );
  }
}

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({Key? key, required this.onItemSelected}) : super(key: key);

  final ValueChanged<int> onItemSelected;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  var selectedindex = 0;
  void handleItemSelected(int index) {
    setState(() {
      selectedindex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // _NavigationBarItem(
          //     index: 0,
          //     label: 'Chat',
          //     icon: CupertinoIcons.bubble_left_bubble_right_fill,
          //     isSelected: (selectedindex == 0),
          //     onTap: handleItemSelected),
          _NavigationBarItem(
              index: 1,
              label: 'Contact',
              icon: CupertinoIcons.person_2_fill,
              isSelected: (selectedindex == 1),
              onTap: handleItemSelected),
          _NavigationBarItem(
              index: 2,
              label: 'Profile',
              icon: CupertinoIcons.profile_circled,
              isSelected: (selectedindex == 2),
              onTap: handleItemSelected),
        ],
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem({
    Key? key,
    required this.index,
    required this.label,
    required this.icon,
    required this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  final ValueChanged<int> onTap;
  final int index;
  final String label;
  final IconData icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HitTestBehavior.opaque;
        onTap(index);
      },
      child: SizedBox(
        height: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: isSelected ? Colors.blue : null),
            SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 11),
            )
          ],
        ),
      ),
    );
  }
}
