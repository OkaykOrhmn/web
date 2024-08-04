// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/core/cubit/categories/categories_cubit.dart';

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
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    spreadRadius: 1,
                    offset: const Offset(0.5, 0.5))
              ], borderRadius: BorderRadius.circular(12), color: Colors.white),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: response[index].imageUrl.toString(),
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
    );
  }
}
