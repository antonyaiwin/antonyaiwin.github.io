import 'package:flutter/material.dart';
import 'package:flutter_personal_portfolio/core/constants/color_constants.dart';

import '../../../../../model/carousel_model.dart';

class ProjectCarouselWidget extends StatelessWidget {
  const ProjectCarouselWidget({
    super.key,
    required this.item,
    required this.isOdd,
  });

  final CarouselModel item;
  final bool isOdd;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ColorConstants.navyShadow,
      ),
      child: Row(
        children: [
          if (isOdd) _ProjectCarouselNameColumn(item: item),
          _ProjectCarouselImage(item: item),
          if (!isOdd) _ProjectCarouselNameColumn(item: item),
        ],
      ),
    );
  }
}

class _ProjectCarouselImage extends StatelessWidget {
  const _ProjectCarouselImage({
    required this.item,
  });

  final CarouselModel item;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      item.image,
      fit: BoxFit.cover,
    );
  }
}

class _ProjectCarouselNameColumn extends StatelessWidget {
  const _ProjectCarouselNameColumn({
    required this.item,
  });

  final CarouselModel item;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (item.title.isNotEmpty)
              Text(
                item.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: ColorConstants.primaryWhite,
                    ),
                textAlign: TextAlign.center,
              ),
            Text(
              item.subtitle,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: ColorConstants.white70,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
