// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/core/bloc/cart/cart_bloc.dart';
import 'package:web/core/cubit/cart/edit_cart_cubit.dart';
import 'package:web/data/model/product_model.dart';
import 'package:web/ui/widgets/components/product_card_widget.dart';
import 'package:web/ui/widgets/components/title_divider.dart';
import 'package:web/ui/widgets/handler/dialog/dialog_handler.dart';
import 'package:web/ui/widgets/loading/primary_loading.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    context.read<CartBloc>().add(GetAllCarts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          AppBar(
            title: const Text('My Carts'),
            forceMaterialTransparency: true,
          ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartSuccess) {
                final response = state.response.carts!;
                if (response.isEmpty) {
                  return const SizedBox();
                }
                return ListView.builder(
                    itemCount: response.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, caartIndex) {
                      double totalPrice = 0;
                      List<Product> productList = [];
                      final products = response[caartIndex].products!;
                      for (var element in products) {
                        element.product!.count = element.count;
                        productList.add(element.product!);
                        totalPrice +=
                            (element.count! * element.product!.price!);
                      }
                      // if (productList.isEmpty) {
                      //   return const SizedBox();
                      // }
                      return Card(
                        color: const Color(0xffeef1f1),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              // TitleDivider(
                              //     title: "Cart: ${response[caartIndex].name}"),
                              // const SizedBox(
                              //   height: 8,
                              // ),
                              GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 3 / 4),
                                itemCount: productList.length,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(4),
                                shrinkWrap: true,
                                itemBuilder: (context, index) => Stack(
                                  children: [
                                    ProductCardWidget(
                                      product: productList[index],
                                      backgroundColor: Colors.white,
                                    ),
                                    Positioned(
                                        bottom: 8,
                                        right: 8,
                                        child: Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.blueAccent,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(24),
                                                    bottomRight:
                                                        Radius.circular(12))),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 18, vertical: 2),
                                            child: Text(
                                              productList[index]
                                                  .count
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            )))
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {},
                                      child: Text(
                                          "final Order \$${totalPrice.toStringAsFixed(2)}")),
                                  ElevatedButton(
                                      onPressed: () {
                                        DialogHandler(context).showDeleteDialog(
                                            onDelete: () async {
                                          await context
                                              .read<EditCartCubit>()
                                              .deleteCart(
                                                  id: response[caartIndex].id!);
                                          Future.delayed(
                                              Duration.zero,
                                              () => context
                                                  .read<CartBloc>()
                                                  .add(GetAllCarts()));
                                        });
                                      },
                                      child: const Row(
                                        children: [
                                          Text(
                                            "Delete Order",
                                            style: TextStyle(
                                                color: Colors.redAccent),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Icon(
                                            CupertinoIcons.trash_fill,
                                            color: Colors.redAccent,
                                            size: 18,
                                          )
                                        ],
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              } else if (state is CartFail) {
                return Container();
              } else {
                return const PrimaryLoading();
              }
            },
          ),
        ],
      ),
    );
  }
}
