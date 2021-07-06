import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mini_market/layout/home_layout/cubit/cubit.dart';
import 'package:mini_market/layout/home_layout/cubit/states.dart';

import 'package:mini_market/sharing/components/components.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is HomeGetFavoritesSuccessState) {
          showtoast(message: state.model.message, state: ToastState.SUCCESS);
        }
        if (state is HomeGetCartSuccessState) {
          if (!state.model.status) {
            showtoast(message: state.model.message, state: ToastState.ERROR);
          } else {
            showtoast(message: state.model.message, state: ToastState.SUCCESS);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! HomeFavoritesLoadingState,
          builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildListItem(
                  HomeCubit.get(context).getFavorites.data.data[index].product,
                  context),
              separatorBuilder: (context, index) => myDivider(padding: 40),
              itemCount: HomeCubit.get(context).getFavorites.data.data.length),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
