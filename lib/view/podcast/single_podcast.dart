// ignore_for_file: unnecessary_null_comparison

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tec/component/decorations.dart';
import 'package:tec/component/dimens.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/controller/podcast/single_podcast_controller.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/models/podcast_model.dart';

class PodcastSingle extends StatelessWidget {
  late SinglePodcastController controller;
  late PodcastModel podcastModel;
  PodcastSingle({super.key}) {
    podcastModel = Get.arguments;
    controller = Get.put(SinglePodcastController(id: podcastModel.id));
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(controller.id);
    var textThem = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: Get.height / 3,
                          width: double.infinity,
                          child: CachedNetworkImage(
                            imageUrl: podcastModel.poster!,
                            imageBuilder:
                                (context, imageProvider) => Image(
                                  image: imageProvider,
                                  fit: BoxFit.fill,
                                ),
                            placeholder: (context, url) => const loading(),
                            errorWidget:
                                (context, url, error) =>
                                    Image.asset(Assets.images.posterTest.path),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          left: 0,
                          child: Container(
                            height: 60,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                end: Alignment.bottomCenter,
                                begin: Alignment.topCenter,
                                colors: GradiantColors.singleAppbarGradiant,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const SizedBox(width: 20),
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                const Expanded(child: SizedBox()),

                                const SizedBox(width: 20),
                                const Icon(
                                  Icons.share,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(width: 20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          podcastModel.title!,
                          maxLines: 2,
                          style: textThem.titleLarge,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image(
                            image: Image.asset(Assets.images.avatar.path).image,
                            height: 50,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            podcastModel.author!,
                            style: textThem.headlineLarge,
                          ),
                          const SizedBox(width: 16),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(
                        () => ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.podcastFileList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                await controller.player.seek(
                                  Duration.zero,
                                  index: index,
                                );
                                controller.currentFileIndex.value =
                                    controller.player.currentIndex!;
                                    controller.timerCheck();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        ImageIcon(
                                          Image.asset(
                                            Assets.icons.microphone.path,
                                          ).image,
                                          color: SolidColors.seemore,
                                        ),
                                        const SizedBox(width: 8),
                                        SizedBox(
                                          width: Get.width / 1.5,
                                          child: Obx(
                                            () => Text(
                                              controller
                                                  .podcastFileList[index]
                                                  .title!,
                                              style:
                                                  controller
                                                              .currentFileIndex
                                                              .value ==
                                                          index
                                                      ? textThem.displaySmall
                                                      : textThem.headlineLarge,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '${controller.podcastFileList[index].lenght!}:00',
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              left: Dimens.bodyMargin,
              right: Dimens.bodyMargin,
              child: Container(
                height: Get.height / 7,
                decoration: MyDecorations.mainGradiant,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Obx(
                        () => ProgressBar(
                          timeLabelTextStyle: const TextStyle(color: Colors.white),
                          thumbColor: Colors.yellow,
                          baseBarColor: Colors.white,
                          progressBarColor: Colors.orange,
                          buffered: controller.bufferedValue.value,
                          progress: controller.progressValue.value,
                          total:
                              controller.player.duration ??
                              const Duration(seconds: 0),
                          onSeek: (posetion) async {
                            controller.player.seek(posetion);
                            if (controller.player.playing) {
                             controller.startProgress();  
                              
                            } else if(posetion<=const Duration(seconds: 0)) {
                              await controller.player.seekToNext();
                              controller.currentFileIndex.value=controller.player.currentIndex!;
                              controller.timerCheck();

                            }
                            
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await controller.player.seekToNext();
                              controller.currentFileIndex.value =
                                  controller.player.currentIndex!;
                                  controller.timerCheck();
                            },
                            child: const Icon(
                              Icons.skip_next,
                              color: Colors.white,
                              size: 38,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.player.playing
                                  ? controller.timer!.cancel()
                                  : controller.startProgress();

                              controller.player.playing
                                  ? controller.player.pause()
                                  : controller.player.play();
                              controller.playState.value =
                                  controller.player.playing;
                              controller.currentFileIndex.value =
                                  controller.player.currentIndex!;
                            },
                            child: Obx(
                              () => Icon(
                                controller.playState.value
                                    ? Icons.pause_circle_filled
                                    : Icons.play_circle_fill,
                                color: Colors.white,
                                size: 48,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await controller.player.seekToPrevious();
                              controller.currentFileIndex.value =
                                  controller.player.currentIndex!;
                                  controller.timerCheck();
                            },
                            child: const Icon(
                              Icons.skip_previous,
                              color: Colors.white,
                              size: 38,
                            ),
                          ),
                          const SizedBox(),
                          Obx(
                            () => GestureDetector(
                              onTap: () {
                                controller.setLoopMode();
                              },
                              child: Icon(
                                Icons.repeat,
                                color:
                                    controller.isLoopAll.value
                                        ? Colors.blue
                                        : Colors.white,
                                size: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
