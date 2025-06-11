import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final Function(int) onMenuTap;

  const HomePage({super.key, required this.onMenuTap});

  final List<Map<String, dynamic>> menus = const [
    {'title': 'ข้อมูลผู้ใช้', 'icon': Icons.person, 'index': 3},
    {'title': 'รายการสินค้า', 'icon': Icons.shopping_bag, 'index': 1},
    {'title': 'รายงาน', 'icon': Icons.bar_chart, 'index': 2},
    {'title': 'ตั้งค่า', 'icon': Icons.settings, 'index': 4},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        itemCount: menus.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final menu = menus[index];
          return GestureDetector(
            onTap: () {
              onMenuTap(menu['index']);
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(menu['icon'], size: 48, color: Colors.blue),
                  const SizedBox(height: 12),
                  Text(menu['title'], style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
