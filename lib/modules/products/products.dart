import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_market/layout/cubit/cubit.dart';
import 'package:mini_market/layout/home_layout/cubit/cubit.dart';
import 'package:mini_market/layout/home_layout/cubit/states.dart';
import 'package:mini_market/models/Home_model/home_model.dart';
import 'package:mini_market/models/category_model/category_model.dart';
import 'package:mini_market/sharing/components/components.dart';
import 'package:mini_market/sharing/styles/const.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is HomeGetFavoritesSuccessState) {
          if (!state.model.status) {
            showtoast(message: state.model.message, state: ToastState.ERROR);
          } else {
            showtoast(message: state.model.message, state: ToastState.SUCCESS);
          }
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
            condition: HomeCubit.get(context).homeModel != null &&
                HomeCubit.get(context).categoryModel != null,
            fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
            builder: (context) => productbuilder(
                HomeCubit.get(context).homeModel,
                HomeCubit.get(context).categoryModel,
                context));
      },
    );
  }

  Widget productbuilder(
          HomeModel model, CategoryModel categoryModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CarouselSlider(
                items: model.data.banners
                    .map((e) => Image(
                          image: NetworkImage('${e.image}'),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ))
                    .toList(),
                options: CarouselOptions(
                    autoPlay: true,
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    initialPage: 0,
                    height: 150,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlayInterval: Duration(seconds: 3),
                    viewportFraction: 1.0)),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: AppCubit.get(context).isdark
                          ? FontWeight.bold
                          : FontWeight.w300,
                      color: AppCubit.get(context).isdark
                          ? Colors.black
                          : Colors.white),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Container(
                height: 100,
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => buildCategoryitem(
                        categoryModel.data.data[index], context),
                    separatorBuilder: (context, index) => SizedBox(
                          width: 10,
                        ),
                    itemCount: categoryModel.data.data.length),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'New Products',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: AppCubit.get(context).isdark
                          ? FontWeight.bold
                          : FontWeight.w300,
                      color: AppCubit.get(context).isdark
                          ? Colors.black
                          : Colors.white),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Text(
                        'See more'.toUpperCase(),
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: defaultcolor[300]),
                      ),
                      Icon(Icons.arrow_forward_ios,
                          size: 15, color: defaultcolor[300])
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: GridView.count(
                  shrinkWrap: true,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  childAspectRatio: .88 / 1.74,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  children: List.generate(
                    model.data.products.length,
                    (index) =>
                        buildGridProducts(model.data.products[index], context),
                  )),
            )
          ]),
        ),
      );

  Widget buildCategoryitem(DataModel dataModel, context) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(dataModel.image),
            //fit: BoxFit.cover,
            height: 100,
            width: 100,
          ),
          Container(
              width: 100,
              height: 20,
              color: AppCubit.get(context).isdark
                  ? Colors.black.withOpacity(.5)
                  : Colors.white.withOpacity(.5),
              child: Text(
                dataModel.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: AppCubit.get(context).isdark
                        ? Colors.white
                        : Colors.black,
                    fontSize: 14),
              )),
        ],
      );

  Widget buildGridProducts(ProductsModel model, context) => Card(
        color: AppCubit.get(context).isdark ? Colors.white : Colors.black,
        elevation: 3,
        child: Container(
          decoration: BoxDecoration(
              color: AppCubit.get(context).isdark ? Colors.white : Colors.black,
              borderRadius: BorderRadius.circular(50)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image(
                      image: NetworkImage(model.image),
                      width: double.infinity,
                      height: 200,
                    ),
                  ),
                  if (model.discount != 0)
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          gradient: LinearGradient(colors: [
                            Colors.red,
                            AppCubit.get(context).isdark
                                ? Colors.white
                                : Colors.black
                          ])),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'discount'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: AppCubit.get(context).isdark
                                  ? FontWeight.bold
                                  : FontWeight.w300),
                        ),
                      ),
                    )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          height: 1.4,
                          color: AppCubit.get(context).isdark
                              ? Colors.black
                              : Colors.white),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          'EGP ${model.price.round()}',
                          style:
                              TextStyle(color: defaultcolor[300], fontSize: 12),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        if (model.discount != 0)
                          Text(
                            'EGP ${model.oldprice.round()}',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough),
                          ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            // padding: EdgeInsets.zero,
                            icon: HomeCubit.get(context).favorites[model.id]
                                ? Icon(Icons.favorite, color: Colors.red[600])
                                : Icon(
                                    Icons.favorite_border,
                                    color: AppCubit.get(context).isdark
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                            onPressed: () {
                              HomeCubit.get(context).changeFavorites(model.id);
                              print(model.id);
                            }),
                        IconButton(
                            //padding: EdgeInsets.zero,
                            icon: HomeCubit.get(context).cart[model.id]
                                ? Icon(
                                    Icons.done_outline_rounded,
                                    color: Colors.green,
                                  )
                                : Icon(
                                    Icons.shopping_cart_outlined,
                                    color: AppCubit.get(context).isdark
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                            onPressed: () {
                              HomeCubit.get(context).changecart(model.id);
                              print(model.id);
                            }),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
