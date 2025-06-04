import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavScreen extends StatefulWidget {
  final Widget child;
  const BottomNavScreen({super.key, required this.child});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;
  static const List<String> _routes = ['/community', '/map', '/mypage'];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final location = GoRouterState.of(context).uri.toString();
    setState(() {
      switch (true) {
        case bool _ when location.startsWith('/community'):
          _selectedIndex = 0; // 탐색
          break;
        case bool _ when location.startsWith('/map'):
          _selectedIndex = 1; // 마이큐레이션
          break;
        case bool _ when location.startsWith('/mypage'):
          _selectedIndex = 2; // 마이
          break;
        default:
          _selectedIndex = 0; // 기본값: /community
      }
    });
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() => _selectedIndex = index);
      context.go(_routes[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              Expanded(child: widget.child),
              BottomNavigationBar(
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), label: '탐색'),
                  BottomNavigationBarItem(icon: Icon(Icons.view_agenda_outlined), label: '마이큐레이션'),
                  BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: '마이'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}