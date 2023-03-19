import 'package:cloud_firestore/cloud_firestore.dart';

List<Product> listOfAllProducts = [];
List<Product> listOfMostSoldProducts = [];
List<Product> listOfLowStockProducts = [];
List<Product> listOfOutOfStockProducts = [];
int dateLowerRange = 0; //201001290000;
int dateHigherRange = 0; //202401260000;

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

void getListOProductsSold()
{
  Map quantitySold = {};

  var products = FirebaseFirestore
      .instance
      .collection('Transactions')
      .where('InvoiceDate', isLessThanOrEqualTo: 202302150000)
      .where('InvoiceDate', isGreaterThanOrEqualTo: 201011260000);

  products.get().then((QuerySnapshot snapshot)
  {
    listOfMostSoldProducts.clear();
    for (var doc in snapshot.docs)
    {
      Map item = doc.data()! as Map<String, dynamic>;

      var productsPurchasedByCustomer = item['StockCode'].map((e) => e.toString()).toList();

      for (var x in productsPurchasedByCustomer)
      {
        if (quantitySold.containsKey(x))
        {
          quantitySold[x] = quantitySold[x] + 1;
        }
        else
        {
          quantitySold[x] = 1;
        }
      }
    }

    for (var x in quantitySold.keys)
    {

      Product p = listOfAllProducts.singleWhere((element) => element.productID == x);
      p.quantitySold = quantitySold[x];
      listOfMostSoldProducts.add(p);

    }

  });

}