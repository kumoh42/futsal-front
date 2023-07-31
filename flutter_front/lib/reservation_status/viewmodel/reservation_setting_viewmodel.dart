import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reservationSettingViewModelProvider =
    ChangeNotifierProvider((ref) => ReservationSettingViewModel(ref));

class ReservationSettingViewModel extends ChangeNotifier {
  final Ref ref;

  ReservationSettingViewModel(this.ref);
}
