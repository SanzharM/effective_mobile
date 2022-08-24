import 'package:effective_mobile/core/constants/constants.dart';
import 'package:effective_mobile/ui/screens/main_screen/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavBarItem {
  final Widget child;
  final Widget? icon;
  final String? title;

  const NavBarItem({required this.child, this.icon, this.title});
}

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<NavBarItem> pages = [];

  int _currentIndex = 0;

  void _changeTab(int index) {
    if (index < 0 || index > pages.length) return;
    setState(() => _currentIndex = index);
  }

  @override
  void initState() {
    pages = const [
      NavBarItem(child: MainScreen(), title: '• Explorer'),
      NavBarItem(child: Scaffold(body: Center(child: Icon(CupertinoIcons.bag))), icon: Icon(CupertinoIcons.bag)),
      NavBarItem(child: Scaffold(body: Center(child: Icon(CupertinoIcons.heart))), icon: Icon(CupertinoIcons.heart)),
      NavBarItem(child: Scaffold(body: Center(child: Icon(CupertinoIcons.person))), icon: Icon(CupertinoIcons.person)),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages.map((e) => e.child).toList(),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.darkGrey,
          borderRadius: AppConstraints.borderRadius50,
        ),
        padding: const EdgeInsets.all(AppConstraints.padding / 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: pages
              .map((e) => Flexible(
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => _changeTab(pages.indexOf(e)),
                      child: e.icon ??
                          Text(
                            e.title ?? '',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge?.apply(color: AppColors.white),
                          ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
