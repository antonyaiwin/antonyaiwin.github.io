import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_personal_portfolio/data/projects.dart';
import 'package:flutter_personal_portfolio/global_widgets/subtitle.dart';
import 'package:flutter_personal_portfolio/utils/screen_utils/responsive.dart';

import 'components/project_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Subtitle(text: 'Projects'),
        const SizedBox(height: 20),
        GridView.builder(
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 600,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: isMobile(context) ? 10 / 12 : 10 / 11,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var item = projectList[index];
            return ProjectCard(item: item);
          },
          itemCount: projectList.length,
        ),
      ],
    );
  }
}
