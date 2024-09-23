import 'package:ecomapp_mvvm/utils/color_constants.dart';
import 'package:flutter/material.dart';

class CartsitemWidget extends StatelessWidget {
  const CartsitemWidget(
      {super.key,
      required this.title,
      required this.qty,
      this.onIncrement,
      this.onDecrement,
      this.onRemove,
      required this.price,
      this.image});
  final String title, qty;
  final num price;
  final String? image;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorConstants.blue,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        height: 200,
        child: Row(
          children: [
            Container(
              height: 150,
              width: 120,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill, image: NetworkImage(image!)),
                  borderRadius: BorderRadius.circular(10),
                  color: ColorConstants.green),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.black),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "\$ $price",
                    style: TextStyle(fontSize: 20, color: ColorConstants.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: onDecrement,
                            child: Icon(
                              Icons.remove,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            qty,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                                color: ColorConstants.black),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            onPressed: onIncrement,
                            child: Icon(
                              Icons.add,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: onRemove,
                        child: CircleAvatar(
                          backgroundColor: ColorConstants.grey,
                          child: Icon(
                            Icons.delete_outline,
                            color: ColorConstants.red,
                          ),
                        ),
                      ),
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
}
