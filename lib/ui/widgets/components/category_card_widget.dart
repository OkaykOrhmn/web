import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:web/data/model/product_model.dart';

class CategoryCardWidget extends StatelessWidget {
  final Category category;
  final Color? color;
  const CategoryCardWidget({super.key, required this.category, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12,
                spreadRadius: 1,
                offset: const Offset(0.5, 0.5))
          ],
          borderRadius: BorderRadius.circular(12),
          color: color ?? const Color(0xffeef1f1)),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: category.imageUrl.toString(),
              ),
            ),
            Text(
              category.name.toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
