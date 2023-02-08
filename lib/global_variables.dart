List<Product> listOfAllProducts = [];
List<Product> listOfMostSoldProducts = [];
List<Product> listOfLowStockProducts = [];
List<Product> listOfOutOfStockProducts = [];


class Product
{
  final String productID;
  final String productPicture;
  final String productName;
  final num productPrice;
  final num productRating;
  final String productDescription;
  num quantitySold;
  final num totalQuantity;


  Product(this.productID, this.productPicture, this.productName, this.productPrice, this.productRating, this.productDescription, this.quantitySold, this.totalQuantity);
}
