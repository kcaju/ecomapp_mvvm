import 'package:ecomapp_mvvm/model/productdetail_screen/productdetails_screen_model.dart';
import 'package:ecomapp_mvvm/services/api_services.dart';
import 'package:stacked/stacked.dart';

class ProductviewViewmodel extends BaseViewModel {
  ProductsDetailsModel? productDetailObj;
  ApiServices apiServices = ApiServices();
  Future<void> init(String id) async {
    apiServices.isLoading = true;
    notifyListeners();
    productDetailObj = await apiServices.getProductDetails(id: id);
    apiServices.isLoading = false;
    notifyListeners();
  }
}
