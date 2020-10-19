import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/details/detailProduct.dart';


class Catalogue extends StatefulWidget {
  final children;

  Catalogue({Key key, this.children}) : super(key: key);

  @override
  _CatalogueState createState() => _CatalogueState();
}

class _CatalogueState extends State<Catalogue> {
  var _isInit = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<Products>(context).fetchAndSetProducts();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context).items;
    int controllerLength = widget.children.children.length;
    return Scaffold(
      body: DefaultTabController(
        length: controllerLength,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverAppBar(
                title: Text(
                  widget.children.title.toString(),
                  style: TextStyle(
                    fontFamily: "Gotik",
                    fontWeight: FontWeight.w400,
                  ),
                ),
                floating: true,
                pinned: true,
                snap: true,
                // <--- this is required if I want the application bar to show when I scroll up
                bottom: new TabBar(
                    isScrollable: true,
                    indicatorColor: Color(0xFF00AB50),
                    labelColor: Color(0xFF00AB50),
                    labelPadding: EdgeInsets.all(8.0),
                    unselectedLabelColor: Colors.black,
                    tabs: [for (var item in widget.children.children)
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                        child: Text(
                          item.title,
                          style: TextStyle(
                              fontFamily: "Gotik",
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0),
                        ),
                      )
                    ] // <-- total of 2 tabs
                ),
              ),
            ];
          },
          body: new TabBarView(
              children: [for (int i = 0; i < widget.children.children.length; i++)
                ListView.builder(
                    itemCount: productsData.where((item) =>
                    item.category == widget.children.children[i].id.toString()).toList().length,
                    itemBuilder: (context, index) {
                      var item = productsData.where((item) =>
                      item.category == widget.children.children[i].id.toString()).toList()[index];
                      return CatalogueItem(item: item);
                    })
              ] // <--- the array item is a ListView
          ),
        ),
      ),
    );
  }
}

/// Items of Product View on CataloguePage
class CatalogueItem extends StatefulWidget {
  final Product item;

  CatalogueItem({Key key, @required this.item}) : super(key: key);

  @override
  _CatalogueItemState createState() => _CatalogueItemState();
}

class _CatalogueItemState extends State<CatalogueItem> {
  bool addedToCart;

  @override
  void initState() {
    super.initState();
    addedToCart = widget.item.addedToCart;
  }

  void toggleAddedToCart(Product item) {
    setState((){
      addedToCart = !addedToCart;
      item.addedToCart = addedToCart;
    });
  }

  @override
  Widget build(BuildContext context) {
    final formatDecimal = new NumberFormat("###.0#", "en_US");
//    final cart = Provider.of<Cart>(context, listen: false);
    return Padding(
      padding:
      const EdgeInsets.only(top: 5.0, left: 13.0, right: 13.0, bottom: 5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: new BorderRadius.circular(15.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.1),
              blurRadius: 3.5,
              spreadRadius: 0.4,
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => ProductDetail(widget.item),
              ),
            );
          },
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
            leading: CachedNetworkImage(
              width: 100,
              height: 100,
              imageUrl: '${widget.item.productPhoto}',
              placeholder: (context, url) => Center(
                child: SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00AB50)),
                    strokeWidth: 2.0,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            title: Container(
              height: 100,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    /// title, origin, price
                    Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.item.title,
                            style: TextStyle(
                                fontFamily: "Gotik",
                                fontWeight: FontWeight.w400,
                                fontSize: 13.0),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Text(
                            "${formatDecimal.format(widget.item.price)} c",
                            style: TextStyle(
                                fontFamily: "Gotik",
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),

                    /// add to favourite iconButton
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: () {
                            widget.item.toggleFavoriteStatus();
                          },
                          icon: Icon(widget.item.isFavourite
                              ? CupertinoIcons.heart_solid
                              : CupertinoIcons.heart),
                          color: Color(0xFF00AB50),
                          iconSize: 25.0,
                        ),
                      ),
                    ),
                  ]),
            ),
            subtitle: Row(
              children: <Widget>[
                /// item counter
                Container(
                  width: 120.0,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.black12.withOpacity(0.1),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      /// Decrease of value item
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (widget.item.quantity != widget.item.measureStep)
                              widget.item.quantity -= widget.item.measureStep;
                          });
                        },
                        child: Container(
                          height: 30.0,
                          width: 20.0,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Colors.black12.withOpacity(0.1),
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "-",
                              style: TextStyle(
                                fontFamily: "Gotik",
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00AB50),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          "${formatDecimal.format(widget.item.quantity)} ${widget.item.measure}",
                          style: TextStyle(
                            fontFamily: "Gotik",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      /// Increasing value of item
                      InkWell(
                        onTap: () {
                          setState(() {
                            widget.item.quantity += widget.item.measureStep;
                          });
                        },
                        child: Container(
                          height: 20.0,
                          width: 20.0,
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: Colors.black12.withOpacity(0.1),
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "+",
                              style: TextStyle(
                                fontFamily: "Gotik",
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00AB50),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.10),

                /// add to cart iconButton
                Container(
                    width: 60.0,
                    height: 35.0,
                    decoration: BoxDecoration(
                      color: addedToCart
                          ? Color(0xFFaddfad)
                          : Color(0xFF00AB50),
                      borderRadius: BorderRadius.circular(25.0),
                      border: Border.all(
                          color: addedToCart ? Color(0xFF00AB50) : Colors.transparent),
                    ),
                    child: IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: Icon(Icons.shopping_basket),
                      color: addedToCart ? Color(0xFF00AB50) : Colors.white,
                      iconSize: 20.0,
                      onPressed: () {
//                        addedToCart
//                            ? cart.removeItem(widget.item.id)
//                            : cart.addItem(
//                            widget.item.id,
//                            widget.item.title,
//                            widget.item.price,
//                            widget.item.description,
//                            widget.item.measure,
//                            widget.item.quantity,
//                            widget.item.measureStep,
//                            widget.item.imageUrl);
//                        setState((){
//                          toggleAddedToCart(widget.item);
//                        });
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
