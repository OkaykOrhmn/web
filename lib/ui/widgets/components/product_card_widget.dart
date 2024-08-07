import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/core/bloc/product/product_bloc.dart';
import 'package:web/data/model/product_model.dart';
import 'package:web/ui/pages/product/product_page.dart';
import 'package:web/ui/widgets/media/image/primary_network_image.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () => Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) => BlocProvider<ProductBloc>(
              create: (context) => ProductBloc(),
              child: ProductPage(id: product.id!),
            ),
          )),
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
                color: const Color(0xffeef1f1),
                borderRadius: BorderRadius.circular(24)),
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 2,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PrimaryNetworkImage(
                        image: product.mainImageUrl.toString(),
                        boxFit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      Text(
                        product.name.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(product.price.toString()),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        // Positioned(
        //     top: 8,
        //     right: 8,
        //     child: Container(
        //       decoration: const BoxDecoration(
        //           color: Colors.blueAccent,
        //           borderRadius: BorderRadius.only(
        //               topRight: Radius.circular(24),
        //               bottomLeft: Radius.circular(12))),
        //       padding: const EdgeInsets.all(8),
        //       child: Icon(
        //         product.likes != null && product.likes!.isNotEmpty
        //             ? CupertinoIcons.heart_fill
        //             : CupertinoIcons.heart,
        //         color: const Color(0xffeef1f1),
        //         size: 18,
        //       ),
        //     ))
        Positioned(
            top: 8,
            right: 8,
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        bottomLeft: Radius.circular(12))),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2)
                    .copyWith(left: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      product.rate.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 2.0),
                      child: Icon(
                        CupertinoIcons.star_fill,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ],
                )))
      ],
    );
  }
}
