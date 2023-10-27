import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:triberly/app/base/presentation/pages/base/base_page.dart';
import 'package:triberly/app/home/presentation/widgets/filter_widget.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/generated/l10n.dart';

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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          users.take(4).length,
          (index) => NewTribersBox(
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
