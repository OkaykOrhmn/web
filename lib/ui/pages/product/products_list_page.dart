// ignore_for_file: library_private_types_in_public_api

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/core/cubit/products/Products_state.dart';
import 'package:web/core/cubit/products/products_cubit.dart';
import 'package:web/data/model/filters_model.dart';
import 'package:web/ui/widgets/button/primary_group_button.dart';
import 'package:web/ui/widgets/components/default_place_holder.dart';
import 'package:web/ui/widgets/components/product_card_widget.dart';
import 'package:web/ui/widgets/handler/dialog/dialog_handler.dart';

class ProductsListPage extends StatefulWidget {
  final FiltersModel filters;
  const ProductsListPage({super.key, required this.filters});

  @override
  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  final TextEditingController search = TextEditingController();
  final btns = ["News", "Oldest", "Most", "Cheap", "high Rate", "low Rate"];
  late FiltersModel filters = widget.filters;

  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        search.text = filters.search ?? '';
        callApi();
      },
    );

    super.initState();
  }

  void callApi() {
    context.read<ProductsCubit>().getProductsList(filtersModel: filters);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            searchbar(),
            PrimaryGroupButton(
              btns: btns,
              onSelected: selectedBtn,
            ),
            const SizedBox(
              height: 12,
            ),
            products(),
          ],
        ),
      ),
    );
  }

  Widget products() {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductsSuccess) {
          final response = state.response;
          if (response.isEmpty) {
            return const SizedBox();
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 3 / 4),
            itemCount: response.length,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 4),
            shrinkWrap: true,
            itemBuilder: (context, index) =>
                ProductCardWidget(product: response[index]),
          );
        } else if (state is ProductsLoading || state is ProductsInitial) {
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                  )));
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Container searchbar() {
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
              controller: search,
              onChanged: (value) {
                EasyDebounce.debounce(
                    'search-debouncer', const Duration(seconds: 1), () {
                  filters = filters.copyWith(search: value);
                  callApi();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.blueAccent.withOpacity(0.6)),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Container(
            height: 24,
            width: 1,
            color: Colors.lightBlueAccent,
          ),
          const SizedBox(
            width: 12,
          ),
          InkWell(
            onTap: () => DialogHandler(context).showCategoriesBottomSheet(
              categoryId: filters.categoryId,
              click: (p0) {
                if (p0 == filters.categoryId) {
                  filters = filters.clearCategoryId();
                } else {
                  filters = filters.copyWith(categoryId: p0);
                }

                callApi();
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
            child: const Icon(
              Icons.filter_tilt_shift_rounded,
              color: Colors.blueAccent,
            ),
          )
        ],
      ),
    );
  }

  void selectedBtn(name, index, selected) {
    switch (index) {
      case 0:
        filters = filters.copyWith(sort: "time", level: false);
        break;
      case 1:
        filters = filters.copyWith(sort: "time", level: true);

        break;
      case 2:
        filters = filters.copyWith(sort: "money", level: false);

        break;
      case 3:
        filters = filters.copyWith(sort: "money", level: true);

        break;
      case 4:
        filters = filters.copyWith(sort: "rate", level: false);

        break;
      case 5:
        filters = filters.copyWith(sort: "rate", level: true);

        break;
      default:
        break;
    }

    callApi();
  }
}
