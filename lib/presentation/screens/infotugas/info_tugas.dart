import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:kelas_kita/presentation/themes/FontsStyle.dart';

// Font Family
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
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            title: Text(
              'Info Tugas',
              style: tsHeader3(screenSize: screenWidth),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Container(
                padding: EdgeInsets.all(screenWidth * 0.01),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
                ),
                child: Icon(Icons.arrow_back, color: Colors.white, size: screenWidth * 0.06),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(screenWidth * 0.01),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300]!, width: 1),
                  ),
                ),
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                height: screenWidth * 0.0025,
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
                    context: context,
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
        child: Icon(Icons.add, color: Colors.white, size: screenWidth * 0.08),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _showTaskOptions(BuildContext context, Task task) {
    var screenWidth = MediaQuery.of(context).size.width;

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(screenWidth * 0.025)),
      ),
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.edit, color: Colors.orange, size: screenWidth * 0.07),
            title: Text('Edit', style: tsParagraft3(screenSize: screenWidth)),
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
            leading: Icon(Icons.delete, color: Colors.red, size: screenWidth * 0.07),
            title: Text('Delete', style: tsParagraft3(screenSize: screenWidth)),
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
    var screenWidth = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenWidth * 0.025)),
        title: Text('Hapus Tugas', style: tsHeader3(screenSize: screenWidth)),
        content: Text('Apakah Anda yakin ingin menghapus tugas ini?', style: tsParagraft3(screenSize: screenWidth)),
        actions: <Widget>[
          TextButton(
            child: Text('Batal', style: tsParagraft3(screenSize: screenWidth)),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          TextButton(
            child: Text('Hapus', style: tsParagraft3(screenSize: screenWidth)),
            onPressed: () {
              Provider.of<TaskProvider>(context, listen: false).removeTask(task);
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard({required BuildContext context, required String title, required String description, required String teacher, required String date}) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Card(
      margin: EdgeInsets.all(screenWidth * 0.04),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.025),
      ),
      elevation: 0.0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.circular(screenWidth * 0.025),
        ),
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: tsHeader3(screenSize: screenWidth),
            ),
            SizedBox(height: screenWidth * 0.025),
            Text(
              'Ketentuan: $description',
              style: tsParagraft3(screenSize: screenWidth),
            ),
            SizedBox(height: screenWidth * 0.025),
            Row(
              children: [
                Text('Guru: $teacher', style: tsParagraft3(screenSize: screenWidth)),
                Spacer(),
                Icon(Icons.calendar_today, size: screenWidth * 0.04, color: Colors.red),
                SizedBox(width: screenWidth * 0.01),
                Text(date, style: tsParagraft3(screenSize: screenWidth)),
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

  Future<void> _selectDate(BuildContext context) async {
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

  void _uploadTask(BuildContext context) {
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.025)),
          title: Text('Perhatian', style: tsHeader3(screenSize: MediaQuery.of(context).size.width)),
          content: Text('Isi semua bidang terlebih dahulu.', style: tsParagraft3(screenSize: MediaQuery.of(context).size.width)),
          actions: <Widget>[
            TextButton(
              child: Text('OK', style: tsParagraft3(screenSize: MediaQuery.of(context).size.width)),
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
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text('Tambah Info Tugas', style: tsHeader3(screenSize: screenWidth)),
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            padding: EdgeInsets.all(screenWidth * 0.01),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(screenWidth * 0.02),
            ),
            child: Icon(Icons.arrow_back, color: Colors.white, size: screenWidth * 0.06),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(screenWidth * 0.0025),
          child: Container(
            color: Colors.grey[300],
            height: screenWidth * 0.0025,
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildTextFormField(
                context: context,
                controller: _nameController,
                label: 'Nama Tugas',
                validator: (value) => value!.isEmpty ? 'Isi nama tugas' : null,
              ),
              SizedBox(height: screenWidth * 0.04),
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
                    child: Text(teacher, style: tsParagraft3(screenSize: screenWidth)),
                  );
                }).toList(),
                validator: (value) => value == null ? 'Pilih guru' : null,
                style: tsParagraft3(screenSize: screenWidth),
              ),
              SizedBox(height: screenWidth * 0.04),
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
                      onTap: () => _selectDate(context),
                      validator: (value) => value!.isEmpty ? 'Pilih tanggal' : null,
                      style: tsParagraft3(screenSize: screenWidth),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today, size: screenWidth * 0.07),
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),
              SizedBox(height: screenWidth * 0.04),
              _buildTextFormField(
                context: context,
                controller: _descriptionController,
                label: 'Ketentuan Tugas',
                validator: (value) => value!.isEmpty ? 'Isi ketentuan tugas' : null,
              ),
              SizedBox(height: screenWidth * 0.06),
              Container(
                width: double.infinity,
                child: FloatingActionButton(
                  onPressed: () => _uploadTask(context),
                  child: Icon(Icons.check, color: Colors.white, size: screenWidth * 0.08),
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
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
  }) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: tsParagraft3(screenSize: screenWidth),
        ),
        SizedBox(height: screenWidth * 0.02),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(),
          ),
          maxLines: label == 'Ketentuan Tugas' ? 5 : 1,
          validator: validator,
          style: tsParagraft3(screenSize: screenWidth),
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

  Future<void> _selectDate(BuildContext context) async {
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

  void _updateTask(BuildContext context) {
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.025)),
          title: Text('Perhatian', style: tsHeader3(screenSize: MediaQuery.of(context).size.width)),
          content: Text('Isi semua bidang terlebih dahulu.', style: tsParagraft3(screenSize: MediaQuery.of(context).size.width)),
          actions: <Widget>[
            TextButton(
              child: Text('OK', style: tsParagraft3(screenSize: MediaQuery.of(context).size.width)),
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
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text('Edit Info Tugas', style: tsHeader3(screenSize: screenWidth)),
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            padding: EdgeInsets.all(screenWidth * 0.01),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(screenWidth * 0.02),
            ),
            child: Icon(Icons.arrow_back, color: Colors.white, size: screenWidth * 0.06),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(screenWidth * 0.0025),
          child: Container(
            color: Colors.grey[300],
            height: screenWidth * 0.0025,
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildTextFormField(
                context: context,
                controller: _nameController,
                label: 'Nama Tugas',
                validator: (value) => value!.isEmpty ? 'Isi nama tugas' : null,
              ),
              SizedBox(height: screenWidth * 0.04),
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
                    child: Text(teacher, style: tsParagraft3(screenSize: screenWidth)),
                  );
                }).toList(),
                validator: (value) => value == null ? 'Pilih guru' : null,
                style: tsParagraft3(screenSize: screenWidth),
              ),
              SizedBox(height: screenWidth * 0.04),
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
                      onTap: () => _selectDate(context),
                      validator: (value) => value!.isEmpty ? 'Pilih tanggal' : null,
                      style: tsParagraft3(screenSize: screenWidth),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today, size: screenWidth * 0.07),
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),
              SizedBox(height: screenWidth * 0.04),
              _buildTextFormField(
                context: context,
                controller: _descriptionController,
                label: 'Ketentuan Tugas',
                validator: (value) => value!.isEmpty ? 'Isi ketentuan tugas' : null,
              ),
              SizedBox(height: screenWidth * 0.06),
              Container(
                width: double.infinity,
                child: FloatingActionButton(
                  onPressed: () => _updateTask(context),
                  child: Icon(Icons.check, color: Colors.white, size: screenWidth * 0.08),
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
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
  }) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: tsParagraft3(screenSize: screenWidth),
        ),
        SizedBox(height: screenWidth * 0.02),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(),
          ),
          maxLines: label == 'Ketentuan Tugas' ? 5 : 1,
          validator: validator,
          style: tsParagraft3(screenSize: screenWidth),
        ),
      ],
    );
  }
}
