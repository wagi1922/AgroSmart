import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'schedule.dart';
import 'schedule_provider.dart';

class ScheduleList extends StatelessWidget {
  const ScheduleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ScheduleProvider>(context);
    final schedules = provider.schedules;

    return ListView.builder(
      itemCount: schedules.length,
      itemBuilder: (context, index) {
        final schedule = schedules[index];
        return ListTile(
          title: Text(schedule.title),
          subtitle: Text('${schedule.date} ${schedule.time}'),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              provider.removeSchedule(schedule);
            },
          ),
        );
      },
    );
  }
}
