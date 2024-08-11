import 'package:carousel_slider/carousel_slider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_personal_portfolio/core/constants/color_constants.dart';
import 'package:flutter_personal_portfolio/extensions/widget.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../global_widgets/elevated_container.dart';
import '../../../../../model/project_model.dart';
import 'project_carousel_widget.dart';

class ProjectCard extends StatelessWidget {
  ProjectCard({
    super.key,
    required this.item,
  });
  final ProjectModel item;
  final CarouselController carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _ProjectCarouselController(),
      builder: (context, child) => ElevatedContainer(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              // child: ParallaxImage(
              //   key: GlobalKey(),
              //   scrollController:
              //       context.read<HomeScreenController>().scrollController,
              // ),
              child: Stack(
                children: [
                  CarouselSlider.builder(
                    carouselController: carouselController,
                    itemCount: item.images.length,
                    itemBuilder: (context, index, realIndex) {
                      var carouselItem = item.images[index];
                      return ProjectCarouselWidget(
                        item: carouselItem,
                        isOdd: index % 2 != 0,
                      );
                    },
                    options: CarouselOptions(
                      aspectRatio: 10 / 8,
                      enlargeCenterPage: false,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        context
                            .read<_ProjectCarouselController>()
                            .onIndexChange(index);
                      },
                      // autoPlay: true,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              onPressed: () {
                                carouselController.previousPage(
                                  duration: const Duration(milliseconds: 800),
                                  curve: Curves.fastOutSlowIn,
                                );
                              },
                              icon: const Icon(EvaIcons.arrowCircleLeft),
                            ).hoverElastic,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Center(
                            child: Consumer<_ProjectCarouselController>(
                              builder: (BuildContext context,
                                      _ProjectCarouselController value,
                                      Widget? child) =>
                                  AnimatedSmoothIndicator(
                                activeIndex: value.currentIndex,
                                count: item.images.length,
                                effect: const ExpandingDotsEffect(
                                  activeDotColor: ColorConstants.secondaryGreen,
                                  dotHeight: 5,
                                  dotWidth: 5,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: () {
                                carouselController.nextPage(
                                  duration: const Duration(milliseconds: 800),
                                  curve: Curves.fastOutSlowIn,
                                );
                              },
                              icon: const Icon(EvaIcons.arrowCircleRight),
                            ).hoverElastic,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                item.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: ColorConstants.primaryWhite,
                    ),
                maxLines: 2,
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: item.skills
                      .map(
                        (e) => ProjectSkillsWidget(
                          text: e,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Flexible(
                //   child: FittedBox(
                //     fit: BoxFit.scaleDown,
                //     child: ElevatedButton(
                //       onPressed: () {
                //         launchUrl(Uri.parse(item.liveLink!));
                //       },
                //       child: const Text('VIEW DETAILS'),
                //     ),
                //   ),
                // ),

                if (item.gitLink != null)
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          launchUrl(Uri.parse(item.gitLink!));
                        },
                        icon: const Icon(EvaIcons.githubOutline),
                        label: const Text('View on GitHub'),
                      ).hoverElastic,
                    ),
                  ),
                if (item.gitLink != null && item.liveLink != null)
                  const SizedBox(width: 10),
                if (item.liveLink != null)
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          launchUrl(Uri.parse(item.liveLink!));
                        },
                        icon: const Icon(EvaIcons.globe2Outline),
                        label: const Text('View Live Demo'),
                      ).hoverElastic,
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ProjectSkillsWidget extends StatelessWidget {
  const ProjectSkillsWidget({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: ColorConstants.navyShadow,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: ColorConstants.white60,
            ),
      ),
    );
  }
}

class _ProjectCarouselController extends ChangeNotifier {
  int currentIndex = 0;
  onIndexChange(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
