import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomTimeTable extends ConsumerStatefulWidget {
  late final ChangeNotifierProvider<CustomTimeTableController> provider;
  final double rowHeight;

  CustomTimeTable({
    Key? key,
    // controller를 만들어서 그걸로 모든 기능을 조작함
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
        decoration: BoxDecoration(
          color: CustomColor.disabledColor,
        ),
      ),
      rowHeight: widget.rowHeight,
      daysOfWeekHeight: widget.rowHeight,
      firstDay: controller.firstDay,
      lastDay: controller.lastDay,
      focusedDay: controller.focusedDay,
      onDaySelected: controller.onDaySelected,
      // 선택된 날짜와 현재 날짜가 동일한지 여부
      selectedDayPredicate: controller.selectedDayPredicate,
      // 셀들을 빌드하고 스타일링하는 데 사용되는 콜백 함수의 모음
      calendarBuilders: CalendarBuilders(
        // 기본 날짜 셀의 빌더 함수
        defaultBuilder: (context, dateTime, _) => _cellBuilder(
          date: dateTime.day.toString(),
        ),
        // 오늘 날짜 셀의 빌더 함수
        todayBuilder: (context, dateTime, _) => _cellBuilder(
          color: CustomColor.mainColor.withOpacity(0.3),
          date: dateTime.day.toString(),
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

  Widget _cellBuilder({Color? color, required String date, Color? textColor}) =>
      Container(
        color: color,
        width: widget.rowHeight - 2,
        height: widget.rowHeight - 2,
        child: Center(
          child: Text(
            date,
            style: kTextMainStyleSmall.copyWith(
              fontWeight: FontWeight.normal,
              color: textColor,
            ),
            // 텍스트 위젯 내에서 텍스트가 너무 길어서 화면의 가로 공간을 초과할 때 줄 바꿈을 어떻게 처리할지를 지정하는 속성
            softWrap: false,
          ),
        ),
      );
}

// viewmodel과 연결해서 사용
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
