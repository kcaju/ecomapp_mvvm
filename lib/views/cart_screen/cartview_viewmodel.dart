import 'package:ecomapp_mvvm/services/api_services.dart';
import 'package:stacked/stacked.dart';

class CartviewViewmodel extends BaseViewModel {
  ApiServices apiServices = ApiServices();
  Future<void> init() async {
    await apiServices.getAllCartItems();
    notifyListeners();
  }

  void onIncrement(var key) {
    apiServices.incrementQnty(key);
    notifyListeners();
  }

  void onDecrement(var key) {
    apiServices.decrementQnty(key);
    notifyListeners();
  }

  void onRemove(var key) {
    apiServices.removeItem(key);
    notifyListeners();
  }
}
