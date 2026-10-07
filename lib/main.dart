import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<Map<String, dynamic>> loadStudentData() async {
  final jsonString = await rootBundle.loadString(
    'assets/data/student_data_salah.json',
  );

  return jsonDecode(jsonString) as Map<String, dynamic>;
}

// Reusable widget 1
Widget buildSummaryCard(
  String value,
  String label,
  IconData icon,
) {
  return Expanded(
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(
              icon,
              size: 28,
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}

// Reusable widget 2
Widget buildCourseCard(
  Map<String, dynamic> course,
) {
  final String status = course['status'] as String;

  IconData statusIcon;
  String statusText;

  if (status == 'done') {
    statusIcon = Icons.check_circle;
    statusText = 'Selesai';
  } else if (status == 'active') {
    statusIcon = Icons.play_circle;
    statusText = 'Aktif';
  } else {
    statusIcon = Icons.schedule;
    statusText = 'Direncanakan';
  }

  return Card(
    child: ListTile(
      leading: CircleAvatar(
        child: Text(
          course['code']
              .toString()
              .substring(3),
        ),
      ),
      title: Text(
        course['title'] as String,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        '${course['code']} • '
        '${course['credits']} SKS',
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            statusIcon,
            size: 22,
          ),
          const SizedBox(height: 2),
          Text(
            statusText,
            style: const TextStyle(
              fontSize: 11,
            ),
          ),
        ],
      ),
    ),
  );
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<Map<String, dynamic>> studentFuture;

  @override
  void initState() {
    super.initState();

    studentFuture = loadStudentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Learning Dashboard',
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: studentFuture,
        builder: (context, snapshot) {
          // Loading state
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Error state
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Gagal memuat data:\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          // Data tidak tersedia
          if (!snapshot.hasData) {
            return const Center(
              child: Text(
                'Data tidak tersedia.',
              ),
            );
          }

          final data = snapshot.data!;

          final student =
              data['student'] as Map<String, dynamic>;

          final courses =
              data['courses'] as List<dynamic>;

          final String nim =
              student['nim'] as String;

          final String name =
              student['name'] as String;

          final int semester =
              student['semester'] as int;

          final int totalCredits =
              courses.fold<int>(
            0,
            (sum, course) =>
                sum +
                (course['credits'] as int),
          );

          final int completedCourses =
              courses.where(
                (course) =>
                    course['status'] == 'done',
              ).length;

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.stretch,
                children: [
                  // Profile / Identity Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 48,
                            backgroundImage: AssetImage(
                              'assets/images/profile.jpg',
                            ),
                          ),

                          const SizedBox(height: 12),

                          Text(
                            name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            nim,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            'Mahasiswa Semester $semester',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Summary
                  const Text(
                    'Ringkasan Pembelajaran',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      buildSummaryCard(
                        '${courses.length}',
                        'Mata Kuliah',
                        Icons.menu_book,
                      ),
                      const SizedBox(width: 8),
                      buildSummaryCard(
                        '$totalCredits',
                        'Total SKS',
                        Icons.school,
                      ),
                      const SizedBox(width: 8),
                      buildSummaryCard(
                        '$completedCourses',
                        'Selesai',
                        Icons.check_circle,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Course list title
                  const Text(
                    'Daftar Materi',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Course list
                  ...courses.map(
                    (course) => buildCourseCard(
                      course as Map<String, dynamic>,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter UI Fundamentals',
      home: const DashboardPage(),
    );
  }
}

void main() {
  runApp(const MyApp());
}