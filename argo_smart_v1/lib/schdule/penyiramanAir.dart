import 'package:argo_smart_v1/schdule/pestisida.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class SiramAir extends StatefulWidget {
  const SiramAir({Key? key}) : super(key: key);

  @override
  _SiramAirState createState() => _SiramAirState();
}

class _SiramAirState extends State<SiramAir> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  TimeOfDay _scheduledTime = TimeOfDay(hour: 24, minute: 0);
  late StreamController<DateTime> _dateTimeController;
  final dbr = FirebaseDatabase.instance.reference();
  bool _userSelectedNewTime = false;
  bool _manualSiramActive = false;

  @override
  void initState() {
    super.initState();
    _dateTimeController = StreamController<DateTime>.broadcast();
    _loadSavedTime();
    _startTimer();
  }

  @override
  void dispose() {
    _dateTimeController.close();
    super.dispose();
  }

  void _startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (!_dateTimeController.isClosed) {
        if (!_userSelectedNewTime) {
          _dateTimeController.add(DateTime.now());
        }
      } else {
        timer.cancel(); // Cancel the timer if the controller is closed
      }
    });
  }

  Future<void> _loadSavedTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedHour = prefs.getInt('selectedHourAir') ?? _selectedTime.hour;
    final savedMinute =
        prefs.getInt('selectedMinuteAir') ?? _selectedTime.minute;

    setState(() {
      _selectedTime = TimeOfDay(hour: savedHour, minute: savedMinute);
      _updateCountdown();
    });
  }

  Future<void> _saveSelectedTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('selectedHourAir', _selectedTime.hour);
    prefs.setInt('selectedMinuteAir', _selectedTime.minute);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15),
        Container(
          width: 370,
          height: 155,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.25),
                spreadRadius: 4,
                blurRadius: 4,
                offset: Offset(4, 4),
              ),
            ],
            color: Color.fromARGB(255, 189, 255, 180),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xffddffc3), Color(0x00fbffcf)],
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 10),
              _buildTimeContainer(),
              SizedBox(height: 10),
              _buildScheduleContainer(),
            ],
          ),
        ),
        SizedBox(height: 15),
        SiramPestisida(),
        SizedBox(height: 150),
        _buildManualSiramButton(),
      ],
    );
  }

  Widget _buildTimeContainer() {
    return Row(
      children: [
        SizedBox(width: 10),
        _buildTimeTextContainer(),
        SizedBox(width: 5),
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
              width: 190,
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
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 3,
            blurRadius: 3,
            offset: Offset(4, 4),
          ),
        ],
        color: Color.fromARGB(255, 238, 253, 228),
      ),
      child: Center(
        child: Text(
          '${_formatTime(_selectedTime)}',
          style: TextStyle(
            fontSize: 40,
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
      height: 55,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent, width: 5),
        color: Color(0xffb6f490),
      ),
      child: Row(
        children: [
          Text(
            "  Jadwal Siram Air Otomatis",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(width: 95),
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
    final scheduledDateTime = DateTime(
        now.year, now.month, now.day, _selectedTime.hour, _selectedTime.minute);

    if (scheduledDateTime.isBefore(now)) {
      return Text(
        'Penyiraman telah dilakukan',
        style: TextStyle(fontSize: 12, color: Colors.black),
      );
    } else {
      final difference = scheduledDateTime.difference(now);
      return Text(
        'Akan dimulai ${_formatDuration(difference)}',
        style: TextStyle(fontSize: 12, color: Colors.black),
      );
    }
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
        _userSelectedNewTime = false;
        _updateCountdown();
        _saveSelectedTime();
      });
    }
  }

  void _updateCountdown() {
    final now = DateTime.now();
    final scheduledDateTime = DateTime(
        now.year, now.month, now.day, _selectedTime.hour, _selectedTime.minute);
    final difference = scheduledDateTime.difference(now);

    _dateTimeController.add(now.add(difference));
  }

  Widget _buildManualSiramButton() {
    return ElevatedButton(
      onPressed: () {
        dbr.child("switch").set({"boolean": !_manualSiramActive});
        setState(() {
          _manualSiramActive = !_manualSiramActive;
        });
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: Colors.grey,
        minimumSize: const Size(236, 60),
        backgroundColor: const Color(0xFF4F6F52),
      ),
      child: Text(
        _manualSiramActive ? 'Berhenti Siram' : 'Siram Sekarang',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
