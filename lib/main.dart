import 'package:flutter/material.dart';

const String studentName = 'Made Darma Krisaryawan';
const String studentId = '2415051081';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tahap 4 - Flexible Layout',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const FlexibleLayoutPage(),
    );
  }
}

class FlexibleLayoutPage extends StatelessWidget {
  const FlexibleLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 4 - Flexible Layout')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '$studentId - $studentName',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            const Text(
              '1. Expanded dengan Flex 2:1',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            SizedBox(
              height: 150,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: buildPanel('Panel A', 'Flex 2', Colors.indigo),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: buildPanel('Panel B', 'Flex 1', Colors.teal),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              '2. Flexible',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.phone_android, size: 36),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      'Contoh Flexible: teks ini menyesuaikan '
                      'ruang yang tersedia tanpa memaksa '
                      'mengisi seluruh ruang.',
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              '3. Wrap dengan Enam Chip Skill',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                Chip(avatar: Icon(Icons.code), label: Text('Dart')),
                Chip(avatar: Icon(Icons.phone_android), label: Text('Flutter')),
                Chip(avatar: Icon(Icons.web), label: Text('UI Design')),
                Chip(avatar: Icon(Icons.storage), label: Text('Database')),
                Chip(avatar: Icon(Icons.bug_report), label: Text('Debugging')),
                Chip(avatar: Icon(Icons.cloud), label: Text('GitHub')),
              ],
            ),

            const SizedBox(height: 28),

            const Text(
              '4. Kesimpulan Pengamatan',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Perhatikan bahwa Panel A mendapatkan '
              'porsi ruang lebih besar daripada Panel B. '
              'Chip pada Wrap berpindah ke baris berikutnya '
              'ketika lebar yang tersedia tidak cukup.',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPanel(String title, String subtitle, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(subtitle, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}