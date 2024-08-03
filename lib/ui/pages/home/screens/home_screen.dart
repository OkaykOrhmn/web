// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/core/cubit/categories/categories_cubit.dart';
import 'package:web/core/cubit/product/product_cubit.dart';
import 'package:web/data/model/product_model.dart';
import 'package:web/ui/widgets/appbar/primary_appbar.dart';
import 'package:web/ui/widgets/image/primary_carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final images = [
    "https://images.thedirect.com/media/article_full/boyst.jpg",
    "https://lumiere-a.akamaihd.net/v1/images/deadpool_wolverine_mobile_640x480_ad8020fd.png",
    "https://blog.playstation.com/tachyon/2022/06/0c3c20a8d8514501524a0859461f391572ea6e61.jpg",
    "https://i.redd.it/8h7wb66ofn0a1.jpg"
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const PrimaryAppbar(),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24), color: Colors.white),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: Row(
            children: [
              const Icon(
                CupertinoIcons.search,
                color: Colors.blueAccent,
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle:
                        TextStyle(color: Colors.blueAccent.withOpacity(0.6)),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        PrimaryCarousel(
          images: images,
        ),
        const SizedBox(
          height: 8,
        ),
        categories(),
        const SizedBox(
          height: 24,
        ),
        BlocProvider<ProductCubit>(
          create: (context) {
            ProductCubit productCubit = ProductCubit();
            productCubit.getProductsList();
            return productCubit;
          },
          child: BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state is ProductSuccess) {
                final response = state.response;
                if (response.isEmpty) {
                  return const SizedBox();
                }
                return Column(
                  children: [
                    titleDivider(),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 240,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: response.length,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        shrinkWrap: true,
                        itemExtent: 160,
                        itemBuilder: (context, index) =>
                            productCard(product: response[index]),
                      ),
                    ),
                  ],
                );
              } else if (state is ProductLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        BlocProvider<ProductCubit>(
          create: (context) {
            ProductCubit productCubit = ProductCubit();
            productCubit.getProductsList();
            return productCubit;
          },
          child: BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state is ProductSuccess) {
                final response = state.response;
                if (response.isEmpty) {
                  return const SizedBox();
                }
                return Column(
                  children: [
                    titleDivider(),
                    const SizedBox(
                      height: 8,
                    ),
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 3 / 4),
                      itemCount: response.length,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          productCard(product: response[index]),
                    )
                  ],
                );
              } else if (state is ProductLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const SizedBox();
              }
            },
          ),
        )
      ]),
    );
  }

  Stack productCard({required final Product product}) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(24)),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: CachedNetworkImage(
                    imageUrl: product.mainImageUrl.toString()),
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name.toString()),
                    Text(product.price.toString()),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
            top: 8,
            right: 8,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(24),
                      bottomLeft: Radius.circular(12))),
              padding: const EdgeInsets.all(8),
              child: const Icon(
                CupertinoIcons.heart,
                color: Colors.white,
              ),
            ))
      ],
    );
  }

  Padding titleDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text("Special For You"), Text("See all")],
      ),
    );
  }

  Widget categories() {
    return BlocProvider<CategoriesCubit>(
      create: (context) {
        CategoriesCubit categoriesCubit = CategoriesCubit();
        categoriesCubit.getCategories();
        return categoriesCubit;
      },
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          if (state is CategoriesSuccess) {
            final response = state.response;
            if (response.isEmpty) {
              return const SizedBox();
            }
            return SizedBox(
              height: 90,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: response.length,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                itemBuilder: (context, index) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: index == 0 || index == 10 ? 0 : 8.0),
                      child: SizedBox(
                        width: 64,
                        height: 64,
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.blueAccent, width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: response[index].imageUrl.toString(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      response[index].name.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            );
          } else if (state is CategoriesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
