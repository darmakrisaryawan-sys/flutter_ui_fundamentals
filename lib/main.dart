import 'package:flutter/material.dart';

const String studentName = 'Made Darma Krisaryawan';
const String studentId = '2415051081';

Widget buildStatCard(String value, String label, IconData icon) {
  return Column(
    children: [
      Icon(icon, size: 28),
      const SizedBox(height: 4),
      Text(
        value,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      Text(label),
    ],
  );
}

class GreetingCard extends StatefulWidget {
  const GreetingCard({super.key});

  @override
  State<GreetingCard> createState() => _GreetingCardState();
}

class _GreetingCardState extends State<GreetingCard> {
  final TextEditingController nameController = TextEditingController();

  String message = 'Masukkan nama Anda';

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void showGreeting() {
    setState(() {
      message = 'Halo, ${nameController.text}!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: showGreeting,
              child: const Text('Tampilkan'),
            ),
            const SizedBox(height: 12),
            Text(message, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final List<Map<String, dynamic>> topics = const [
    {'title': 'Dart Fundamentals', 'category': 'Dart'},
    {'title': 'Flutter UI Fundamentals', 'category': 'Flutter'},
    {'title': 'Git & GitHub', 'category': 'Version Control'},
    {'title': 'Widget Layout', 'category': 'Flutter UI'},
    {'title': 'Made Darma Krisaryawan - 2415051081', 'category': 'Student'},
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter UI Fundamentals',
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter UI Fundamentals')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 46,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),

              const SizedBox(height: 12),

              Text(
                studentName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(studentId, style: const TextStyle(fontSize: 18)),

              const SizedBox(height: 12),

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone_android, size: 30),
                  SizedBox(width: 8),
                  Text(
                    'Mobile Programming Student',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildStatCard('3', 'Modul', Icons.menu_book),
                      buildStatCard('5', 'Materi', Icons.book),
                      buildStatCard('2', 'Selesai', Icons.check_circle),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              const GreetingCard(),

              const SizedBox(height: 12),

              const Text(
                'Materi Pembelajaran',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              Expanded(
                child: ListView.builder(
                  itemCount: topics.length,
                  itemBuilder: (context, index) {
                    final topic = topics[index];

                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.menu_book),
                        title: Text(topic['title']),
                        subtitle: Text(topic['category']),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}
