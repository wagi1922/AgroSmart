import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'schedule.dart';
import 'schedule_provider.dart';
import 'schedule_list.dart';
import 'schedule_form.dart';

class Schedule {
  final String title;
  final DateTime date;
  final TimeOfDay time;

  Schedule({
    required this.title,
    required this.date,
    required this.time,
  });
}

class ScheduleApp extends StatefulWidget {
  const ScheduleApp({Key? key}) : super(key: key);

  @override
  _ScheduleAppState createState() => _ScheduleAppState();
}

class _ScheduleAppState extends State<ScheduleApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ScheduleProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Schedule App'),
        ),
        body: ScheduleList(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return ScheduleForm();
              },
            );
          },
        ),
      ),
    );
  }
}
