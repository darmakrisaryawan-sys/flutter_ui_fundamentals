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
      home: const MainNavigationPage(),
    );
  }
}

class Course {
  final String id;
  final String title;
  final String category;
  final String description;
  final IconData icon;

  const Course({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.icon,
  });
}

const List<Course> courseList = [
  Course(
    id: 'IF101',
    title: 'Flutter UI Fundamentals',
    category: 'Mobile Development',
    description:
        'Mempelajari widget Flutter, layout responsif, '
        'navigasi, dan interaksi pengguna.',
    icon: Icons.phone_android,
  ),
  Course(
    id: 'IF102',
    title: 'Dart Programming',
    category: 'Programming',
    description:
        'Mempelajari variabel, fungsi, class, collection, '
        'dan dasar pemrograman Dart.',
    icon: Icons.code,
  ),
  Course(
    id: 'IF103',
    title: 'Responsive Design',
    category: 'UI/UX',
    description:
        'Mempelajari desain antarmuka yang menyesuaikan '
        'ukuran layar ponsel, tablet, dan desktop.',
    icon: Icons.devices,
  ),
  Course(
    id: 'IF104',
    title: 'Database Fundamentals',
    category: 'Database',
    description:
        'Mempelajari dasar basis data, tabel, relasi, '
        'dan pengelolaan informasi.',
    icon: Icons.storage,
  ),
];

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int currentIndex = 0;
  final Set<String> favoriteIds = {};

  void toggleFavorite(Course course) {
    setState(() {
      if (favoriteIds.contains(course.id)) {
        favoriteIds.remove(course.id);
      } else {
        favoriteIds.add(course.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(
        onOpenCourses: () {
          setState(() => currentIndex = 1);
        },
        onOpenFeedback: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FeedbackFormPage()),
          );
        },
      ),
      CoursesScreen(favoriteIds: favoriteIds, onToggleFavorite: toggleFavorite),
      const ProfileScreen(),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 840) {
          return Scaffold(
            body: pages[currentIndex],
            bottomNavigationBar: NavigationBar(
              selectedIndex: currentIndex,
              onDestinationSelected: (index) {
                setState(() => currentIndex = index);
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.school_outlined),
                  selectedIcon: Icon(Icons.school),
                  label: 'Courses',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
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
                selectedIndex: currentIndex,
                onDestinationSelected: (index) {
                  setState(() => currentIndex = index);
                },
                labelType: NavigationRailLabelType.all,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.school_outlined),
                    selectedIcon: Icon(Icons.school),
                    label: Text('Courses'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.person_outline),
                    selectedIcon: Icon(Icons.person),
                    label: Text('Profile'),
                  ),
                ],
              ),
              const VerticalDivider(width: 1),
              Expanded(child: pages[currentIndex]),
            ],
          ),
        );
      },
    ) ;
  }
}

class HomeScreen extends StatelessWidget {
  final VoidCallback onOpenCourses;
  final VoidCallback onOpenFeedback;

  const HomeScreen({
    super.key,
    required this.onOpenCourses,
    required this.onOpenFeedback,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Course Explorer')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.menu_book, size: 84),
              const SizedBox(height: 16),
              Text(
                'Selamat datang!',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                studentName,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text('NIM: $studentId'),
              const SizedBox(height: 16),
              const Text(
                'Temukan course untuk menambah pengetahuan '
                'dan keterampilanmu.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 240,
                child: FilledButton.icon(
                  onPressed: onOpenCourses,
                  icon: const Icon(Icons.school),
                  label: const Text('Jelajahi Courses'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: 240,
                child: OutlinedButton.icon(
                  onPressed: onOpenFeedback,
                  icon: const Icon(Icons.feedback_outlined),
                  label: const Text('Kirim Feedback'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CoursesScreen extends StatelessWidget {
  final Set<String> favoriteIds;
  final ValueChanged<Course> onToggleFavorite;

  const CoursesScreen({
    super.key,
    required this.favoriteIds,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Courses')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth < 600
              ? 1
              : constraints.maxWidth < 840
              ? 2
              : 3;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                child: Text(
                  'Pembuat: $studentName | NIM: $studentId',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Favorite: ${favoriteIds.length} course',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: courseList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    mainAxisExtent: 190,
                  ),
                  itemBuilder: (context, index) {
                    final course = courseList[index];
                    final isFavorite = favoriteIds.contains(course.id);

                    return Card(
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CourseDetailPage(course: course),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(course.icon, size: 32),
                                  const Spacer(),
                                  IconButton(
                                    tooltip: 'Favorite',
                                    onPressed: () => onToggleFavorite(course),
                                    icon: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isFavorite ? Colors.red : null,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                course.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                course.category,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Spacer(),
                              const Row(
                                children: [
                                  Text('Lihat detail'),
                                  SizedBox(width: 4),
                                  Icon(Icons.arrow_forward, size: 16),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CourseDetailPage extends StatelessWidget {
  final Course course;

  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Course')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Icon(course.icon, size: 80)),
            const SizedBox(height: 20),
            Text(
              course.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text('Kode: ${course.id}'),
            Text('Kategori: ${course.category}'),
            const SizedBox(height: 16),
            Text(course.description),
            const SizedBox(height: 24),
            Text('Nama: $studentName'),
            Text('NIM: $studentId'),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Kembali ke Courses'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 44,
                child: Icon(Icons.person, size: 48),
              ),
              const SizedBox(height: 16),
              Text(
                studentName,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text('NIM: $studentId'),
              const Text('Kelas: PTI 5B'),
              const SizedBox(height: 16),
              const Text(
                'Course Explorer — Responsive Navigation '
                '& User Interaction',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeedbackFormPage extends StatefulWidget {
  const FeedbackFormPage({super.key});

  @override
  State<FeedbackFormPage> createState() => _FeedbackFormPageState();
}

class _FeedbackFormPageState extends State<FeedbackFormPage> {
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
    if (!formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();

    setState(() => isLoading = true);

    // Simulasi proses, bukan penyimpanan ke server.
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
        icon: const Icon(Icons.check_circle, color: Colors.green, size: 40),
        title: const Text('Feedback berhasil'),
        content: SingleChildScrollView(
          child: Text(
            'Nama: $name\n'
            'NIM: $nim\n\n'
            'Komentar:\n$comment',
          ),
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
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
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
                  prefixIcon: Icon(Icons.badge),
                  border: OutlineInputBorder(),
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
                  alignLabelWithHint: true,
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
