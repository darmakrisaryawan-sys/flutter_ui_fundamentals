import 'package:flutter/material.dart';

const String studentName = 'Made Darma Krisaryawan';
const String studentId = '2415051081';

const List<String> courseNames = [
  'Pemrograman Mobile',
  'Pemrograman Web',
  'Basis Data',
  'Jaringan Komputer',
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
      home: const MainNavigationPage(),
    );
  }
}

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int currentIndex = 0;

  Widget buildNavigationBar() {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: (index) {
        setState(() {
          currentIndex = index;
        });
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
    );
  }

  Widget buildNavigationRail() {
    return NavigationRail(
      selectedIndex: currentIndex,
      onDestinationSelected: (index) {
        setState(() {
          currentIndex = index;
        });
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isExpanded = constraints.maxWidth >= 840;

        final List<Widget> pages = [
          HomeScreen(
            onExploreCourses: () {
              setState(() {
                currentIndex = 1;
              });
            },
          ),
          const CoursesScreen(),
          const ProfileScreen(),
        ];

        return Scaffold(
          appBar: AppBar(title: const Text('Course Explorer')),
          body: isExpanded
              ? Row(
                  children: [
                    buildNavigationRail(),
                    const VerticalDivider(width: 1, thickness: 1),
                    Expanded(child: pages[currentIndex]),
                  ],
                )
              : pages[currentIndex],
          bottomNavigationBar: isExpanded ? null : buildNavigationBar(),
        );
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  final VoidCallback onExploreCourses;

  const HomeScreen({super.key, required this.onExploreCourses});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Card(
          child: ListTile(
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Text(studentName),
            subtitle: Text(studentId),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Selamat Datang!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text('Jelajahi materi pembelajaran di Course Explorer.'),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onExploreCourses,
            icon: const Icon(Icons.school),
            label: const Text('Lihat Daftar Course'),
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Selamat belajar di Course Explorer!'),
              ),
            );
          },
          icon: const Icon(Icons.notifications),
          label: const Text('Tampilkan Pesan'),
        ),
      ],
    );
  }
}

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  final Set<String> favoriteCourses = {};

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Daftar Courses',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text('Tekan kartu untuk melihat interaksi.'),
        const SizedBox(height: 12),
        for (final course in courseNames)
          Card(
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Anda memilih $course')));
              },
              child: ListTile(
                leading: const Icon(Icons.menu_book),
                title: Text(course),
                subtitle: const Text('Tekan kartu untuk memilih course'),
                trailing: IconButton(
                  tooltip: 'Favorite',
                  icon: Icon(
                    favoriteCourses.contains(course)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: favoriteCourses.contains(course) ? Colors.red : null,
                  ),
                  onPressed: () {
                    setState(() {
                      if (favoriteCourses.contains(course)) {
                        favoriteCourses.remove(course);
                      } else {
                        favoriteCourses.add(course);
                      }
                    });
                  },
                ),
              ),
            ),
          ),
        const SizedBox(height: 12),
        Text(
          'Jumlah Favorite: ${favoriteCourses.length}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profil mahasiswa dipilih.')),
                );
              },
              child: const CircleAvatar(
                radius: 44,
                child: Icon(Icons.person, size: 44),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              studentName,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('NIM: $studentId'),
            const SizedBox(height: 8),
            const Text('Program Studi: PTI'),
            const Text('Kelas: PTI 5B'),
            const SizedBox(height: 16),
            const Text(
              'Tekan ikon profil untuk mencoba GestureDetector.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
