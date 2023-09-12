import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/styles.dart';
import 'package:flutter_front/common/utils/date_utils.dart';
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
      // TODO 토 일 색깔 바꾸기
      locale: 'ko_KR',
      daysOfWeekStyle: DaysOfWeekStyle(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.black.withOpacity(0.3),
            ),
          ),
        ),
        weekendStyle: kTextNormalStyleLarge,
        weekdayStyle: kTextNormalStyleLarge,
      ),
      headerStyle: HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        // TODO : TimeTable Header 디자인 변경
        titleTextStyle: kTextMainStyleLarge,
      ),
      rowHeight: widget.rowHeight,
      daysOfWeekHeight: widget.rowHeight,
      firstDay: controller.firstDay,
      lastDay: controller.lastDay,
      focusedDay: controller.focusedDay,
      onDaySelected: controller.onDaySelected,
      selectedDayPredicate: controller.selectedDayPredicate,
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, dateTime, _) {
          final date = getDayOfWeek(dateTime);
          if (date == "토요일") {
            return _cellBuilder(
              date: dateTime.day.toString(),
              textColor: Colors.blue,
            );
          }
          if (date == "일요일") {
            return _cellBuilder(
                date: dateTime.day.toString(), textColor: Colors.red);
          }
          return _cellBuilder(date: dateTime.day.toString());
        },
        outsideBuilder: (context, dateTime, _) => _cellBuilder(
          textColor: Colors.black.withOpacity(0.5),
          date: dateTime.day.toString(),
        ),

        // 오늘 날짜 셀의 빌더 함수
        todayBuilder: (context, dateTime, _) => _cellBuilder(
          color: CustomColor.textReverseColor,
          date: dateTime.day.toString(),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        // 선택된 날짜 셀의 빌더 함수
        selectedBuilder: (context, dateTime, _) => _cellBuilder(
          color: CustomColor.mainColor,
          date: dateTime.day.toString(),
          textColor: Colors.white,
        ),
      ),
      onPageChanged: controller.onPageChanged,
    );
  }

  Widget _cellBuilder({
    Color? color,
    required String date,
    Color? textColor,
    BoxBorder? border,
  }) =>
      Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          border: border,
        ),
        width: widget.rowHeight - 2,
        height: widget.rowHeight - 2,
        child: Center(
          child: Text(
            date,
            style: kTextMainStyleMiddle.copyWith(
              fontWeight: FontWeight.normal,
              color: textColor,
            ),
            softWrap: false,
          ),
        ),
      );
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

  void onPageChanged(DateTime dateTime) => onDaySelected(dateTime, dateTime);
}
