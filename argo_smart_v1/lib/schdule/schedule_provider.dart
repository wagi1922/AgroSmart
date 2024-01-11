import 'package:flutter/foundation.dart';
import 'schedule.dart';
import 'package:provider/provider.dart';

class ScheduleProvider extends ChangeNotifier {
  List<Schedule> _schedules = [];

  List<Schedule> get schedules => _schedules;

  void addSchedule(Schedule schedule) {
    _schedules.add(schedule);
    notifyListeners();
  }

  void removeSchedule(Schedule schedule) {
    _schedules.remove(schedule);
    notifyListeners();
  }
}
