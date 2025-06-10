import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('รายการสินค้า'), centerTitle: true),
      // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text(
      //         'หมวดหมู่สินค้า',
      //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //       ),
      //       SizedBox(height: 12),
      //       Text(
      //         '• อิเล็กทรอนิกส์\n• เสื้อผ้า\n• ของใช้ภายในบ้าน\n• อาหารและเครื่องดื่ม',
      //         style: TextStyle(fontSize: 16),
      //       ),
      //       SizedBox(height: 24),
      //       Text(
      //         'รายการแนะนำ',
      //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //       ),
      //       // ตัวอย่างสินค้าแนะนำ
      //       SizedBox(height: 12),
      //       ListTile(
      //         leading: Icon(Icons.phone_android),
      //         title: Text('สมาร์ทโฟนรุ่นใหม่'),
      //         subtitle: Text('ลดราคา 20%'),
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.tv),
      //         title: Text('สมาร์ททีวี 55 นิ้ว'),
      //         subtitle: Text('ความละเอียด 4K UHD'),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
