import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Task {
  final String title;
  final String notes;
  final DateTime? date;
  final TimeOfDay? time;
  final String group;

  const Task({
    required this.title,
    required this.notes,
    required this.date,
    this.time,
    required this.group,
  });
}

class Taskprovider extends ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get task => _tasks;

  void addtask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }
}

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _notesController = TextEditingController();
  DateTime? _selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay? _selectedTime;
  bool _enableDate = true;
  bool _enableTime = false;
  String _selectedGroup = 'Personal';

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submitTask() {
    if (_titleController.text.isEmpty) return;

    final task = Task(
      title: _titleController.text,
      notes: _notesController.text,
      date: _enableDate ? _selectedDate : null,
      time: _enableTime ? _selectedTime : null,
      group: _selectedGroup,
    );

    Provider.of<Taskprovider>(context, listen: false).addtask(task);
    Navigator.pop(context);
  }

  Widget _buildWeekDatePicker() {
    final now = DateTime.now();
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (_, i) {
          final date = now.add(Duration(days: i));
          final isSelected =
              _selectedDate != null &&
              date.day == _selectedDate!.day &&
              date.month == _selectedDate!.month;

          return GestureDetector(
            onTap: () => setState(() => _selectedDate = date),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF10443B) : Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ['SU', 'MO', 'TU', 'WE', 'TH', 'FR', 'SA'][date.weekday %
                        7],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    date.day.toString(),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FA),
      appBar: AppBar(
        title: const Text('Add Task'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 15,
                  ),
                  hintText: 'Title',
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _notesController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 15,
                  ),
                  hintText: 'Notes',
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white,
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 20),

              // Date toggle and picker
              Row(
                children: [
                  const Icon(Icons.calendar_month),
                  const SizedBox(width: 10),
                  const Text("Due Date"),
                  const Spacer(),
                  Switch(
                    value: _enableDate,
                    onChanged: (val) => setState(() => _enableDate = val),
                  ),
                ],
              ),
              if (_enableDate) _buildWeekDatePicker(),

              const SizedBox(height: 20),

              // Time toggle and picker
              Row(
                children: [
                  const Icon(Icons.access_time),
                  const SizedBox(width: 10),
                  const Text("Time"),
                  const Spacer(),
                  Switch(
                    value: _enableTime,
                    onChanged: (val) async {
                      if (val) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null) {
                          setState(() {
                            _selectedTime = time;
                            _enableTime = true;
                          });
                        }
                      } else {
                        setState(() => _enableTime = false);
                      }
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Group dropdown
              Row(
                children: [
                  const Icon(Icons.folder),
                  const SizedBox(width: 10),
                  Text(_selectedGroup),
                  const Spacer(),
                  DropdownButton<String>(
                    value: _selectedGroup,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _selectedGroup = value);
                      }
                    },
                    items:
                        ['Work', 'Personal', 'Blog']
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                  ),
                ],
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),

      // Add Task Button fixed at the bottom
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF10443B),
            minimumSize: const Size(double.infinity, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          onPressed: _submitTask,
          icon: const Icon(Icons.add),
          label: const Text(
            "Add Task",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }
}
