import 'package:flutter/material.dart';
import 'package:triberly/core/_core.dart';

import '../../../auth/domain/models/dtos/user_dto.dart';
import '_home_widgets.dart';

class NewTribersRow extends StatelessWidget {
  const NewTribersRow({
    super.key,
    required this.users,
  });

  final List<UserDto> users;

  @override
  Widget build(BuildContext context) {
    return users.isEmpty ? const EmptyState(
      imageUrl: '', title: "No trybers match your filter",subtitle: "Update your filters to see more trybers.",) :SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          users
              .take(4)
              .length,
              (index) =>
              NewTribersBox(
                userDto: users[index],
                id: users[index].id.toString(),
                image: users[index].profileImage,
                name: "${users[index].lastName} ${users[index].firstName}",
                distance: ((index + 1) * 14.23).toStringAsFixed(2),
              ),
        ),
      ),
    );
  }
}
