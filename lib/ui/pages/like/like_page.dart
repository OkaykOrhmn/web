// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/core/bloc/likes/likes_bloc.dart';
import 'package:web/core/cubit/like/like_cubit.dart';
import 'package:web/ui/widgets/components/default_place_holder.dart';
import 'package:web/ui/widgets/components/product_card_widget.dart';

class LikePage extends StatefulWidget {
  const LikePage({super.key});

  @override
  _LikePageState createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> {
  @override
  void initState() {
    context.read<LikesBloc>().add(GetAllLikes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wish List'),
      ),
      body: BlocBuilder<LikesBloc, LikesState>(
        builder: (context, state) {
          if (state is LikesSuccess) {
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
          } else if (state is LikeFail) {
            return Container();
          } else {
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
          }
        },
      ),
    );
  }
}
