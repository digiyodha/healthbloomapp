import 'package:health_bloom/model/walkthrough_model.dart';

class WalkthroughController {
  final walkthrough = [
    WalkthroughModel(
        image: 'assets/images/health-tracking.png',
        title: 'Health Tracking',
        description:
            'Track and get reminder of your water and medicine intake'),
    WalkthroughModel(
        image: 'assets/images/medical-report.png',
        title: 'Medical Reports',
        description: 'Add medical reports and bills, use them for future use'),
    WalkthroughModel(
        image: 'assets/images/nearby-store.png',
        title: 'Nearby Medical stores',
        description:
            'Search nearby medical stores and labs filtered according to opening hours, rating etc.'),
  ];
}
