import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'location_controller.dart';

class LocationPage extends ConsumerStatefulWidget {
  const LocationPage({super.key});


  @override
  ConsumerState createState() => _LocationPageState();
}

class _LocationPageState extends ConsumerState<LocationPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();

    @override
    void dispose() {
      // TODO: implement dispose
      super.dispose();
      dialogKey.currentState?.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar:  AppBar(),
      body:  Container(),
    );
  }
}
