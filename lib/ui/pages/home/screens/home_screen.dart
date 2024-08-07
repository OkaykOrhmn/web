// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/core/cubit/categories/categories_cubit.dart';
import 'package:web/core/cubit/products/Products_state.dart';
import 'package:web/core/cubit/products/products_cubit.dart';
import 'package:web/data/model/filters_model.dart';
import 'package:web/data/model/product_model.dart';
import 'package:web/main.dart';
import 'package:web/ui/pages/product/products_list_page.dart';
import 'package:web/ui/widgets/components/default_place_holder.dart';
import 'package:web/ui/widgets/components/product_card_widget.dart';
import 'package:web/ui/widgets/components/title_divider.dart';
import 'package:web/ui/widgets/sectiones/appbar/primary_appbar.dart';
import 'package:web/ui/widgets/media/image/primary_carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final images = [
    // "https://images.thedirect.com/media/article_full/boyst.jpg",
    // "https://lumiere-a.akamaihd.net/v1/images/deadpool_wolverine_mobile_640x480_ad8020fd.png",
    // "https://blog.playstation.com/tachyon/2022/06/0c3c20a8d8514501524a0859461f391572ea6e61.jpg",
    // "https://i.redd.it/8h7wb66ofn0a1.jpg",
    "https://www.apple.com/v/iphone/home/bv/images/meta/iphone__ky2k6x5u6vue_og.png",
    "https://image.coolblue.nl/624x351/content/3825293fe8cdd871ced381088c762d44",
    "https://cdn.mos.cms.futurecdn.net/fsDKHB3ZyNJK6zMpDDBenB-1200-80.jpg",
    "https://media.product.which.co.uk/prod/images/ar_2to1_1500x750/22a475e555d7-best-laptop-deals.jpg",

    // "https://dkstatics-public.digikala.com/digikala-adservice-banners/8878cc02e2fc387319cda5b4fa1610cb0842fb4c_1722242016.jpg?x-oss-process=image/quality,q_95/format,webp",
    // "https://dkstatics-public.digikala.com/digikala-adservice-banners/1e3ced747d8cf62c297f95c0d94ef9d13732048f_1718696318.jpg?x-oss-process=image/quality,q_95/format,webp",
    // "https://dkstatics-public.digikala.com/digikala-adservice-banners/71f867b90d6dca65405a4252159f7b9c5b7cd8b6_1722415413.jpg?x-oss-process=image/quality,q_95/format,webp",
    // "https://dkstatics-public.digikala.com/digikala-adservice-banners/24e93720f9f253d833b5131b9241ee6d8f979ca5_1722662924.jpg?x-oss-process=image/quality,q_95/format,webp",
    // "https://dkstatics-public.digikala.com/digikala-adservice-banners/9e47e65e4ad4d052bf5b9a1bea6141c5de2fd8c4_1722675061.jpg?x-oss-process=image/quality,q_95/format,webp",
  ];

  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 12,
        ),
        const PrimaryAppbar(),
        searchBar(),
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
        specialForYou(),
        const SizedBox(
          height: 24,
        ),
        newest(),
        const SizedBox(
          height: 12,
        ),
      ]),
    );
  }

  BlocProvider<ProductsCubit> newest() {
    return BlocProvider<ProductsCubit>(
      create: (context) {
        ProductsCubit productCubit = ProductsCubit();
        productCubit.getProductsList(
            filtersModel: FiltersModel(sort: 'time', level: false, take: 8));
        return productCubit;
      },
      child: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state is ProductsSuccess) {
            final response = state.response;
            if (response.isEmpty) {
              return const SizedBox();
            }
            return Column(
              children: [
                TitleDivider(
                  title: "Newest",
                  click: () => Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => ProductsCubit(),
                      child: ProductsListPage(
                          filters: FiltersModel(sort: 'time', level: false)),
                    ),
                  )),
                ),
                const SizedBox(
                  height: 8,
                ),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 3 / 4),
                  itemCount: response.length,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      ProductCardWidget(product: response[index]),
                )
              ],
            );
          } else if (state is ProductsLoading) {
            return Column(
              children: [
                const TitleDivider(title: "Newest"),
                const SizedBox(
                  height: 8,
                ),
                GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 3 / 4),
                    itemCount: 6,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => DefaultPlaceHolder(
                            child: Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: const Color(0xffeef1f1),
                              borderRadius: BorderRadius.circular(24)),
                        ))),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  BlocProvider<ProductsCubit> specialForYou() {
    return BlocProvider<ProductsCubit>(
      create: (context) {
        ProductsCubit productCubit = ProductsCubit();
        productCubit.getProductsList(
            filtersModel: FiltersModel(sort: 'rate', level: false, take: 6));
        return productCubit;
      },
      child: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state is ProductsSuccess) {
            final response = state.response;
            if (response.isEmpty) {
              return const SizedBox();
            }
            return Column(
              children: [
                const TitleDivider(title: "Popular"),
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
                        ProductCardWidget(product: response[index]),
                  ),
                ),
              ],
            );
          } else if (state is ProductsLoading) {
            return Column(
              children: [
                const TitleDivider(title: "Popular"),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 240,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    shrinkWrap: true,
                    itemExtent: 160,
                    itemBuilder: (context, index) => DefaultPlaceHolder(
                        child: Container(
                      width: 160,
                      height: 240,
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: const Color(0xffeef1f1),
                          borderRadius: BorderRadius.circular(24)),
                    )),
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Container searchBar() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: const Color(0xffeef1f1)),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
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
              onSubmitted: (value) =>
                  Navigator.of(context).push(CupertinoPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => ProductsCubit(),
                  child: ProductsListPage(
                      filters: FiltersModel(
                          search: value, sort: 'time', level: false)),
                ),
              )),
              controller: search,
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.blueAccent.withOpacity(0.6)),
                border: InputBorder.none,
              ),
            ),
          ),
          AnimatedBuilder(
            animation: search,
            builder: (context, child) => search.text.isEmpty
                ? const SizedBox()
                : Row(
                    children: [
                      const SizedBox(
                        width: 12,
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => ProductsCubit(),
                              child: ProductsListPage(
                                  filters: FiltersModel(
                                      search: search.text,
                                      sort: 'time',
                                      level: false)),
                            ),
                          ),
                        ),
                        child: const Icon(
                          CupertinoIcons.arrow_right_circle_fill,
                          color: Colors.blueAccent,
                        ),
                      )
                    ],
                  ),
          )
        ],
      ),
    );
  }

  Widget categories() {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
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
                itemCount: 6,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemBuilder: (context, index) {
                  return categoriesBtn(index, response);
                }),
          );
        } else if (state is CategoriesLoading) {
          return SizedBox(
            height: 90,
            child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: DefaultPlaceHolder(
                      child: SizedBox(
                          width: 64,
                          height: 64,
                          child: Container(
                              padding: const EdgeInsets.all(2.0),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffeef1f1)))),
                    ),
                  );
                }),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget categoriesBtn(int index, List<Category> response) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ProductsCubit(),
            child: ProductsListPage(
                filters: FiltersModel(
                    categoryId: response[index].id,
                    sort: 'time',
                    level: false)),
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(360),
              onTap: index == 5 ? () => screenIndexed.value = 1 : null,
              child: SizedBox(
                width: 64,
                height: 64,
                child: Container(
                  padding: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.blueAccent, width: 1)),
                  child: index == 5
                      ? const Center(
                          child: Icon(
                          CupertinoIcons.layers_fill,
                          color: Colors.blueAccent,
                        ))
                      : ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: response[index].imageUrl.toString(),
                          ),
                        ),
                ),
              ),
            ),
          ),
          Text(
            index == 5 ? 'More' : response[index].name.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
