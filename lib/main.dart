import 'package:flutter/material.dart';
import 'package:w3_31mon/api_service.dart';
import 'package:w3_31mon/product_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Product'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      // FutureBuilder ใช้สำหรับดึงข้อมูลแบบ asynchronous จาก API
      // การจัดการ 3 สถานะ: loading, error, และ success
      body: FutureBuilder<List<Product>>(
        future: ApiService.fetchProduct(), // เรียก API เพื่อดึงข้อมูลสินค้า
        builder: (context, snapshot) {

          // ถ้ากำลังโหลดข้อมูล แสดงตัว loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // ถ้าเกิด error แสดงข้อความ error
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          // ดึงข้อมูลสินค้าที่ได้จาก API
          final products = snapshot.data!;

          // ListView.builder ใช้สร้างรายการ
          // สร้างเฉพาะ item ที่แสดงบนหน้าจอ
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: products.length, // จำนวนสินค้าทั้งหมด
            itemBuilder: (context, index) {
              final p = products[index]; // ดึงสินค้าแต่ละตัวตาม index

              // Card ใช้สร้างกล่องที่มีเงา มีมุมโค้ง
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  // Row จัดเรียง widget แนวนอน (รูปภาพ + รายละเอียด)
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ClipRRect ใช้ทำให้รูปมีมุมโค้ง
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          p.photo, // URL รูปภาพจาก API
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover, // ครอบรูปให้เต็มพื้นที่
                        ),
                      ),

                      const SizedBox(width: 12), // ช่องว่างระหว่างรูปกับข้อความ

                      // Expanded ทำให้ Column ขยายเต็มพื้นที่ที่เหลือ
                      Expanded(
                        // Column จัดเรียง widget แนวตั้ง
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // แสดงชื่อสินค้า
                            Text(
                              p.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 6),

                            // แสดงรายละเอียดสินค้า (จำกัด 2 บรรทัด)
                            Text(
                              p.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis, // ถ้ายาวเกินใส่ ...
                              style: const TextStyle(color: Colors.grey),
                            ),

                            const SizedBox(height: 8),

                            // แสดงน้ำหนักสินค้า
                            Text(
                              '${p.weight} kg',
                              style: const TextStyle(
                                color: Color(0xFF42042A), // แก้สีให้เข้มขึ้น
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 8),

                            // แสดงราคาสินค้า
                            Text(
                              '฿ ${p.price}',
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}