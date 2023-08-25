import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final progressReservationViewModelProvider =
    ChangeNotifierProvider((ref) => ProgressReservationViewModel(ref));

class ProgressReservationViewModel extends ChangeNotifier {
  final Ref ref;
  ProgressReservationViewModel(this.ref);
}
