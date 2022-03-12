import 'package:health_bloom/model/fedback_model.dart';

class FeedbackController {
  final feedback = [
    FeedbackModel(
        image: 'assets/icons/extremely-sad.png', text: 'Extremely Sad'),
    FeedbackModel(image: 'assets/icons/sad.png', text: 'Sad'),
    FeedbackModel(image: 'assets/icons/satisfied.png', text: 'Satisfied'),
    FeedbackModel(image: 'assets/icons/happy.png', text: 'Happy'),
    FeedbackModel(
        image: 'assets/icons/extremely-happy.png', text: 'Extremely Happy'),
  ];
}
