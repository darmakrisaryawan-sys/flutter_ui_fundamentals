import 'package:flutter/material.dart';

const String studentName = 'Made Darma Krisaryawan';
const String studentId = '2415051081';

const List<Map<String, dynamic>> courses = [
  {
    'title': 'Pemrograman Mobile',
    'code': 'IF101',
    'credits': 3,
    'status': 'Aktif',
  },
  {
    'title': 'Pemrograman Web',
    'code': 'IF102',
    'credits': 3,
    'status': 'Aktif',
  },
  {'title': 'Basis Data', 'code': 'IF103', 'credits': 2, 'status': 'Selesai'},
  {
    'title': 'Jaringan Komputer',
    'code': 'IF104',
    'credits': 3,
    'status': 'Aktif',
  },
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Explorer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> openCourse(
    BuildContext context,
    Map<String, dynamic> course,
  ) async {
    final bool? result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => CourseDetailPage(course: course)),
    );

    if (!context.mounted) return;

    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${course['title']} ditambahkan ke Favorite!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Course Explorer')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Card(
            child: ListTile(
              leading: CircleAvatar(child: Icon(Icons.person)),
              title: Text(studentName),
              subtitle: Text(studentId),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Daftar Course',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          for (final course in courses)
            Card(
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.menu_book)),
                title: Text(course['title'] as String),
                subtitle: Text(
                  '${course['code']} • '
                  '${course['credits']} SKS',
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => openCourse(context, course),
              ),
            ),
        ],
      ),
    );
  }
}

class CourseDetailPage extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Course')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Card(
              child: ListTile(
                leading: CircleAvatar(child: Icon(Icons.person)),
                title: Text(studentName),
                subtitle: Text(studentId),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              course['title'] as String,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.tag),
                    title: const Text('Kode Course'),
                    subtitle: Text(course['code'] as String),
                  ),
                  ListTile(
                    leading: const Icon(Icons.school),
                    title: const Text('Jumlah SKS'),
                    subtitle: Text('${course['credits']} SKS'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('Status'),
                    subtitle: Text(course['status'] as String),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                icon: const Icon(Icons.favorite),
                label: const Text('Pilih/Favorite'),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali tanpa Memilih'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
