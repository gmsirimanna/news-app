// import 'package:flutter/foundation.dart';
// import 'package:tenant_click/data/model/item_model.dart';
// import 'package:tenant_click/data/repository/auth_repo.dart';

// class SearchProvider with ChangeNotifier {
//   final AuthRepo authRepo;
//   SearchProvider({@required this.authRepo});

//   bool _isSearchClicked = false;
//   final List<ProductItem> _itemList = [];
//   List<ProductItem> _filteredItemList = [];

//   bool get isSearchClicked => _isSearchClicked;
//   List<ProductItem> get allItemList => _itemList;
//   List<ProductItem> get filteredItemList => _filteredItemList;

//   void setSearchClicked() {
//     _isSearchClicked = !_isSearchClicked;
//     notifyListeners();
//   }

//   void setAllItems(List<ProductItem> items) {
//     _filteredItemList.clear();
//     _itemList.clear();
//     _itemList.addAll(items);
//     _filteredItemList.addAll(items);
//     notifyListeners();
//   }

//   void filterItems(String key) {
//     _filteredItemList = _itemList
//         .where(
//           (item) => item.itemName.toLowerCase().contains(key.toLowerCase()),
//         )
//         .toList();
//     notifyListeners();
//   }

//   void clearSearch() {
//     _filteredItemList.clear();
//     _filteredItemList.addAll(_itemList);
//     notifyListeners();
//   }
// }
