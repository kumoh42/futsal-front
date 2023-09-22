import 'package:flutter/material.dart';

class UserListView extends StatelessWidget {
  const UserListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: false,
      itemBuilder: (context, index) {
        return Text("zzzz");
      },
      itemCount: 100,
    );
  }
}
