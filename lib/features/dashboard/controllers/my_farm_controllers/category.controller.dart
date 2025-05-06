import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/products/porduct_card_vertical.dart';

class CategoryController extends GetxController {
  var items = <Widget>[].obs; // List to hold items
  final int itemsPerPage = 8; // Number of items to load per page
  var isLoading = false.obs; // Loading indicator
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    loadItems();
    scrollController.addListener(_onScroll);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _onScroll() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200 && !isLoading.value) {
      loadItems();
    }
  }

  void loadItems() async {
    isLoading.value = true;

    // Simulate a delay (e.g., data fetching)
    await Future.delayed(const Duration(seconds: 2));

    // Add new items to the list
    ///items.addAll(List.generate(itemsPerPage, (index) => const ProductCardVertical(plant: [],)));

    isLoading.value = false;
  }

}
