import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:triberly/app/base/presentation/pages/base/base_page.dart';
import 'package:triberly/app/home/presentation/widgets/filter_widget.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/generated/l10n.dart';

class CustomRangeSlider extends StatefulWidget {
  const CustomRangeSlider(
      {super.key, this.start = 0.0, this.end = 100.0, this.onChanged});
  final double start;
  final double end;
  final void Function(RangeValues)? onChanged;

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
          values: RangeValues(widget.start, widget.end),
          // labels: RangeLabels(
          //     "${_start.toInt()} Yrs", '${_end.toInt().toString()} Yrs'),

          onChanged: widget.onChanged,
          // onChanged: (value) {
          //   setState(() {
          //     _start = value.start;
          //     _end = value.end;
          //   });
          // },
          min: 0.0,
          max: 100.0,
        ),
        Positioned(
          left: (widget.start * 3.1),
          top: -10,
          child: Text("${widget.start.toInt()} Yrs"),
        ),
        Positioned(
          top: -10,
          left: (widget.end * 3.1),
          child: Text("${widget.end.toInt()} Yrs"),
        ),
      ],
    );
  }
}
