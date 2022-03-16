import 'package:health_bloom/model/fedback_model.dart';

class FeedbackController {
  final feedback = [
    FeedbackModel(
        pngImage: 'assets/icons/extremely-sad.png',
        jpgImage: 'assets/icons/extremely-sad.jpg',
        text: 'Extremely Sad'),
    FeedbackModel(
        pngImage: 'assets/icons/sad.png',
        jpgImage: 'assets/icons/sad.jpg',
        text: 'Sad'),
    FeedbackModel(
        pngImage: 'assets/icons/satisfied.png',
        jpgImage: 'assets/icons/satisfied.jpg',
        text: 'Satisfied'),
    FeedbackModel(
        pngImage: 'assets/icons/happy.png',
        jpgImage: 'assets/icons/happy.jpg',
        text: 'Happy'),
    FeedbackModel(
        pngImage: 'assets/icons/extremely-happy.png',
        jpgImage: 'assets/icons/extremely-happy.jpg',
        text: 'Extremely Happy'),
  ];
}
