import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../../shared/cubit/cubit.dart';
import '../../models/home_model/home_model.dart';
import '../../models/favorite_model/favorite_model.dart';
import '../../models/category_model/category_model.dart';
import '../../models/onBoarding_model/onboarding_model.dart';

// button
Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 5.0,
  required void Function()? function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

// form field
Widget defaultFormField({
  TextEditingController? controller,
  String? initialValue,
  required TextInputType type,
  void Function(String value)? onSubmit,
  void Function(String value)? onChange,
  VoidCallback? onTap,
  void Function(String?)? onSaved,
  bool isPassword = false,
  String? Function(String? value)? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  bool isClickable = true,
  bool readOnly = false,
  bool showCursor = true,
  FocusNode? focusNodeField,
  Color? fillColor,
  TextInputAction textInputAction = TextInputAction.next,
}) =>
    TextFormField(
      controller: controller,
      initialValue: initialValue,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      showCursor: showCursor,
      readOnly: readOnly,
      focusNode: focusNodeField,
      onSaved: onSaved,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: fillColor,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

// simple divider
Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 0.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

// text button
Widget defaultTextButton({
  required VoidCallback onPressed,
  required String label,
}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.w900,
        ),
      ),
    );

// toast message to show
void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum
enum ToastStates { SUCCESS, ERROR, WARNING }

// background color for toast message
Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

// push to another screen
void navigateTo(BuildContext context, Widget widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

// push to the stack new screen and remove all the previous screens
void navigateAndFinish(BuildContext context, Widget widget) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );

// Replace the current route with new
void navigateAndReplacement(BuildContext context, Widget widget) =>
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

// for onBoarding page
Widget buildBoardingItem(BoardingModel item) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image.asset(
            item.image,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          item.title,
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          item.body,
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
      ],
    );

// single product
Widget buildGridProduct(Product productModel, BuildContext context) =>
    Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(productModel.image),
                width: double.infinity,
                height: 120.0,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Container(
                    height: 120.0,
                  );
                },
              ),
              if (productModel.discount != 0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      productModel.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        height: 1.3,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          '${productModel.price.round()}',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        if (productModel.discount != 0)
                          Text(
                            '${productModel.oldPrice!.round()}',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavorites(productModel.id);
                          },
                          icon: CircleAvatar(
                            radius: 25.0,
                            backgroundColor: ShopCubit.get(context)
                                    .checkState(productModel.id)
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                            child: Icon(
                              Icons.favorite_border,
                              size: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

// build category item
Widget buildCategoryItem(Category model) => Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
            image: NetworkImage(model.image),
            height: 100.0,
            width: 100.0,
            fit: BoxFit.cover,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return Container(
                width: 100.0,
                height: 100.0,
              );
            }),
        Container(
          color: Colors.black.withOpacity(
            .8,
          ),
          width: 100.0,
          child: Text(
            model.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );

// title section
Widget titleSection(String title, BuildContext context) => Container(
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
        color: Theme.of(context).primaryColor,
      ),
    );

// single category
Widget buildCatItem(Category model) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(model.image),
            width: 85.0,
            height: 85.0,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 20.0,
          ),
          Text(
            model.name,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            size: 18.0,
          ),
        ],
      ),
    );

// single favorite item
Widget favoriteItem(BuildContext context, FavoriteData favoriteData) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: Container(
        height: 130.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage('${favoriteData.data.image}'),
                  width: 120.0,
                  height: 130.0,
                  fit: BoxFit.cover,
                ),
                if (favoriteData.data.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${favoriteData.data.name}',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.0,
                        height: 1.3,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          '${favoriteData.data.price}',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        if (favoriteData.data.discount != 0)
                          Text(
                            '${favoriteData.data.oldPrice}',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavorites(favoriteData.data.id);
                          },
                          icon: CircleAvatar(
                            radius: 25.0,
                            backgroundColor: ShopCubit.get(context)
                                    .checkState(favoriteData.data.id)
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                            child: Icon(
                              Icons.favorite_border,
                              size: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

// single search item
Widget searchItem(BuildContext context, Product product) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: Container(
        height: 130.0,
        child: Row(
          children: [
            Image(
              image: NetworkImage('${product.image}'),
              width: 120.0,
              height: 130.0,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      '${product.name}',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.0,
                        height: 1.3,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          '${product.price}',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavorites(product.id);
                          },
                          icon: CircleAvatar(
                            radius: 15.0,
                            backgroundColor:
                                ShopCubit.get(context).checkState(product.id)
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey,
                            child: Icon(
                              Icons.favorite_border,
                              size: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

//create the screen
Widget searchBuilder(
  BuildContext context,
  List<Product> list,
) =>
    ConditionalBuilder(
        condition: list.length > 0,
        builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => searchItem(context, list[index]),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: list.length,
            ),
        fallback: (context) => Container(
              child: Center(
                child: Text(
                  'No Data Yet ',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ));
