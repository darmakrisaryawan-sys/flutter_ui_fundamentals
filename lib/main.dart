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
      title: 'Responsive Layout - Tahap 1',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const ResponsiveProblemPage(),
    );
  }
}

class ResponsiveProblemPage extends StatelessWidget {
  const ResponsiveProblemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 1 - Fixed Width')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '$studentId - $studentName',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Percobaan A: Hard-coded Width = 500',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.shade200,
                border: Border.all(color: Colors.deepOrange, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Container dengan lebar tetap 500 pixel. '
                'Amati apakah seluruh kotak terlihat pada layar.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Pengamatan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Uji tampilan ini pada emulator berukuran kecil. '
              'Perhatikan apakah kotak melewati batas layar '
              'atau menimbulkan ruang kosong berlebihan.',
            ),
          ],
        ),
      ),
    );
  }
}
