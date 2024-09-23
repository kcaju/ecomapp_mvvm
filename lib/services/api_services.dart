import 'dart:convert';

import 'package:ecomapp_mvvm/model/cart_screen/cart_model.dart';
import 'package:ecomapp_mvvm/model/homescreen/product_res_model.dart';
import 'package:ecomapp_mvvm/model/productdetail_screen/productdetails_screen_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  //homescreen
  List categoryList = ["All"];
  bool isCategoryLoading = false;
  bool isProductLoading = false;
  int selectedCategoryIndex = 0;

  Future<List<ProductResModel>?> getAllProducts({String category = ''}) async {
    isProductLoading = true;
    List<ProductResModel>? dataObj = [];

    // notifyListeners();
    try {
      final allurl = Uri.parse("https://fakestoreapi.com/products");
      final categoryurl =
          Uri.parse("https://fakestoreapi.com/products/category/$category");
      final url = category.isEmpty ? allurl : categoryurl;
      var productData = await http.get(url);
      print(productData.statusCode);
      if (productData.statusCode == 200) {
        // var jsonn = jsonDecode(productData.body) as List;
        // dataObj = jsonn.map((item) => ProductResModel.fromJson(item)).toList();
        // return dataObj;
        dataObj = productResModelFromJson(productData.body);
        return dataObj;
        // var jsonn = jsonDecode(productData.body);
        // var res = ProductResModel.fromJson(jsonn);
        // dataObj = res as List<ProductResModel>;
        // return dataObj;
        // print(dataObj[0].title);
      }
    } catch (e) {
      print(e);
    }
    isProductLoading = false;
  }

  Future<void> getCategories() async {
    isCategoryLoading = true;

    try {
      final url = Uri.parse("https://fakestoreapi.com/products/categories");
      var resp = await http.get(url);
      print(resp.statusCode);
      if (resp.statusCode == 200) {
        categoryList.addAll(jsonDecode(resp.body));
      }
    } catch (e) {
      print(e);
    }
    isCategoryLoading = false;
  }

  void getCategoryIndex(int index) {
    selectedCategoryIndex = index;
    if (selectedCategoryIndex == 0) {
      getAllProducts();
    } else {
      getAllProducts(category: categoryList[selectedCategoryIndex]);
    }
  }

  //productdetailscreen
  ProductsDetailsModel? productDetailObj;
  bool isLoading = false;
  Future<ProductsDetailsModel?> getProductDetails({required String id}) async {
    isLoading = true;
    // notifyListeners();
    try {
      final url = Uri.parse("https://fakestoreapi.com/products/$id");
      var res = await http.get(url);
      print(res.statusCode);
      if (res.statusCode == 200) {
        productDetailObj = productsDetailsModelFromJson(res.body);
        return productDetailObj;
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
    // notifyListeners();
  }

  //cartscreen
  final cartBox = Hive.box<CartModel>("cartBox");
  List keys = [];
  Future<void> addToCart(
      {required String title,
      BuildContext? context,
      String? des,
      num? id,
      int qty = 1,
      String? image,
      required num price}) async {
    bool alreadyinCart = false;
//to check whether  the item is already in cart(hive)
    for (int i = 0; i < keys.length; i++) {
      //checking whether the id of added item is in hive(use get fnct)
      var iteminHive = cartBox.get(keys[i]);
      if (iteminHive?.id == id) {
        alreadyinCart = true;
      }
    }
    if (alreadyinCart == false) {
      await cartBox.add(CartModel(
          price: price,
          title: title,
          qty: qty,
          image: image,
          des: des,
          id: id));
      keys = cartBox.keys.toList();
    }
    //else {
    // ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
    //     shape:
    //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    //     backgroundColor: ColorConstants.orange,
    //     duration: Duration(seconds: 3),
    //     content: Text(
    //       "Item Already Added",
    //       style: TextStyle(
    //           color: ColorConstants.black,
    //           fontSize: 20,
    //           fontWeight: FontWeight.bold),
    //     )));
    // }
    // notifyListeners();
  }

  removeItem(var key) async {
    await cartBox.delete(key);
    keys = cartBox.keys.toList();
    // notifyListeners();
  }

  incrementQnty(var key) {
    final currentItemData = cartBox.get(key);
    cartBox.put(
        key,
        CartModel(
          price: currentItemData!.price,
          title: currentItemData.title,
          id: currentItemData.id,
          image: currentItemData.image,
          des: currentItemData.des,
          qty: ++currentItemData.qty,
        ));
    // notifyListeners();
  }

  decrementQnty(var key) {
    final currentItemData = cartBox.get(key);
    if (currentItemData!.qty >= 2) {
      cartBox.put(
          key,
          CartModel(
            price: currentItemData.price,
            title: currentItemData.title,
            id: currentItemData.id,
            image: currentItemData.image,
            des: currentItemData.des,
            qty: --currentItemData.qty,
          ));
    }
    // notifyListeners();
  }

  getAllCartItems() {
    keys = cartBox.keys.toList();
    // notifyListeners();
  }

//for getting the current item
  CartModel? getCurrentItem(var key) {
    final currentItem = cartBox.get(key);
    return currentItem;
  }

  double calculateTotalAmount() {
    double totalAmount = 0.0;
    for (int i = 0; i < keys.length; i++) {
      final item = cartBox.get(keys);
      if (item != null) {
        totalAmount += item.price * item.qty;
      }
    }
    // notifyListeners();
    return totalAmount;
  }
}
