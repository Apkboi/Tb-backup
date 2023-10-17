class DetectFaceData {
  bool isBlurred;
  bool isFaceInFrame;
  bool isFaceUseful;

  DetectFaceData({
    this.isBlurred = true,
    this.isFaceInFrame = false,
    this.isFaceUseful = false,
  });

  bool get facePassed => ((isBlurred == false) &&
      (isFaceInFrame == true) &&
      (isFaceUseful == true));

  @override
  String toString() {
    return 'DetectFaceData{isBlurred: $isBlurred, isFaceInFrame: $isFaceInFrame, isFaceUseful: $isFaceUseful}';
  }
}
