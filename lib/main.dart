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
      title: 'Tahap 6 - Scrollable Content',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const ScrollablePage(),
    );
  }
}

class ScrollablePage extends StatefulWidget {
  const ScrollablePage({super.key});

  @override
  State<ScrollablePage> createState() => _ScrollablePageState();
}

class _ScrollablePageState extends State<ScrollablePage> {
  final TextEditingController commentController = TextEditingController();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 6 - Scrollable Content')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '$studentId - $studentName',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 20),

            const Text(
              'Profil Mahasiswa',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(Icons.account_circle, size: 64, color: Colors.teal),
                    SizedBox(height: 12),
                    Text(
                      'Nama: Made Darma Krisaryawan',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text('NIM: 2415051081', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    Text(
                      'Mata Kuliah: Pemrograman Mobile',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Informasi Praktikum',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            const InfoTile(
              icon: Icons.devices,
              title: 'Responsive Layout',
              description: 'Membuat UI yang menyesuaikan ukuran layar.',
            ),
            const InfoTile(
              icon: Icons.grid_view,
              title: 'GridView',
              description: 'Menampilkan data dalam bentuk grid.',
            ),
            const InfoTile(
              icon: Icons.navigation,
              title: 'Navigation',
              description: 'Berpindah dari satu halaman ke halaman lain.',
            ),
            const InfoTile(
              icon: Icons.touch_app,
              title: 'User Interaction',
              description: 'Menangani interaksi dan masukan pengguna.',
            ),

            const SizedBox(height: 20),

            const Text(
              'Form Komentar',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            const Text(
              'Tuliskan catatan atau hasil pengamatan '
              'selama praktikum.',
            ),
            const SizedBox(height: 12),

            TextField(
              controller: commentController,
              minLines: 3,
              maxLines: 5,
              textInputAction: TextInputAction.newline,
              decoration: const InputDecoration(
                labelText: 'Komentar praktikum',
                hintText: 'Masukkan komentar di sini...',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),

            const SizedBox(height: 16),

            FilledButton.icon(
              onPressed: () {
                final comment = commentController.text.trim();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      comment.isEmpty
                          ? 'Komentar masih kosong.'
                          : 'Komentar berhasil dibaca.',
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.check),
              label: const Text('Periksa Komentar'),
            ),

            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Bagian akhir halaman. Gulir ke bawah '
                'untuk melihat seluruh konten.',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const InfoTile({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.teal),
        title: Text(title),
        subtitle: Text(description),
      ),
    );
  }
}
