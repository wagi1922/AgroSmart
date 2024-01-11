import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'schedule.dart';
import 'schedule_provider.dart';

class ScheduleForm extends StatefulWidget {
  const ScheduleForm({Key? key}) : super(key: key);

  @override
  _ScheduleFormState createState() => _ScheduleFormState();
}

class _ScheduleFormState extends State<ScheduleForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Title',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
          ),
          Row(
            children: [
              Text('Date: ${_selectedDate}'),
              IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2021),
                    lastDate: DateTime(2030),
                  );
                  if (date != null) {
                    setState(() {
                      _selectedDate = date;
                    });
                  }
                },
              ),
            ],
          ),
          Row(
            children: [
              Text('Time: ${_selectedTime.format(context)}'),
              IconButton(
                icon: Icon(Icons.access_time),
                onPressed: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: _selectedTime,
                  );
                  if (time != null) {
                    setState(() {
                      _selectedTime = time;
                    });
                  }
                },
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final schedule = Schedule(
                  title: _titleController.text,
                  date: _selectedDate,
                  time: _selectedTime,
                );
                final provider =
                    Provider.of<ScheduleProvider>(context, listen: false);
                provider.addSchedule(schedule);
                Navigator.pop(context);
              }
            },
            child: Text('Create Schedule'),
          ),
        ],
      ),
    );
  }
}
