// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/core/cubit/categories/categories_cubit.dart';
import 'package:web/core/cubit/products/products_cubit.dart';
import 'package:web/data/model/filters_model.dart';
import 'package:web/ui/pages/product/products_list_page.dart';
import 'package:web/ui/widgets/components/category_card_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesSuccess) {
          final response = state.response;
          if (response.isEmpty) {
            return const SizedBox();
          }
          return GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12),
            physics: const BouncingScrollPhysics(),
            itemCount: response.length,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 32),
            itemBuilder: (context, index) => InkWell(
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
                child: CategoryCardWidget(category: response[index])),
          );
        } else if (state is CategoriesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
