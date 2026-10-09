import 'package:flutter/material.dart';

const String studentName = 'Made Darma Krisaryawan';
const String studentId = '2415051081';

void main() {
  runApp(const CourseExplorerApp());
}

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Explorer',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(
        onFeedback: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FeedbackPage()),
          );
        },
      ),
      const CoursesPage(),
      const ProfilePage(),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 840) {
          return Scaffold(
            body: pages[selectedIndex],
            bottomNavigationBar: NavigationBar(
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) {
                setState(() => selectedIndex = index);
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.school_outlined),
                  label: 'Courses',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  label: 'Profile',
                ),
              ],
            ),
          );
        }

        return Scaffold(
          body: Row(
            children: [
              NavigationRail(
                selectedIndex: selectedIndex,
                labelType: NavigationRailLabelType.all,
                onDestinationSelected: (index) {
                  setState(() => selectedIndex = index);
                },
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home_outlined),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.school_outlined),
                    label: Text('Courses'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.person_outline),
                    label: Text('Profile'),
                  ),
                ],
              ),
              const VerticalDivider(width: 1),
              Expanded(child: pages[selectedIndex]),
            ],
          ),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  final VoidCallback onFeedback;

  const HomePage({super.key, required this.onFeedback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Course Explorer')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.menu_book, size: 72),
              const SizedBox(height: 16),
              Text(
                studentName,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text('NIM: $studentId'),
              const SizedBox(height: 20),
              const Text(
                'Selamat datang di Course Explorer!',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: onFeedback,
                icon: const Icon(Icons.feedback),
                label: const Text('Buka Form Feedback'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    const courses = [
      'Flutter UI Fundamentals',
      'Dart Programming',
      'Responsive Design',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Courses')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (final course in courses)
            Card(
              child: ListTile(
                leading: const Icon(Icons.school),
                title: Text(course),
                subtitle: const Text('Course pembelajaran'),
              ),
            ),
          const SizedBox(height: 16),
          Text('Nama: $studentName'),
          Text('NIM: $studentId'),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 44)),
            const SizedBox(height: 16),
            Text(studentName, textAlign: TextAlign.center),
            Text('NIM: $studentId'),
            const Text('Kelas: PTI 5B'),
          ],
        ),
      ),
    );
  }
}

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController(text: studentName);
  final nimController = TextEditingController(text: studentId);
  final commentController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    nimController.dispose();
    commentController.dispose();
    super.dispose();
  }

  Future<void> submitForm() async {
    if (!formKey.currentState!.validate() || isLoading) {
      return;
    }

    FocusScope.of(context).unfocus();
    setState(() => isLoading = true);

    // Simulasi pemrosesan selama dua detik.
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() => isLoading = false);

    final name = nameController.text.trim();
    final nim = nimController.text.trim();
    final comment = commentController.text.trim();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Feedback berhasil diproses'),
        behavior: SnackBarBehavior.floating,
      ),
    );

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(Icons.check_circle, color: Colors.green, size: 42),
        title: const Text('Feedback berhasil'),
        content: Text(
          'Nama: $name\n'
          'NIM: $nim\n\n'
          'Komentar:\n$comment',
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Selesai'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Feedback')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(studentName, style: Theme.of(context).textTheme.titleLarge),
              Text('NIM: $studentId'),
              const SizedBox(height: 24),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: nimController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'NIM',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.badge),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'NIM wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: commentController,
                minLines: 3,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Komentar',
                  hintText: 'Minimal 5 karakter',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().length < 5) {
                    return 'Komentar minimal 5 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: isLoading ? null : submitForm,
                icon: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.send),
                label: Text(isLoading ? 'Memproses...' : 'Kirim Feedback'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
