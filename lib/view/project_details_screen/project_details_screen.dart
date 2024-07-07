import 'package:flutter/material.dart';
import 'package:flutter_personal_portfolio/model/project_model.dart';

class ProjectDetailsScreen extends StatelessWidget {
  const ProjectDetailsScreen({super.key, required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Overview'),
        centerTitle: true,
      ),
    );
  }
}
