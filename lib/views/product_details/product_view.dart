import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecomapp_mvvm/utils/color_constants.dart';
import 'package:ecomapp_mvvm/views/cart_screen/cart_view.dart';
import 'package:ecomapp_mvvm/views/product_details/productview_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductviewViewmodel>.reactive(
      onViewModelReady: (model) {
        model.init(id);
      },
      viewModelBuilder: () {
        return ProductviewViewmodel();
      },
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: ColorConstants.black,
          body: SingleChildScrollView(
            child: Column(
              children: [
                viewModel.apiServices.isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        child: SafeArea(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(
                                        Icons.arrow_back_ios_new,
                                        color: ColorConstants.black,
                                        size: 30,
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.favorite_outline_sharp,
                                      color: ColorConstants.black,
                                      size: 35,
                                    ),
                                  ],
                                ),
                              ),
                              CachedNetworkImage(
                                imageUrl:
                                    viewModel.productDetailObj?.image ?? "",
                                height: 400,
                              )
                            ],
                          ),
                        ),
                        height: 500,
                        decoration: BoxDecoration(
                            color: ColorConstants.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40))),
                      ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              viewModel.productDetailObj?.title ?? "",
                              style: TextStyle(
                                  color: ColorConstants.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Details :",
                        style: TextStyle(
                            color: ColorConstants.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        viewModel.productDetailObj?.description ?? "",
                        style: TextStyle(
                            color: ColorConstants.white, fontSize: 18),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Price",
                                style: TextStyle(
                                    color: ColorConstants.white, fontSize: 18),
                              ),
                              Text(
                                "\$ ${viewModel.productDetailObj?.price ?? ""}",
                                style: TextStyle(
                                    color: ColorConstants.white, fontSize: 18),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 120,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Rate",
                                style: TextStyle(
                                    color: ColorConstants.white, fontSize: 18),
                              ),
                              Text(
                                (viewModel.productDetailObj?.rating?.rate ??
                                        0.0)
                                    .toString(),
                                style: TextStyle(
                                    color: ColorConstants.white, fontSize: 16),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Count",
                                style: TextStyle(
                                    color: ColorConstants.white, fontSize: 18),
                              ),
                              Text(
                                (viewModel.productDetailObj?.rating?.rate ??
                                        0.0)
                                    .toString(),
                                style: TextStyle(
                                    color: ColorConstants.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      InkWell(
                        onTap: () {
                          viewModel.apiServices
                              .addToCart(
                                  title:
                                      viewModel.productDetailObj?.title ?? "",
                                  price: viewModel.productDetailObj?.price ?? 0,
                                  des:
                                      viewModel.productDetailObj?.description ??
                                          "",
                                  id: viewModel.productDetailObj?.id,
                                  image:
                                      viewModel.productDetailObj?.image ?? "")
                              .then(
                            (value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CartView(),
                                  ));
                            },
                          );
                          // context
                          //     .read<CartscreenController>()
                          //     .addToCart(
                          //         title: prodProv.productDetailObj?.title ?? "",
                          //         price: prodProv.productDetailObj?.price ?? 0,
                          //         des: prodProv.productDetailObj?.description,
                          //         id: prodProv.productDetailObj?.id,
                          //         context: context,
                          //         image: prodProv.productDetailObj?.image ?? "")
                          //     .then(
                          //   (value) {
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //           builder: (context) => AddtocartScreen(),
                          //         ));
                          //   },
                          // );
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              color: ColorConstants.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Add to Cart",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstants.black,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Icon(
                                Icons.shopping_bag_outlined,
                                color: ColorConstants.black,
                                size: 30,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
