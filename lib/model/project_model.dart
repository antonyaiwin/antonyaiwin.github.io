import 'package:flutter_personal_portfolio/model/carousel_model.dart';

class ProjectModel {
  final String title;
  final String subtitle;
  final String summary;
  final List<CarouselModel> images;
  final List<String> skills;

  ProjectModel({
    required this.title,
    required this.subtitle,
    required this.summary,
    required this.images,
    required this.skills,
  });
}
