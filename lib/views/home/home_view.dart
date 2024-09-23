import 'package:ecomapp_mvvm/utils/color_constants.dart';
import 'package:ecomapp_mvvm/views/cart_screen/cart_view.dart';
import 'package:ecomapp_mvvm/views/home/homeview_viewmodel.dart';
import 'package:ecomapp_mvvm/views/product_details/product_view.dart';
import 'package:ecomapp_mvvm/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeviewViewmodel>.reactive(
      onViewModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () {
        return HomeviewViewmodel();
      },
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: ColorConstants.black,
          appBar: AppBar(
            backgroundColor: ColorConstants.black,
            leading: Icon(
              Icons.sort,
              color: ColorConstants.white,
              size: 30,
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartView(),
                      ));
                },
                child: Icon(
                  Icons.shopping_bag_outlined,
                  color: ColorConstants.white,
                  size: 30,
                ),
              )
            ],
          ),
          body: viewModel.apiServices.isCategoryLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "Categories",
                        style: TextStyle(
                            color: ColorConstants.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          viewModel.apiServices.categoryList.length,
                          (index) => InkWell(
                            onTap: () {
                              viewModel.getCatIndex(index);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                viewModel.apiServices.categoryList[index]
                                    .toString()
                                    .toUpperCase(),
                                style: TextStyle(
                                    color: index ==
                                            viewModel.apiServices
                                                .selectedCategoryIndex
                                        ? ColorConstants.white
                                        : ColorConstants.grey,
                                    decoration: TextDecoration.underline,
                                    decorationColor: index ==
                                            viewModel.apiServices
                                                .selectedCategoryIndex
                                        ? ColorConstants.white
                                        : ColorConstants.black,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40)),
                          color: ColorConstants.white),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: viewModel.apiServices.isProductLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : GridView.builder(
                                shrinkWrap: true,
                                itemCount: viewModel.dataObj?.length ?? 0,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisSpacing: 10,
                                        mainAxisExtent: 320,
                                        mainAxisSpacing: 10,
                                        crossAxisCount: 2),
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    //toproductviewscreen
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductView(
                                              id: viewModel.dataObj?[index].id
                                                      .toString() ??
                                                  ""),
                                        ));
                                  },
                                  child: ProductCard(
                                    title:
                                        viewModel.dataObj?[index].title ?? "",
                                    price: viewModel.dataObj?[index].price ?? 0,
                                    img: viewModel.dataObj?[index].image ?? "",
                                    id: viewModel.dataObj?[index].id ?? 0,
                                  ),
                                ),
                              ),
                      ),
                    ))
                  ],
                ),
        );
      },
    );
  }
}
