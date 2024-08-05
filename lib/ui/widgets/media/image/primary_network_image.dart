import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:web/ui/widgets/components/default_place_holder.dart';
import 'package:web/ui/widgets/loading/primary_loading.dart';

class PrimaryNetworkImage extends StatelessWidget {
  const PrimaryNetworkImage({
    super.key,
    required this.image,
    this.borderRadius = BorderRadius.zero,
    this.boxFit,
    this.placeHolder = true,
  });

  final String image;
  final BorderRadiusGeometry borderRadius;
  final BoxFit? boxFit;
  final bool placeHolder;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: CachedNetworkImage(
          imageUrl: image,
          fit: boxFit,
          errorWidget: (context, url, error) {
            return const Icon(Icons.error);
          },
          placeholder: (context, url) => placeHolder
              ? DefaultPlaceHolder(
                  child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                ))
              : const Center(
                  child: PrimaryLoading(),
                )),
    );
  }
}
