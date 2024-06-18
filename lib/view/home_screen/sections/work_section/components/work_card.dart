import 'package:flutter/material.dart';
import 'package:flutter_personal_portfolio/core/constants/color_constants.dart';
import 'package:flutter_personal_portfolio/utils/screen_utils/responsive.dart';

import '../../../../../model/work_model.dart';

class WorkCard extends StatelessWidget {
  const WorkCard({
    super.key,
    required this.item,
  });

  final WorkModel item;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: isMobile(context) ? 1 : 2,
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: RotatedBox(
                quarterTurns: isMobile(context) ? 3 : 0,
                child: Text(
                  item.duration,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorConstants.textColor2,
                      ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.companyName,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: ColorConstants.primaryWhite,
                    ),
              ),
              Text(
                item.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: ColorConstants.textColor2,
                    ),
              ),
              Text(
                item.summary,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: ColorConstants.white54,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
