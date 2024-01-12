import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class SiramAir extends StatefulWidget {
  const SiramAir({Key? key}) : super(key: key);

  @override
  _SchwiggetState createState() => _SchwiggetState();
}

class _SchwiggetState extends State<SiramAir> {
  TextEditingController _titleController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  TimeOfDay _scheduledTime = TimeOfDay(hour: 24, minute: 0);
  late StreamController<DateTime> _dateTimeController;
  bool _userSelectedNewTime = false;

  @override
  void initState() {
    super.initState();
    _dateTimeController = StreamController<DateTime>.broadcast();
    _startTimer();
  }

  @override
  void dispose() {
    _dateTimeController.close();
    super.dispose();
  }

  void _startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (!_userSelectedNewTime) {
        _dateTimeController.add(DateTime.now());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          width: 370,
          height: 155,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(4, 4),
              ),
            ],
            color: Color.fromARGB(255, 189, 255, 180),
          ),
          child: Column(
            children: [
              SizedBox(height: 15),
              _buildTimeContainer(),
              SizedBox(height: 15),
              _buildScheduleContainer(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeContainer() {
    return Row(
      children: [
        SizedBox(width: 15),
        _buildTimeTextContainer(),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 100,
              height: 50,
              alignment: Alignment.topRight,
              child: _buildDayText(),
            ),
            Container(
              width: 180,
              height: 30,
              alignment: Alignment.bottomRight,
              child: _buildCountdown(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimeTextContainer() {
    return Container(
      width: 150,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent, width: 5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(4, 4),
          ),
        ],
        color: Color.fromARGB(255, 235, 255, 223),
      ),
      child: Center(
        child: Text(
          '${_formatTime(_selectedTime)}',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.Hm().format(dateTime);
  }

  Widget _buildDayText() {
    return Align(
      alignment: Alignment.topRight,
      child: StreamBuilder<DateTime>(
        stream: _dateTimeController.stream,
        builder: (context, snapshot) {
          final currentTime = snapshot.data ?? DateTime.now();
          return Text(
            '${_formatDay(DateFormat('EEEE').format(currentTime))}',
            style: TextStyle(fontSize: 18, color: Colors.black),
          );
        },
      ),
    );
  }

  String _formatDay(String englishDay) {
    switch (englishDay) {
      case 'Monday':
        return 'Senin';
      case 'Tuesday':
        return 'Selasa';
      case 'Wednesday':
        return 'Rabu';
      case 'Thursday':
        return 'Kamis';
      case 'Friday':
        return 'Jumat';
      case 'Saturday':
        return 'Sabtu';
      case 'Sunday':
        return 'Minggu';
      default:
        return englishDay;
    }
  }

  Widget _buildScheduleContainer() {
    return Container(
      width: 370,
      height: 45,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent, width: 5),
        color: Color(0xffb6f490),
      ),
      child: Row(
        children: [
          Text("  Jadwal Penyiraman Otomatis",
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 100),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => _selectTime(context),
          ),
        ],
      ),
    );
  }

  Widget _buildCountdown() {
    final now = DateTime.now();
    final scheduledDateTime = DateTime(now.year, now.month, now.day,
        _scheduledTime.hour, _scheduledTime.minute);
    final difference = scheduledDateTime.difference(now);

    return Text(
      'Akan mulai ${_formatDuration(difference)}',
      style: TextStyle(fontSize: 12, color: Colors.black),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;

    return '$hours jam $minutes menit lagi';
  }

  Future<void> _selectTime(BuildContext context) async {
    final time =
        await showTimePicker(context: context, initialTime: _selectedTime);
    if (time != null) {
      setState(() {
        _selectedTime = time;
        _userSelectedNewTime =
            false; // Reset to false when user selects new time
        _updateCountdown();
      });
    }
  }

  void _updateCountdown() {
    final now = DateTime.now();
    final scheduledDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );
    final difference = scheduledDateTime.difference(now);

    _dateTimeController
        .add(now.add(difference)); // Use scheduled time for countdown
  }
}
