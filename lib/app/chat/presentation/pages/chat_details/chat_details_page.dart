import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/auth/external/datasources/user_imp_dao.dart';
import 'package:triberly/app/chat/domain/models/dtos/message_model_dto.dart';
import 'package:triberly/app/chat/presentation/widgets/base_message_widget.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/services/image_manipulation/cloudinary_manager.dart';
import '../../widgets/_chat_widgets.dart';
import 'chat_details_controller.dart';
import 'dart:io';
import 'package:audio_waveforms/audio_waveforms.dart';

const String testSenderid = 'asdadsa-1233-sdas332-2sasd';
const String anotherSenderid = 'another-1233-sender-1234';

class ChatDetailsPage extends ConsumerStatefulWidget {
  const ChatDetailsPage({
    super.key,
    required this.chatId,
    this.userName,
    // required this.userId,
  });

  final String chatId;
  final String? userName;

  // final String? userId;

  @override
  ConsumerState createState() => _ChatDetailsPageState();
}

class _ChatDetailsPageState extends ConsumerState<ChatDetailsPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();

  final TextEditingController messageCtrl = TextEditingController();
  final ScrollController listViewScrollController = ScrollController();
  List<MessageModel> messagesList = [];

  late PlayerController playerController;

  ///Audio
  ///
  late RecorderController recorderController;

  final userDto = sl<UserImpDao>().user;

  String? path;

  // String? musicFile;
  ValueNotifier<bool> isRecording = ValueNotifier(false);
  bool isRecordingCompleted = false;
  bool isLoading = true;
  late Directory appDirectory;

  List<String> _uploadedFiles = [];

  @override
  void initState() {
    super.initState();
    messageCtrl.addListener(() {
      setState(() {});
    });

    playerController = PlayerController();
    getChats();
    _getDir();
    _initialiseControllers();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    dialogKey.currentState?.dispose();
    recorderController.dispose();

    messageCtrl.dispose();
    super.dispose();
  }

  getChats() {
    Future.delayed(Duration.zero, () {
      ref.read(chatDetailsProvider.notifier).caller(widget.chatId);
    });
  }

  void _getDir() async {
    appDirectory = await getApplicationDocumentsDirectory();
    path = "${appDirectory.path}.m4a";
    isLoading = false;
    setState(() {});
  }

  void _initialiseControllers() {
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 44100;
  }

  DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    logger.e(widget.chatId);
    return Scaffold(
      body: Scaffold(
        // key: scaffoldKey,
        resizeToAvoidBottomInset: true,
        appBar: ChatDetailsAppbar(
          name: widget.userName ?? '',
        ),
        body: Column(
          children: [
            const CustomDivider(),
            Consumer(
              builder: (context, ref, child) {
                if (ref.watch(chatDetailsProvider) is ChatDetailsLoading) {
                  return Expanded(child: CustomDialogs.getLoading(size: 50));
                }
                messagesList =
                    ref.watch(chatDetailsProvider.notifier).messagesList;

                messagesList = ref
                    .read(chatDetailsProvider.notifier)
                    .addDateSeparators(messagesList);

                if (messagesList.isEmpty) {
                  return const Expanded(
                      child: Center(
                          child: EmptyState(
                              imageUrl: '',
                              title: "No messages yet",
                              subtitle: "You messages will appear here")));
                }

                return Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: listViewScrollController,
                    itemCount: messagesList.length,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemBuilder: (context, index) {
                      List<MessageModel> normalList =
                          messagesList.reversed.toList();

                      MessageModel singleItem = normalList[index];

                      return BaseMessageWidget(index, singleItem: singleItem, chatId: widget.chatId,);
                    },
                  ),
                );
              },
            )
          ],
        ),
        bottomNavigationBar: ValueListenableBuilder(
          valueListenable: isRecording,
          builder: (context, value, child) {
            return ChatBottomActionsBar(
              messageCtrl: messageCtrl,
              isRecording: value,
              audioCtrl: recorderController,
              onSend: (messageCtrl.text.isEmpty) ? _startOrStopRecording : onSend,
              chatId: widget.chatId,
            );
          },
        ),
      ),
    );
  }

  void _startOrStopRecording() async {
    try {
      if (isRecording.value) {
        recorderController.reset();

        final path = await recorderController.stop(false);

        if (path != null) {
          isRecordingCompleted = true;
          logger.wtf(path);

          final data = MessageModel(
            message: null,
            type: 'audio',
            files: [path],
            senderId: userDto?.id.toString(),
            isMe: true,
            isLocal: false,
            repliedMessage:
                ref.read(chatDetailsProvider.notifier).replyingMessage,
            date: DateTime.now().toString(),
            timestamp: ServerValue.timestamp,
          );

          // dbRef.child("chat_messages")
          //     .child(widget.chatId)
          //     .push()
          //     .set(data.toMap())
          //     .then(
          //       (value) {},);
          debugPrint("Recorded file size: ${File(path).lengthSync()}");


          ref.read(chatDetailsProvider.notifier).addChat(data);

        }
      } else {
        await recorderController.record(path: path);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isRecordingCompleted = false;
      isRecording.value = !isRecording.value;

      // setState(() {
      // });
    }
  }

  onSend() {
    final data = MessageModel(
        message: messageCtrl.text,
        senderId: userDto?.id.toString(),
        isMe: true,
        isLocal: false,
        repliedMessage: ref.read(chatDetailsProvider.notifier).replyingMessage,
        date: DateTime.now().toString(),
        timestamp: ServerValue.timestamp,
        files: _uploadedFiles);

    if (data.message == '') {
      CustomDialogs.showToast('Add a text');

      return;
    }

    // dbRef
    //     .child("chat_messages")
    //     .child(widget.chatId)
    //     .push()
    //     .set(data.toMap())
    //     .then(
    //       (value) {},
    //     );
    ref.read(chatDetailsProvider.notifier).sendChatMessage(
          data,
          widget.chatId,
        );

    ///Clear textfield
    messageCtrl.clear();
    ref.read(chatDetailsProvider.notifier).replyingMessage = null;
  }
}
