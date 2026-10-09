import 'package:flutter/material.dart';

const String studentName = 'Made Darma Krisaryawan';
const String studentId = '2415051081';

const List<Map<String, String>> courses = [
  {
    'code': 'IF101',
    'title': 'Pemrograman Mobile',
    'description': 'Belajar membuat aplikasi Flutter.',
  },
  {
    'code': 'IF102',
    'title': 'Analisis Data',
    'description': 'Mempelajari pengolahan data.',
  },
  {
    'code': 'IF103',
    'title': 'Basis Data',
    'description': 'Mengenal tabel dan relasi data.',
  },
  {
    'code': 'IF104',
    'title': 'Jaringan Komputer',
    'description': 'Mempelajari jaringan dan protokol.',
  },
  {
    'code': 'IF105',
    'title': 'Pemrograman Web',
    'description': 'Membangun aplikasi berbasis web.',
  },
  {
    'code': 'IF106',
    'title': 'Kecerdasan Buatan',
    'description': 'Mengenal konsep AI dan penerapannya.',
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
      title: 'Tahap 5 - Responsive Grid',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const CoursesPage(),
    );
  }
}

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  int columnsFor(double width) {
    if (width < 600) return 1;
    if (width < 840) return 2;
    return 3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 5 - Course Explorer')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '$studentId - $studentName',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Daftar Mata Kuliah',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final columns = columnsFor(constraints.maxWidth);

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: courses.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    mainAxisExtent: 190,
                  ),
                  itemBuilder: (context, index) {
                    final course = courses[index];

                    return CourseCard(
                      code: course['code']!,
                      title: course['title']!,
                      description: course['description']!,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final String code;
  final String title;
  final String description;

  const CourseCard({
    super.key,
    required this.code,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.school, size: 32, color: Colors.indigo),
            const SizedBox(height: 8),
            Text(
              code,
              style: TextStyle(
                color: Colors.indigo.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
