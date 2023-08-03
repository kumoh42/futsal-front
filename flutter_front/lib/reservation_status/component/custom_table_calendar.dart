import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomTimeTable extends ConsumerStatefulWidget {
  late final ChangeNotifierProvider<CustomTimeTableController> provider;
  final double rowHeight;

  CustomTimeTable({
    Key? key,
    required CustomTimeTableController controller,
    required this.rowHeight,
  }) : super(key: key) {
    provider = ChangeNotifierProvider((ref) => controller);
  }

  @override
  ConsumerState<CustomTimeTable> createState() => _CustomTimeTableState();
}

class _CustomTimeTableState extends ConsumerState<CustomTimeTable> {
  late CustomTimeTableController controller;

  @override
  Widget build(BuildContext context) {
    controller = ref.watch(widget.provider);
    return TableCalendar(
      locale: 'ko_KR',
      headerStyle: const HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        // TODO : TimeTable Header 디자인 변경
        titleTextStyle: kTextMainStyleMiddle,
      ),
      rowHeight: widget.rowHeight,
      daysOfWeekHeight: widget.rowHeight,
      firstDay: controller.firstDay,
      lastDay: controller.lastDay,
      focusedDay: controller.focusedDay,
      onDaySelected: controller.onDaySelected,
      selectedDayPredicate: controller.selectedDayPredicate,
    );
  }
}

class CustomTimeTableController extends ChangeNotifier {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late final DateTime _firstDay;
  late final DateTime _lastDay;
  final Function()? onDayChange;

  DateTime get focusedDay => _focusedDay;

  DateTime get selectedDay => _focusedDay;

  DateTime get firstDay => _firstDay;

  DateTime get lastDay => _lastDay;

  CustomTimeTableController({
    DateTime? initDay,
    DateTime? firstDay,
    DateTime? lastDay,
    this.onDayChange,
  })  : _focusedDay = initDay ?? DateTime.now(),
        _selectedDay = initDay ?? DateTime.now(),
        _firstDay = firstDay ?? DateTime.utc(2010, 10, 16),
        _lastDay = lastDay ?? DateTime.utc(2030, 3, 14);

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    _focusedDay = selectedDay;
    _selectedDay = selectedDay;
    if (onDayChange != null) onDayChange!();
    notifyListeners();
  }

  bool selectedDayPredicate(DateTime? day) => isSameDay(_selectedDay, day);
}
