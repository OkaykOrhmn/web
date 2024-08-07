import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/core/cubit/categories/categories_cubit.dart';
import 'package:web/ui/widgets/components/category_card_widget.dart';
import 'package:web/ui/widgets/loading/primary_loading.dart';
import 'package:web/ui/widgets/media/image/primary_network_image.dart';

class DialogHandler {
  final BuildContext context;

  DialogHandler(this.context);

  Future<void> showLoadingDialog() async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const PrimaryLoading());
  }

  Future<void> showExitDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to exit an App?'),
        actions: [
          InkWell(
            onTap: () => Navigator.of(context).pop(false),
            child: const Text(
              'No',
              style: TextStyle(color: Colors.blueAccent),
            ),
          ),
          const SizedBox(
            width: 24,
          ),
          InkWell(
            onTap: () => Navigator.of(context).pop(true),
            child:
                const Text('Yes', style: TextStyle(color: Colors.blueAccent)),
          ),
        ],
      ),
    );
  }

  Future<void> showCategoriesBottomSheet(
      {int? categoryId, required final Function(int) click}) async {
    await showModalBottomSheet(
        context: context,
        useSafeArea: true,
        backgroundColor: Colors.white,
        builder: (context) {
          return BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesSuccess) {
                final response = state.response;
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 46),
                  height: 120,
                  child: ListView.builder(
                    itemCount: response.length,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemExtent: 120,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          click(response[index].id!);
                        },
                        child: CategoryCardWidget(
                          category: response[index],
                          color: response[index].id == categoryId
                              ? Colors.blueAccent.withOpacity(0.5)
                              : null,
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return const PrimaryLoading();
              }
            },
          );
        });
  }

  Future<void> showImageDialog(String src) async {
    final transformationController = TransformationController();
    TapDownDetails doubleTapDetails = TapDownDetails();
    await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {},
                    onDoubleTapDown: (d) => doubleTapDetails = d,
                    onDoubleTap: () {
                      if (transformationController.value !=
                          Matrix4.identity()) {
                        transformationController.value = Matrix4.identity();
                      } else {
                        final position = doubleTapDetails.localPosition;
                        // For a 3x zoom
                        transformationController.value = Matrix4.identity()
                          // ..translate(-position.dx * 2, -position.dy * 2)
                          // ..scale(3.0);

                          // Fox a 2x zoom
                          ..translate(-position.dx * 1.5, -position.dy * 1.5)
                          ..scale(2.5);
                      }
                    },
                    child: InteractiveViewer(
                      panEnabled: true, // Set it to false to prevent panning.
                      minScale: 0.5,
                      maxScale: 4,
                      transformationController: transformationController,
                      child: Center(
                        child: Stack(
                          children: [
                            PrimaryNetworkImage(
                              image: src,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 24,
                      right: 24,
                      child: InkWell(
                          onTap: () => Navigator.of(context).pop(true),
                          child: const Icon(
                            CupertinoIcons.xmark_circle_fill,
                            color: Colors.blueAccent,
                            size: 24,
                          )))
                ],
              )),
        ),
      ),
    );
  }
}
