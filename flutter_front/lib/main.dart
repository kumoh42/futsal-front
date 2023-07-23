import 'package:flutter/material.dart';
import 'package:flutter_front/common/go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = ref.watch(routerProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false, // 디버그 표시 지우기
      title: 'Flutter Demo',
      routerConfig: route,
    );
  }
}
