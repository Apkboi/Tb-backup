import 'dart:async';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:triberly/core/constants/package_exports.dart';
import 'package:triberly/core/constants/pallets.dart';

import '../../external/datasources/audio_dao_imp_datasource.dart';

class WaveBubble extends StatefulWidget {
  final bool isSender;
  final int? index;
  final String audioUrl;
  final double? width;
  // final PlayerController controller;
  // final Directory appDirectory;

  const WaveBubble({
    Key? key,
    // required this.appDirectory,
    this.width,
    this.index,
    this.isSender = false,
    required this.audioUrl,
    // required this.controller,
  }) : super(key: key);

  @override
  State<WaveBubble> createState() => _WaveBubbleState();
}

class _WaveBubbleState extends State<WaveBubble> {
  File? file;

  late PlayerController controller;

  late StreamSubscription<PlayerState> playerStateSubscription;

  String? pathValue;
  PlayerWaveStyle playerWaveStyle = const PlayerWaveStyle(
    fixedWaveColor: Colors.white54,
    liveWaveColor: Colors.white,
    scrollScale: .5,
    scaleFactor: 200,
  );

  @override
  void initState() {
    super.initState();
    // getPath();

    playerWaveStyle = PlayerWaveStyle(
      fixedWaveColor: !widget.isSender ? Pallets.primary : Pallets.white,
      liveWaveColor:
          !widget.isSender ? Pallets.primaryDark : Pallets.borderGrey,
      scrollScale: .5,
      scaleFactor: 200,
    );
    controller = PlayerController();
    _preparePlayer();
    playerStateSubscription = controller.onPlayerStateChanged.listen((_) {
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(covariant WaveBubble oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    _preparePlayer();
  }

  void _preparePlayer() async {
    pathValue = await AudioDaoImpDatasource().getAudioFilePath(widget.audioUrl);

    // Future.delayed(Duration.zero, () {
    //   controller.extractWaveformData(
    //     path: pathValue ?? '',
    //     noOfSamples: playerWaveStyle.getSamplesForWidth(widget.width ?? 200),
    //   );
    // });

    controller.preparePlayer(
      path: pathValue ?? '',
      noOfSamples: playerWaveStyle.getSamplesForWidth(1.sw ?? 200),
      shouldExtractWaveform: true,
    );
    // Extracting waveform separately if index is odd.
  }

  @override
  void dispose() {
    playerStateSubscription.cancel();
    // controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(
          bottom: 6,
          right: widget.isSender ? 0 : 10,
          top: 6,
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomRight:
                widget.isSender ? Radius.circular(0) : Radius.circular(16),
            bottomLeft:
                widget.isSender ? Radius.circular(16) : Radius.circular(0),
          ),
          color: widget.isSender ? Pallets.primary : Pallets.white,
          boxShadow: [
            BoxShadow(
              color: Pallets.black.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!controller.playerState.isStopped)
              IconButton(
                onPressed: () async {
                  controller.playerState.isPlaying
                      ? await controller.pausePlayer()
                      : await controller.startPlayer(
                          finishMode: FinishMode.pause,
                        );
                },
                icon: Icon(
                  controller.playerState.isPlaying
                      ? Icons.stop
                      : Icons.play_arrow,
                ),
                color: !widget.isSender ? Pallets.primary : Pallets.white,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
            AudioFileWaveforms(
              key: ValueKey(widget.index),
              size: Size(.6.sw, 70),
              playerController: controller,
              waveformType: WaveformType.fitWidth,
              playerWaveStyle: playerWaveStyle,
            ),
            if (widget.isSender) const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
