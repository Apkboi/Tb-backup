import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/auth/domain/models/dtos/config_res_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/countries_res_dto.dart';
import 'package:triberly/app/profile/domain/models/dtos/search_connections_req_dto.dart';
import 'package:triberly/app/profile/presentation/pages/setup_profile/setup_profile_controller.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/shared/custom_type_drop_down_search.dart';

import '../pages/home/home_controller.dart';
import '_home_widgets.dart';

class FilterWidget extends ConsumerStatefulWidget {
  const FilterWidget({super.key});

  @override
  ConsumerState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends ConsumerState<FilterWidget> {
  final TextEditingController faithCtrl = TextEditingController();

  _clearAll(WidgetRef ref) {
    ref.read(homeProvider.notifier).clearFilter();

    context.pop();
  }

  String? connectWith;
  String? intent = '';
  num _start = 0;
  num _end = 80;
  num? _residenceCountryId;
  num? _originalCountry;
  num? _tribeId;
  num? _languagesID;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero, () {
      final filterData = ref.watch(homeProvider.notifier).filterData;
      connectWith = filterData.connectWith?.capitalize ?? '';
      _start = filterData.fromAge ?? 0;
      _end = filterData.toAge ?? 80;
      intent = filterData.intent?.capitalizeFirst;

      _residenceCountryId = filterData.residenceCountryId;
      _originalCountry = filterData.originCountryId;
      _tribeId = num.tryParse(filterData.tribes ?? '');
      _languagesID = num.tryParse(filterData.languagues ?? '');

      faithCtrl.text = filterData.faith ?? '';
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // logger.e(connectWith);
    return Consumer(
      builder: (context, ref, child) {
        // final filterData = ref.watch(homeProvider.notifier).filterData;
        // // connectWith = filterData.connectWith ?? '';
        // // _start = filterData.fromAge ?? 0;
        // // _end = filterData.toAge ?? 80;

        // _currentCountry = filterData.residenceCountryId ?? '';
        // _originalCountry;

        return Container(
          height: .94.sh,
          decoration: BoxDecoration(
            color: Pallets.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(15),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(child: Consumer(
            builder: (context, ref, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => context.pop(),
                        child: Container(
                          width: 30.dg,
                          height: 30.dg,
                          decoration: BoxDecoration(
                            color: Pallets.primaryLight,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            CupertinoIcons.xmark,
                            size: 14,
                          ),
                        ),
                      ),
                      TextView(
                        text: 'Filters',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          return TextView(
                            text: 'Clear',
                            fontSize: 12,
                            color: Pallets.primary,
                            fontWeight: FontWeight.w400,
                            onTap: () {
                              _clearAll(ref);
                            },
                          );
                        },
                      )
                    ],
                  ),
                  33.verticalSpace,
                  TextView(
                    text: 'Age',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  16.verticalSpace,
                  CustomRangeSlider(
                    start: _start.toDouble(),
                    end: _end.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        _start = value.start;
                        _end = value.end;
                      });
                    },
                  ),
                  32.verticalSpace,
                  CustomTypeDropDownSearch<CountriesData>(
                    hintText: 'Current location',
                    selectedItem:
                        ref.read(countryByIdProvider(_residenceCountryId)),
                    itemAsString: (CountriesData? data) {
                      return data?.name ?? '';
                    },
                    listItems:
                        ref.watch(setupProfileProvider.notifier).countries,
                    onTap: (value) {
                      _residenceCountryId = value?.id;
                    },
                  ),
                  24.verticalSpace,
                  CustomTypeDropDownSearch<CountriesData>(
                    hintText: 'Original country',
                    selectedItem:
                        ref.read(countryByIdProvider(_originalCountry)),
                    itemAsString: (data) {
                      return data?.name ?? '';
                    },
                    listItems:
                        ref.watch(setupProfileProvider.notifier).countries,
                    onTap: (value) {
                      _originalCountry = value?.id;
                    },
                  ),
                  24.verticalSpace,
                  CustomTypeDropDownSearch<Tribes>(
                    hintText: 'Tribe',
                    itemAsString: (data) {
                      return data?.name ?? '';
                    },
                    selectedItem: ref.read(tribeByIdProvider(_tribeId)),
                    listItems: ref.watch(setupProfileProvider.notifier).tribes,
                    onTap: (value) {
                      _tribeId = value?.id;
                    },
                  ),
                  24.verticalSpace,
                  CustomTypeDropDownSearch<Languages>(
                    hintText: 'Languages',
                    itemAsString: (data) {
                      return data?.name ?? '';
                    },
                    selectedItem: ref.read(languageByIdProvider(_languagesID)),
                    listItems:
                        ref.watch(setupProfileProvider.notifier).languages,
                    onTap: (value) {
                      _languagesID = value?.id;
                    },
                  ),
                  24.verticalSpace,

                  TextBoxField(
                    hintText: 'Faith',
                    label: 'Faith',
                    controller: faithCtrl,
                  ),
                  // 24.verticalSpace,

                  // 24.verticalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView(
                        text: 'Looking to connect with',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      18.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ConnectTypeRadio(
                            title: 'Men Only',
                            value: connectWith,
                            onTap: () {
                              connectWith = 'Men Only';
                              setState(() {});
                            },
                          ),
                          ConnectTypeRadio(
                            title: 'Women Only',
                            value: connectWith,
                            onTap: () {
                              connectWith = 'Women Only';
                              setState(() {});
                            },
                          ),
                          ConnectTypeRadio(
                            title: 'Anyone',
                            value: connectWith,
                            onTap: () {
                              connectWith = 'Anyone';

                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  24.verticalSpace,
                  FilterCustomDropDown(
                    hintText: 'Intent',
                    selectedValue: intent,
                    listItems: ['Friendship', 'Relationship'],
                    onTap: (value) {
                      intent = value;
                    },
                  ),
                  37.verticalSpace,
                  Consumer(
                    builder: (context, ref, child) {
                      return ButtonWidget(
                        title: 'Done',
                        onTap: () {
                          ref
                              .read(homeProvider.notifier)
                              .setfilterData(SearchConnectionsReqDto(
                                intent: intent?.toLowerCase(),
                                connectWith: connectWith?.toLowerCase(),
                                languagues: _languagesID.toString(),
                                tribes: _tribeId.toString(),
                                originCountryId: _originalCountry,
                                residenceCountryId: _residenceCountryId,
                                fromAge: _start,
                                toAge: _end,
                                faith: faithCtrl.text,
                                // withLatLong: data.withLatLong,
                              ));

                          logger.e(
                              ref.read(homeProvider.notifier).filterData.faith);

                          ///
                          ref.read(homeProvider.notifier).caller(
                              ref.read(homeProvider.notifier).filterData);

                          context.pop();
                        },
                      );
                    },
                  ),
                  100.verticalSpace,
                ],
              );
            },
          )),
        );
      },
    );
  }
}
