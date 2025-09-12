import 'package:flutter_personal_portfolio/model/work_model.dart';

List<WorkModel> workList = [
  WorkModel(
    title: 'Flutter Developer',
    companyName: 'Brooklet Systems Pvt. Ltd',
    duration: 'Sep 2024 - Present',
    summary: '''
I develop and maintain cross-platform mobile applications using Flutter and Dart, ensuring smooth performance across Android and iOS. I work closely with designers and backend engineers to build responsive, user-friendly UIs that follow Material and Cupertino guidelines.

My role involves integrating Firebase services (Authentication, Firestore, Cloud Messaging, Storage) and REST APIs for secure and seamless data exchange. I also optimize app performance and state management with Riverpod, reducing UI latency and improving efficiency.

Beyond development, I contribute to release cycles for both Google Play Store and Apple App Store, handle debugging with Flutter DevTools, and collaborate with my team using Git and Bitbucket for version control.''',
  ),
  WorkModel(
    title: 'Flutter Developer (Intern)',
    companyName: 'Luminar TechnoHub',
    duration: 'Jun 2024 - Aug 2024',
    summary:
        'Developed cross-platform mobile applications using Flutter framework for iOS and Android platforms. Implement complex UI designs and animations using Flutter widgets and custom packages. Integrated RESTful APIs and third-party services to fetch and display data in the app. Utilized state management techniques like Provider, Bloc, and Getx for managing application state efficiently.',
  ),
];
