import 'package:ecomapp_mvvm/utils/color_constants.dart';

import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {super.key,
      required this.title,
      required this.price,
      required this.img,
      this.id});
  final String title, img;
  final num price;
  final num? id;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Card(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                height: 300,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      maxLines: 1,
                      title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 35,
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorConstants.peac,
                ),
              ),
            ),
            Card(
              child: Container(
                height: 220,
                decoration: BoxDecoration(
                    color: ColorConstants.blue,
                    image: DecorationImage(
                        fit: BoxFit.fill, image: NetworkImage(img)),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
              ),
            ),
            Positioned(
              top: 20,
              right: 30,
              child: Icon(
                Icons.favorite,
                color: ColorConstants.green,
                size: 30,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 50,
                width: 150,
                child: Center(
                  child: Text(
                    "\$ $price",
                    style: TextStyle(
                        color: ColorConstants.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.elliptical(60, 50),
                        bottomLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    color: ColorConstants.red),
              ),
            )
          ],
        ),
      ],
    );
  }
}
