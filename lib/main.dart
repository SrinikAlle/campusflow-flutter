import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CampusFlowApp());
}

class CampusFlowApp extends StatelessWidget {
  const CampusFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF176B87),
      brightness: Brightness.light,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CampusFlow',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        scaffoldBackgroundColor: const Color(0xFFF6F8FA),
      ),
      home: const HomeShell(),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int index = 0;

  final pages = const [
    DashboardScreen(),
    AssignmentsScreen(),
    AttendanceScreen(),
    NotesScreen(),
    FocusScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: index, children: pages),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(Icons.assignment),
            label: 'Tasks',
          ),
          NavigationDestination(
            icon: Icon(Icons.show_chart),
            label: 'Attendance',
          ),
          NavigationDestination(
            icon: Icon(Icons.note_alt_outlined),
            selectedIcon: Icon(Icons.note_alt),
            label: 'Notes',
          ),
          NavigationDestination(
            icon: Icon(Icons.timer_outlined),
            selectedIcon: Icon(Icons.timer),
            label: 'Focus',
          ),
        ],
      ),
    );
  }
}

class PageFrame extends StatelessWidget {
  const PageFrame({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.action,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 22, 18, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: TextStyle(color: Colors.blueGrey.shade600),
                    ),
                  ],
                ),
              ),
              if (action != null) action!,
            ],
          ),
          const SizedBox(height: 20),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class AppCard extends StatelessWidget {
  const AppCard({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5E9EC)),
      ),
      child: child,
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageFrame(
      title: 'Good morning, Srinik',
      subtitle: 'Here is your academic overview.',
      child: ListView(
        children: [
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount:
                MediaQuery.of(context).size.width > 700 ? 4 : 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.35,
            children: const [
              StatCard(Icons.menu_book_rounded, 'Subjects', '6'),
              StatCard(Icons.assignment_turned_in_outlined, 'Tasks due', '4'),
              StatCard(Icons.percent, 'Attendance', '84%'),
              StatCard(Icons.timer_outlined, 'Focus today', '52m'),
            ],
          ),
          const SizedBox(height: 16),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 14),
                const ScheduleRow('09:30', 'Data Mining', 'Room 302'),
                const Divider(height: 24),
                const ScheduleRow('11:15', 'AI Lab', 'Lab 4'),
                const Divider(height: 24),
                const ScheduleRow('14:00', 'DBMS', 'Room 208'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Weekly progress',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Text(
                      '72%',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const LinearProgressIndicator(
                  value: .72,
                  minHeight: 10,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                const SizedBox(height: 10),
                Text(
                  'You completed 8 of 11 planned study goals.',
                  style: TextStyle(color: Colors.blueGrey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  const StatCard(this.icon, this.label, this.value, {super.key});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          Text(
            value,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w900),
          ),
          Text(label, style: TextStyle(color: Colors.blueGrey.shade600)),
        ],
      ),
    );
  }
}

class ScheduleRow extends StatelessWidget {
  const ScheduleRow(this.time, this.title, this.room, {super.key});

  final String time;
  final String title;
  final String room;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 58,
          child: Text(
            time,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
        Container(
          width: 4,
          height: 38,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(fontWeight: FontWeight.w800)),
              Text(room,
                  style: TextStyle(color: Colors.blueGrey.shade600)),
            ],
          ),
        ),
      ],
    );
  }
}

class Task {
  Task(this.title, this.subject, this.due);
  final String title;
  final String subject;
  final String due;
  bool done = false;
}

class AssignmentsScreen extends StatefulWidget {
  const AssignmentsScreen({super.key});

