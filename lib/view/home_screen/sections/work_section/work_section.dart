import 'package:flutter/material.dart';
import 'package:flutter_personal_portfolio/data/work.dart';
import 'package:flutter_personal_portfolio/global_widgets/subtitle.dart';

import 'components/work_card.dart';

class WorkSection extends StatelessWidget {
  const WorkSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Subtitle(text: 'Experience'),
        ListView.separated(
          padding: const EdgeInsets.all(10),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var item = workList[index];
            return WorkCard(item: item);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: workList.length,
        ),
      ],
    );
  }
}
