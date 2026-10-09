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
      title: 'MediaQuery - Tahap 2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const MediaQueryPage(),
    );
  }
}

class MediaQueryPage extends StatelessWidget {
  const MediaQueryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    final category = size.width < 600 ? 'Compact' : 'Wide';

    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 2 - MediaQuery')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '$studentId - $studentName',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Informasi Layar',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(height: 24),
                    Text(
                      'Width: ${size.width.toStringAsFixed(0)}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Height: ${size.height.toStringAsFixed(0)}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Orientation: $orientation',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Kategori: $category',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: category == 'Compact'
                    ? Colors.teal.shade100
                    : Colors.amber.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                category == 'Compact'
                    ? 'Tampilan Compact: layar relatif sempit.'
                    : 'Tampilan Wide: tersedia ruang horizontal lebih luas.',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Putar emulator dari portrait ke landscape '
              'untuk membandingkan ukuran layar.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
