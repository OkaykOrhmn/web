// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/core/bloc/product/product_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductSuccess) {
                    final product = state.response.product!;
                    final List<String> images = [
                      product.mainImageUrl.toString(),
                      ...product.banners!
                    ];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        header(images: images),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name.toString(),
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w900),
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
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Text(product.description.toString())
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
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: ElevatedButton(
                          onPressed: () {}, child: const Text('Add to Cart')),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
                  onPressed: () {},
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
                  IconButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.heart,
                        color: Colors.blueAccent,
                        size: 18,
                      )),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
