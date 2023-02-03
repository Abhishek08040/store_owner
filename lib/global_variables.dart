List<Product> listOfProducts = [];
bool isProductsDataLoaded = true;

class Product
{
  final String productID;
  final String productPicture;
  final String productName;
  final num productPrice;
  final num productRating;
  final String productDescription;
  final num quantitySold;


  Product(this.productID, this.productPicture, this.productName, this.productPrice, this.productRating, this.productDescription, this.quantitySold);
}