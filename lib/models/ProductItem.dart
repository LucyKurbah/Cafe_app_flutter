import 'Product.dart';

class ProductItem{

  late int quantity;
  late final Product? product;

  ProductItem({this.quantity = 1, required this.product});

  void increment(){
    quantity++;
  }
}