import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mini_market/layout/cubit/cubit.dart';
import 'package:mini_market/layout/home_layout/cubit/cubit.dart';
import 'package:mini_market/sharing/styles/const.dart';

Widget defaultFormField(
        {@required TextEditingController controller,
        @required TextInputType type,
        Function onSubmit,
        Function onChange,
        Function onTap,
        bool isPassword = false,
        @required Function validate,
        @required String label,
        IconData prefix,
        BorderRadius borderRadius,
        BorderSide borderSide,
        OutlineInputBorder outlinedBorder,
        IconData suffix,
        Function suffixPressed,
        bool isClickable = true,
        TextStyle labelstyle,
        Icon outsideicon,
        Color prefixiconcolor,
        context}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        icon: outsideicon,
        labelText: label,
        labelStyle: labelstyle,
        prefixIcon: Icon(
          prefix,
          color: prefixiconcolor,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(
            borderRadius: borderRadius, borderSide: borderSide),
        enabledBorder: OutlineInputBorder(
            borderSide: borderSide, borderRadius: borderRadius),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateandFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );
Widget defaultButton({
  double width = double.infinity,
  double height = 40.0,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  @required Function function,
  @required String text,
  double fontsize = 15,
  FontWeight fontWeight = FontWeight.normal,
}) =>
    Container(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
              color: Colors.white, fontSize: fontsize, fontWeight: fontWeight),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

void showtoast({@required String message, @required ToastState state}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: ColorOftoast(state),
        textColor: Colors.white,
        fontSize: 16.0);
enum ToastState { SUCCESS, ERROR, WARNING }

// ignore: non_constant_identifier_names
Color ColorOftoast(ToastState state) {
  Color color;

  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget myDivider({
  double padding = 10,
  Color color = Colors.grey,
}) =>
    Padding(
      padding: EdgeInsets.only(left: padding, right: padding),
      child: Container(
        height: 1,
        color: color,
      ),
    );
Widget customItem({
  @required BuildContext context,
  @required String image,
  @required String nameProduct,
  @required dynamic price,
  @required dynamic oldPrice,
  @required dynamic discount,
  @required Icon favoriteIcon,
  @required bool isCart,
  @required Function addCart,
  @required Function addFavorite,
}) {
  return Container(
    width: double.infinity,
    height: double.infinity,
    child: Card(
      elevation: 4,
      margin: EdgeInsets.all(6),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl: image,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                  ),
                  flex: 4,
                ),
                SizedBox(
                  height: 8,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        nameProduct,
                        style: TextStyle(
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Text(
                            ('${price.toString()} EGP'),
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: defaultcolor),
                          ),
                          Spacer(),
                          if (discount != 0)
                            Text(
                              '${oldPrice.toString()} EGP',
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: isCart
                            ? ElevatedButton.icon(
                                onPressed: addCart,
                                label: Text('Added'),
                                icon: Icon(Icons.check),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.green.shade300),
                                ),
                              )
                            : ElevatedButton.icon(
                                onPressed: addCart,
                                label: Text('Add to cart'),
                                icon: Icon(Icons.add_shopping_cart_outlined),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // if (discount != 0)
              //   Banner(
              //     message: 'SALE',
              //     location: BannerLocation.topStart,
              //   ),
              /*Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),*/
              // decoration: BoxDecoration(color: Colors.amber.withOpacity(1)),
              Spacer(),
              IconButton(icon: favoriteIcon, onPressed: addFavorite),
            ],
          ),
          if (discount != 0)
            Banner(
              message: 'SALE',
              location: BannerLocation.topStart,
            ),
        ],
        // alignment: AlignmentDirectional.topEnd,
      ),
    ),
  );
}

Widget buildListItem(model, context, {isOldPrice = true}) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        color: AppCubit.get(context).isdark ? Colors.white : Colors.black,
        height: 150,
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: 120,
                  height: 120,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        gradient:
                            LinearGradient(colors: [Colors.red, Colors.white])),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'discount'.toUpperCase(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        height: 1.4,
                        color: AppCubit.get(context).isdark
                            ? Colors.black
                            : Colors.white),
                  ),
                  Spacer(),
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
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          'EGP ${model.oldPrice.round()}',
                          style: TextStyle(
                              color: AppCubit.get(context).isdark
                                  ? Colors.grey
                                  : Colors.white,
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough),
                        ),
                    ],
                  ),
                  Row(
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
                      SizedBox(
                        width: 20,
                      ),
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
            )
          ],
        ),
      ),
    );
