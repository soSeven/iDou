
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

abstract class FeedbackEvent {
  const FeedbackEvent();
}

class FeedbackEventUploadComplete extends FeedbackEvent {
  const FeedbackEventUploadComplete();
}

class FeedbackEventUploadImage extends FeedbackEvent {
  final PickedFile image;
  const FeedbackEventUploadImage({@required this.image});
}

class FeedbackEventUpload extends FeedbackEvent {
  final String content;
  final String pic;
  final String contact;
  const FeedbackEventUpload({@required this.content, this.pic, this.contact});
}
