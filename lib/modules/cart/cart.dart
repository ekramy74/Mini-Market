// import 'package:another_flushbar/flushbar.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_market/layout/home_layout/cubit/cubit.dart';
import 'package:mini_market/layout/home_layout/cubit/states.dart';
import 'package:mini_market/sharing/components/components.dart';
import 'package:mini_market/sharing/styles/const.dart';

class CartScreen extends StatelessWidget {
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
          condition: state is! HomecartLoadingState,
          builder: (context) => Column(
            children: [
              Expanded(
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => buildListItem(
                        HomeCubit.get(context)
                            .getcart
                            .data
                            .cartItems[index]
                            .product,
                        context),
                    separatorBuilder: (context, index) =>
                        myDivider(padding: 40),
                    itemCount:
                        HomeCubit.get(context).getcart.data.cartItems.length),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: defaultButton(
                    function: () {},
                    text: 'checkout'.toUpperCase(),
                    fontWeight: FontWeight.bold,
                    fontsize: 18,
                    height: 55,
                    isUpperCase: true,
                    //radius: 30,
                    background: defaultcolor[300]),
              )
            ],
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
