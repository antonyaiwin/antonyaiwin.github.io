import 'package:flutter/material.dart';
import 'package:flutter_personal_portfolio/data/skills.dart';
import 'package:flutter_personal_portfolio/global_widgets/subtitle.dart';
import 'package:flutter_personal_portfolio/view/home_screen/sections/projects_section/components/project_card.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Subtitle(text: 'Skills'),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.spaceBetween,
          children: List.generate(
            skillList.length,
            (index) => ProjectSkillsWidget(
              text: skillList[index],
            ),
          ),
        ),
      ],
    );
  }
}
