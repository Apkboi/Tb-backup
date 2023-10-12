import 'dart:async';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:triberly/core/constants/package_exports.dart';

import '../../external/datasources/audio_dao_imp_datasource.dart';

class WaveBubble extends StatefulWidget {
  final bool isSender;
  final int? index;
  final String audioUrl;
  final double? width;
  // final Directory appDirectory;

  const WaveBubble({
    Key? key,
    // required this.appDirectory,
    this.width,
    this.index,
    this.isSender = false,
    required this.audioUrl,
  }) : super(key: key);

  @override
  State<WaveBubble> createState() => _WaveBubbleState();
}

class _WaveBubbleState extends State<WaveBubble> {
  File? file;

  late PlayerController controller;
  late StreamSubscription<PlayerState> playerStateSubscription;

  String? pathValue;
  final playerWaveStyle = const PlayerWaveStyle(
    fixedWaveColor: Colors.white54,
    liveWaveColor: Colors.white,
    scrollScale: .5,
    scaleFactor: 200,
  );

  @override
  void initState() {
    super.initState();
    controller = PlayerController();
    // getPath();

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
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return pathValue != null
        ? Align(
            alignment:
                widget.isSender ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(
                bottom: 6,
                right: widget.isSender ? 0 : 10,
                top: 6,
              ),
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: widget.isSender
                    ? const Color(0xFF276bfd)
                    : const Color(0xFF343145),
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
                      color: Colors.white,
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
          )
        : const SizedBox.shrink();
  }
}
