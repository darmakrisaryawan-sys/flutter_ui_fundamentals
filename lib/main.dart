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
      title: 'LayoutBuilder - Tahap 3',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const BreakpointPage(),
    );
  }
}

class BreakpointPage extends StatelessWidget {
  const BreakpointPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 3 - Breakpoint')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          if (width < 600) {
            return const CompactLayout();
          } else if (width < 840) {
            return const MediumLayout();
          } else {
            return const ExpandedLayout();
          }
        },
      ),
    );
  }
}

// LAYOUT COMPACT: untuk ruang sempit
class CompactLayout extends StatelessWidget {
  const CompactLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const IdentityHeader(),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              children: [
                Icon(Icons.smartphone, size: 60, color: Colors.blue),
                SizedBox(height: 12),
                Text(
                  'COMPACT LAYOUT',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Lebar kurang dari 600 logical pixels.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const LayoutInfoCard(
            title: 'Susunan Vertikal',
            description:
                'Konten ditampilkan dalam satu kolom '
                'agar sesuai dengan layar ponsel.',
            icon: Icons.view_agenda,
          ),
        ],
      ),
    );
  }
}

// LAYOUT MEDIUM: untuk ruang menengah
class MediumLayout extends StatelessWidget {
  const MediumLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const IdentityHeader(),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              children: [
                Icon(Icons.tablet_android, size: 60, color: Colors.deepOrange),
                SizedBox(height: 12),
                Text(
                  'MEDIUM LAYOUT',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Lebar 600 sampai kurang dari 840.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              Expanded(
                child: LayoutInfoCard(
                  title: 'Panel A',
                  description: 'Bagian pertama.',
                  icon: Icons.dashboard,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: LayoutInfoCard(
                  title: 'Panel B',
                  description: 'Bagian kedua.',
                  icon: Icons.widgets,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// LAYOUT EXPANDED: untuk ruang lebar
class ExpandedLayout extends StatelessWidget {
  const ExpandedLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const IdentityHeader(),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                Icon(Icons.desktop_windows, size: 64, color: Colors.green),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'EXPANDED LAYOUT',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Lebar 840 logical pixels atau lebih. '
                        'Konten dapat ditampilkan berdampingan.',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: LayoutInfoCard(
                  title: 'Panel A',
                  description:
                      'Informasi utama ditampilkan '
                      'di panel pertama.',
                  icon: Icons.dashboard,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: LayoutInfoCard(
                  title: 'Panel B',
                  description:
                      'Informasi tambahan ditampilkan '
                      'di panel kedua.',
                  icon: Icons.view_quilt,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: LayoutInfoCard(
                  title: 'Panel C',
                  description:
                      'Panel tambahan memanfaatkan '
                      'ruang horizontal.',
                  icon: Icons.devices,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Widget identitas yang digunakan ulang
class IdentityHeader extends StatelessWidget {
  const IdentityHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Identitas Mahasiswa',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Nama: $studentName'),
            Text('NIM: $studentId'),
          ],
        ),
      ),
    );
  }
}

// Widget informasi yang digunakan ulang
class LayoutInfoCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const LayoutInfoCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 32),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(description),
          ],
        ),
      ),
    );
  }
}
