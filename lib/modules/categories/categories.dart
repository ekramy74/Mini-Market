import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_market/layout/cubit/cubit.dart';
import 'package:mini_market/layout/home_layout/cubit/cubit.dart';
import 'package:mini_market/layout/home_layout/cubit/states.dart';
import 'package:mini_market/models/category_model/category_model.dart';
import 'package:mini_market/sharing/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! HomeGetCategoryLoadingState,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildcatitem(
                  HomeCubit.get(context).categoryModel.data.data[index],
                  context),
              separatorBuilder: (context, index) => myDivider(padding: 50),
              itemCount: HomeCubit.get(context).categoryModel.data.data.length),
        );
      },
    );
  }

  Widget buildcatitem(DataModel model, context) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image(
              image: NetworkImage(model.image),
              width: 100,
              height: 100,
            ),
            SizedBox(
              width: 25,
            ),
            Text(
              model.name,
              style: TextStyle(
                  fontSize: 16,
                  color: AppCubit.get(context).isdark
                      ? Colors.black
                      : Colors.white),
            ),
            Spacer(),
            IconButton(
                icon: Icon(Icons.arrow_forward_ios_outlined), onPressed: () {})
          ],
        ),
      );
}
