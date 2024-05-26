import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MyApp(),
    ),
  );
}

class Task {
  final String title;
  final String description;
  final String teacher;
  final String date;

  Task({
    required this.title,
    required this.description,
    required this.teacher,
    required this.date,
  });
}

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [
    Task(
      title: 'Flutter Sqflite',
      description: 'Bisa add favorite atau add cart dan tersimpan ke local database',
      teacher: 'Pak Aji',
      date: '18 February 2024',
    ),
  ];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task oldTask, Task newTask) {
    final index = _tasks.indexOf(oldTask);
    if (index != -1) {
      _tasks[index] = newTask;
      notifyListeners();
    }
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Info Tugas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            title: Text(
              'Info Tugas',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(4.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300]!, width: 1),
                  ),
                ),
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                height: 1.0,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                final Task task = Provider.of<TaskProvider>(context).tasks[index];

                return GestureDetector(
                  onLongPress: () => _showTaskOptions(context, task),
                  child: _buildTaskCard(
                    title: task.title,
                    description: task.description,
                    teacher: task.teacher,
                    date: task.date,
                  ),
                );
              },
              childCount: Provider.of<TaskProvider>(context).tasks.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => NewTaskPage()),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _showTaskOptions(BuildContext context, Task task) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.edit, color: Colors.orange),
            title: Text('Edit'),
            onTap: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditTaskPage(task: task),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.delete, color: Colors.red),
            title: Text('Delete'),
            onTap: () {
              Navigator.of(ctx).pop();
              _showDeleteConfirmation(context, task);
            },
          ),
          Divider(),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text('Hapus Tugas', style: TextStyle(color: Colors.blue)),
        content: Text('Apakah Anda yakin ingin menghapus tugas ini?', style: TextStyle(color: Colors.black)),
        actions: <Widget>[
          TextButton(
            child: Text('Batal', style: TextStyle(color: Colors.blue)),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          TextButton(
            child: Text('Hapus', style: TextStyle(color: Colors.blue)),
            onPressed: () {
              Provider.of<TaskProvider>(context, listen: false).removeTask(task);
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard({required String title, required String description, required String teacher, required String date}) {
    return Card(
      margin: EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Ketentuan: $description',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Text('Guru: $teacher'),
                Spacer(),
                Icon(Icons.calendar_today, size: 16.0, color: Colors.red),
                SizedBox(width: 4.0),
                Text(date),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NewTaskPage extends StatefulWidget {
  @override
  _NewTaskPageState createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  String? _selectedTeacher;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _deadlineController = TextEditingController();

  final List<String> teachers = ['Pak Aji', 'Pak Dwi', 'Pak Agus', 'Pak Fahmi', 'Pak Anjas'];

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _deadlineController.text = DateFormat('dd MMMM yyyy').format(picked);
      });
    }
  }

  void _uploadTask() {
    if (_formKey.currentState!.validate()) {
      final TaskProvider taskProvider = Provider.of<TaskProvider>(context, listen: false);
      final Task newTask = Task(
        title: _nameController.text,
        description: _descriptionController.text,
        teacher: _selectedTeacher ?? '',
        date: _deadlineController.text,
      );
      taskProvider.addTask(newTask);
      Navigator.of(context).pop();
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text('Perhatian', style: TextStyle(color: Colors.blue)),
          content: Text('Isi semua bidang terlebih dahulu.', style: TextStyle(color: Colors.black)),
          actions: <Widget>[
            TextButton(
              child: Text('OK', style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text('Tambah Info Tugas', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[300],
            height: 1.0,
            margin: EdgeInsets.symmetric(horizontal: 30.0),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildTextFormField(
                controller: _nameController,
                label: 'Nama Tugas',
                validator: (value) => value!.isEmpty ? 'Isi nama tugas' : null,
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Guru Pemberi Tugas',
                  border: OutlineInputBorder(),
                ),
                value: _selectedTeacher,
                onChanged: (newValue) {
                  setState(() {
                    _selectedTeacher = newValue;
                  });
                },
                items: teachers.map((teacher) {
                  return DropdownMenuItem(
                    value: teacher,
                    child: Text(teacher),
                  );
                }).toList(),
                validator: (value) => value == null ? 'Pilih guru' : null,
              ),
              SizedBox(height: 16.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: _deadlineController,
                      decoration: InputDecoration(
                        labelText: 'Deadline Tugas',
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                      onTap: _selectDate,
                      validator: (value) => value!.isEmpty ? 'Pilih tanggal' : null,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: _selectDate,
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              _buildTextFormField(
                controller: _descriptionController,
                label: 'Ketentuan Tugas',
                validator: (value) => value!.isEmpty ? 'Isi ketentuan tugas' : null,
              ),
              SizedBox(height: 24.0),
              Container(
                width: double.infinity,
                child: FloatingActionButton(
                  onPressed: _uploadTask,
                  child: Icon(Icons.check, color: Colors.white),
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(),
          ),
          maxLines: label == 'Ketentuan Tugas' ? 5 : 1,
          validator: validator,
        ),
      ],
    );
  }
}

class EditTaskPage extends StatefulWidget {
  final Task task;

  EditTaskPage({required this.task});

  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _deadlineController = TextEditingController();
  String? _selectedTeacher;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.task.title;
    _descriptionController.text = widget.task.description;
    _deadlineController.text = widget.task.date;
    _selectedTeacher = widget.task.teacher;
    _selectedDate = DateFormat('dd MMMM yyyy').parse(widget.task.date);
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _deadlineController.text = DateFormat('dd MMMM yyyy').format(picked);
      });
    }
  }

  void _updateTask() {
    if (_formKey.currentState!.validate()) {
      final TaskProvider taskProvider = Provider.of<TaskProvider>(context, listen: false);
      final Task updatedTask = Task(
        title: _nameController.text,
        description: _descriptionController.text,
        teacher: _selectedTeacher ?? '',
        date: _deadlineController.text,
      );
      taskProvider.updateTask(widget.task, updatedTask);
      Navigator.of(context).pop();
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text('Perhatian', style: TextStyle(color: Colors.blue)),
          content: Text('Isi semua bidang terlebih dahulu.', style: TextStyle(color: Colors.black)),
          actions: <Widget>[
            TextButton(
              child: Text('OK', style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text('Edit Info Tugas', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[300],
            height: 1.0,
            margin: EdgeInsets.symmetric(horizontal: 30.0),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildTextFormField(
                controller: _nameController,
                label: 'Nama Tugas',
                validator: (value) => value!.isEmpty ? 'Isi nama tugas' : null,
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Guru Pemberi Tugas',
                  border: OutlineInputBorder(),
                ),
                value: _selectedTeacher,
                onChanged: (newValue) {
                  setState(() {
                    _selectedTeacher = newValue;
                  });
                },
                items: ['Pak Aji', 'Pak Dwi', 'Pak Agus', 'Pak Fahmi', 'Pak Anjas'].map((teacher) {
                  return DropdownMenuItem(
                    value: teacher,
                    child: Text(teacher),
                  );
                }).toList(),
                validator: (value) => value == null ? 'Pilih guru' : null,
              ),
              SizedBox(height: 16.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: _deadlineController,
                      decoration: InputDecoration(
                        labelText: 'Deadline Tugas',
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                      onTap: _selectDate,
                      validator: (value) => value!.isEmpty ? 'Pilih tanggal' : null,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: _selectDate,
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              _buildTextFormField(
                controller: _descriptionController,
                label: 'Ketentuan Tugas',
                validator: (value) => value!.isEmpty ? 'Isi ketentuan tugas' : null,
              ),
              SizedBox(height: 24.0),
              Container(
                width: double.infinity,
                child: FloatingActionButton(
                  onPressed: _updateTask,
                  child: Icon(Icons.check, color: Colors.white),
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(),
          ),
          maxLines: label == 'Ketentuan Tugas' ? 5 : 1,
          validator: validator,
        ),
      ],
    );
  }
}
