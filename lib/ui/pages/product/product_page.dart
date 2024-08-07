// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/core/bloc/cart/cart_bloc.dart';
import 'package:web/core/bloc/likes/likes_bloc.dart';
import 'package:web/core/bloc/product/product_bloc.dart';
import 'package:web/core/cubit/cart/edit_cart_cubit.dart';
import 'package:web/core/cubit/like/like_cubit.dart';
import 'package:web/data/model/product_model.dart';
import 'package:web/ui/widgets/loading/primary_loading.dart';
import 'package:web/ui/widgets/media/image/product_carousel.dart';

class ProductPage extends StatefulWidget {
  final int id;
  const ProductPage({super.key, required this.id});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    context.read<ProductBloc>().add(GetProduct(id: widget.id));
    super.initState();
  }

  ValueNotifier<int> count = ValueNotifier(1);

  late Product product;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<LikesBloc>().add(GetAllLikes());
        context.read<CartBloc>().add(GetAllCarts());
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductSuccess) {
                      product = state.response.product!;
                      final List<String> images = [
                        product.mainImageUrl.toString(),
                        ...product.banners!
                      ];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          header(images: images),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name.toString(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "\$${product.price}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black54),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 2),
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.circular(24)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min, // add this
                                    children: [
                                      const Icon(
                                        CupertinoIcons.star_fill,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        product.rate.toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 18,
                                ),
                                Text(
                                  product.description.toString(),
                                  textAlign: TextAlign.justify,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 90,
                          )
                        ],
                      );
                    } else if (state is ProductFail) {
                      return const SizedBox();
                    } else {
                      return const PrimaryLoading();
                    }
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                child: Stack(
                  children: [
                    Positioned(
                      left: 12,
                      right: 12,
                      bottom: 12,
                      child: Container(
                        constraints: const BoxConstraints(maxHeight: 72),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(46),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 1),
                                    borderRadius: BorderRadius.circular(24)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (count.value != 1) {
                                          count.value -= 1;
                                        }
                                      },
                                      child: const Icon(
                                        CupertinoIcons.minus,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    ),
                                    AnimatedBuilder(
                                      animation: count,
                                      builder: (context, child) => Text(
                                        "${count.value}",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        count.value += 1;
                                      },
                                      child: const Icon(
                                        CupertinoIcons.add,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: ElevatedButton(
                                    onPressed: () {
                                      // context
                                      //     .read<EditCartCubit>()
                                      //     .addCart(userId: 62, name: 'name');
                                      context.read<EditCartCubit>().putCart(
                                          cartId: 2,
                                          productId: product.id!,
                                          count: count.value);
                                    },
                                    child: const Text('Add to Cart')),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stack header({required final List<String> images}) {
    return Stack(
      children: [
        Column(
          children: [
            ProductCarousel(images: images),
            Container(
              color: const Color(0xffeef1f1),
              child: Container(
                height: 32,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32)),
                    color: Colors.white),
              ),
            )
          ],
        ),
        Positioned(
          top: 12,
          left: 12,
          right: 12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.blueAccent,
                    size: 18,
                  )),
              Row(
                children: [
                  IconButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.share_outlined,
                        color: Colors.blueAccent,
                        size: 18,
                      )),
                  BlocProvider<LikeCubit>(
                    create: (context) => LikeCubit(),
                    child: BlocBuilder<LikeCubit, LikeState>(
                        builder: (context, state) {
                      if (state is LikeSuccess) {
                        product.likes ?? [];
                        if (state.response) {
                          if (product.likes!.isEmpty) {
                            product.likes!.add(' ');
                          }
                        } else {
                          product.likes!.clear();
                        }
                      }

                      final like =
                          product.likes != null && product.likes!.isNotEmpty;

                      return IconButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),
                          onPressed: () {
                            context
                                .read<LikeCubit>()
                                .likeProduct(product.id!, !like);
                          },
                          icon: state is LikeLoading
                              ? const PrimaryLoading()
                              : Icon(
                                  like
                                      ? CupertinoIcons.heart_fill
                                      : CupertinoIcons.heart,
                                  color: Colors.blueAccent,
                                  size: 18,
                                ));
                    }),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