  @override
  State<AssignmentsScreen> createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AssignmentsScreen> {
  final tasks = [
    Task('Apriori implementation', 'Data Mining', 'Sep 27'),
    Task('ER diagram submission', 'DBMS', 'Sep 29'),
    Task('Planning graph notes', 'Artificial Intelligence', 'Oct 02'),
    Task('Flutter UI exercise', 'Mobile Development', 'Oct 04'),
  ];

  void addTask() {
    final controller = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add assignment'),
        content: TextField(
          controller: controller,
          decoration:
              const InputDecoration(labelText: 'Assignment title'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final value = controller.text.trim();
              if (value.isNotEmpty) {
                setState(() => tasks.insert(0, Task(value, 'General', 'Upcoming')));
              }
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageFrame(
      title: 'Assignments',
      subtitle: 'Stay ahead of every deadline.',
      action: FilledButton.icon(
        onPressed: addTask,
        icon: const Icon(Icons.add),
        label: const Text('Add'),
      ),
      child: ListView.separated(
        itemCount: tasks.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final item = tasks[index];
          return AppCard(
            child: Row(
              children: [
                Checkbox(
                  value: item.done,
                  onChanged: (value) =>
                      setState(() => item.done = value ?? false),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          decoration: item.done
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.subject + ' · Due ' + item.due,
                        style:
                            TextStyle(color: Colors.blueGrey.shade600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Subject {
  Subject(this.name, this.faculty, this.attended, this.total);
  final String name;
  final String faculty;
  int attended;
  int total;
  double get ratio => total == 0 ? 0 : attended / total;
}

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final subjects = [
    Subject('Data Mining', 'Dr. Rao', 22, 25),
    Subject('DBMS', 'Ms. Rajasri', 20, 24),
    Subject('Artificial Intelligence', 'Dr. Kumar', 18, 23),
    Subject('Mobile Development', 'Ms. Priya', 19, 21),
  ];

  @override
  Widget build(BuildContext context) {
    return PageFrame(
      title: 'Attendance',
      subtitle: 'Keep every subject above your target.',
      child: ListView.separated(
        itemCount: subjects.length,
        separatorBuilder: (_, __) => const SizedBox(height: 11),
        itemBuilder: (context, index) {
          final subject = subjects[index];
          final pct = (subject.ratio * 100).round();
          final safe = pct >= 75;

          return AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(subject.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800)),
                          Text(subject.faculty,
                              style: TextStyle(
                                  color: Colors.blueGrey.shade600)),
                        ],
                      ),
                    ),
                    Text(
                      pct.toString() + '%',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        color: safe
                            ? Colors.green.shade700
                            : Colors.red.shade700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: subject.ratio,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(10),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      subject.attended.toString() +
                          '/' +
                          subject.total.toString() +
                          ' classes',
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => setState(() {
                        subject.attended++;
                        subject.total++;
                      }),
                      child: const Text('Present'),
                    ),
                    TextButton(
                      onPressed: () =>
                          setState(() => subject.total++),
                      child: const Text('Absent'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Note {
  Note(this.title, this.body, this.subject);
  final String title;
  final String body;
  final String subject;
}

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final notes = [
    Note(
      'Apriori principle',
      'Every subset of a frequent itemset must also be frequent.',
      'Data Mining',
    ),
    Note(
      'Normalization',
      'Revise functional dependencies, 2NF, 3NF and BCNF examples.',
      'DBMS',
    ),
    Note(
      'Planning graph',
      'Alternate proposition and action levels until goals become reachable.',
      'AI',
    ),
  ];

  void addNote() {
    final title = TextEditingController();
    final body = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: title,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: body,
              maxLines: 4,
              decoration: const InputDecoration(labelText: 'Note'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (title.text.trim().isNotEmpty) {
                setState(() {
                  notes.insert(
                    0,
                    Note(
                      title.text.trim(),
                      body.text.trim(),
                      'General',
                    ),
                  );
                });
              }
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageFrame(
      title: 'Notes',
      subtitle: 'Capture quick revision points.',
      action: FilledButton.icon(
        onPressed: addNote,
        icon: const Icon(Icons.add),
        label: const Text('New'),
      ),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              MediaQuery.of(context).size.width > 700 ? 3 : 1,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 2.1,
        ),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.subject.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  note.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 7),
                Expanded(
                  child: Text(
                    note.body,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      color: Colors.blueGrey.shade700,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class FocusScreen extends StatefulWidget {
  const FocusScreen({super.key});

  @override
  State<FocusScreen> createState() => _FocusScreenState();
}

class _FocusScreenState extends State<FocusScreen> {
  static const initialSeconds = 25 * 60;
  int seconds = initialSeconds;
  Timer? timer;

  bool get running => timer?.isActive ?? false;

  void toggle() {
    if (running) {
      timer?.cancel();
      setState(() {});
      return;
    }

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds <= 1) {
        timer.cancel();
        setState(() => seconds = 0);
      } else {
        setState(() => seconds--);
      }
    });
    setState(() {});
  }

  void reset() {
    timer?.cancel();
    setState(() => seconds = initialSeconds);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    final progress = 1 - seconds / initialSeconds;

    return PageFrame(
      title: 'Focus timer',
      subtitle: 'Study with short, intentional sessions.',
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: AppCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 220,
                  height: 220,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 210,
                        height: 210,
                        child: CircularProgressIndicator(
                          value: progress,
                          strokeWidth: 12,
                          backgroundColor: const Color(0xFFE9EEF1),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            minutes + ':' + secs,
                            style: const TextStyle(
                              fontSize: 46,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            running
                                ? 'Focus in progress'
                                : '25 minute session',
                            style: TextStyle(
                              color: Colors.blueGrey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton.icon(
                      onPressed: reset,
                      icon: const Icon(Icons.restart_alt),
                      label: const Text('Reset'),
                    ),
                    const SizedBox(width: 12),
                    FilledButton.icon(
                      onPressed: toggle,
                      icon: Icon(
                        running ? Icons.pause : Icons.play_arrow,
                      ),
                      label: Text(running ? 'Pause' : 'Start'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
