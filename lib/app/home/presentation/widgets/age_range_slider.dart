import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:triberly/app/base/presentation/pages/base/base_page.dart';
import 'package:triberly/app/home/presentation/widgets/filter_widget.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/generated/l10n.dart';

class CustomRangeSlider extends StatefulWidget {
  const CustomRangeSlider({super.key, this.start = 30.0, this.end = 50.0});
  final double start;
  final double end;

  @override
  State<CustomRangeSlider> createState() => _CustomRangeSliderState();
}

class _CustomRangeSliderState extends State<CustomRangeSlider> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _start = widget.start;
    _end = widget.end;
  }

  double _start = 0;
  double _end = 80;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        RangeSlider(
          activeColor: Pallets.primary,
          values: RangeValues(_start, _end),
          // labels: RangeLabels(
          //     "${_start.toInt()} Yrs", '${_end.toInt().toString()} Yrs'),
          onChanged: (value) {
            setState(() {
              _start = value.start;
              _end = value.end;
            });
          },
          min: 0.0,
          max: 100.0,
        ),
        Positioned(
          left: (_start * 3.1),
          top: -10,
          child: Text("${_start.toInt()} Yrs"),
        ),
        Positioned(
          top: -10,
          left: (_end * 3.1),
          child: Text("${_end.toInt()} Yrs"),
        ),
      ],
    );
  }
}
