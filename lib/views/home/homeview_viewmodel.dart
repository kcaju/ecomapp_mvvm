import 'package:ecomapp_mvvm/model/homescreen/product_res_model.dart';
import 'package:ecomapp_mvvm/services/api_services.dart';
import 'package:stacked/stacked.dart';

class HomeviewViewmodel extends BaseViewModel {
  List<ProductResModel>? dataObj = [];
  ApiServices apiServices = ApiServices();
  Future<void> init() async {
    apiServices.isCategoryLoading = true;
    await apiServices.getCategories();
    dataObj = await apiServices.getAllProducts();
    apiServices.isCategoryLoading = false;
    notifyListeners();
  }

  Future<void> getCatIndex(int index) async {
    apiServices.selectedCategoryIndex = index;
    apiServices.isProductLoading = true;
    notifyListeners();
    if (index == 0) {
      dataObj = await apiServices.getAllProducts();
    } else {
      dataObj = await apiServices.getAllProducts(
          category: apiServices.categoryList[index]);
    }

    apiServices.isProductLoading = false;
    notifyListeners();
  }
}
