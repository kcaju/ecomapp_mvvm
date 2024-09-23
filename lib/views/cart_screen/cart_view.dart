import 'package:ecomapp_mvvm/utils/color_constants.dart';
import 'package:ecomapp_mvvm/views/cart_screen/cartview_viewmodel.dart';
import 'package:ecomapp_mvvm/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartviewViewmodel>.reactive(
      onViewModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () {
        return CartviewViewmodel();
      },
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: ColorConstants.black,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: ColorConstants.black,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                size: 30,
                color: ColorConstants.white,
              ),
            ),
            title: Text(
              "My Cart",
              style: TextStyle(color: ColorConstants.white),
            ),
          ),
          body: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      final cartItem = viewModel.apiServices
                          .getCurrentItem(viewModel.apiServices.keys[index]);
                      return CartsitemWidget(
                        title: cartItem?.title.toString() ?? "",
                        qty: cartItem?.qty.toString() ?? "",
                        price: cartItem?.price ?? 0,
                        image: cartItem?.image ?? "",
                        onDecrement: () {
                          viewModel
                              .onDecrement(viewModel.apiServices.keys[index]);
                        },
                        onIncrement: () {
                          viewModel
                              .onIncrement(viewModel.apiServices.keys[index]);
                        },
                        onRemove: () {
                          viewModel.onRemove(viewModel.apiServices.keys[index]);
                        },
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                    itemCount: viewModel.apiServices.keys.length),
              )
            ],
          ),
        );
      },
    );
  }
}
