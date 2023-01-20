import 'package:cafe_app/components/fav_btn.dart';
import 'package:cafe_app/components/price.dart';
import 'package:cafe_app/models/Product.dart';
import 'package:cafe_app/screens/details/details_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
    required this.press,
  }) : super(key: key);

  final Product product;

  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: const BorderRadius.all(
            Radius.circular(defaultPadding * 1.25),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                      onTap: () {
                        
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Image.asset(
                              product.image!,
                              scale: 0.2,
                              fit: BoxFit.fill,),
                      ),
              ),
              SizedBox(height: 10,),
            Text(
              product.title!,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(fontWeight: FontWeight.w600, color: Colors.white),
            ),
            Text(
              "Fruits",
              style: Theme.of(context).textTheme.caption?.copyWith(color: Colors.white),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Price(amount: "20.00"),
                FavBtn(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
