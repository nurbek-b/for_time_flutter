import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/categories.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/Categories/miniSubCategoryPage.dart';

class CategoriesScreen extends StatefulWidget {
  static String routeName = "/allCategories";
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int _selectedCat = 0;
  int selected = null;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit){
      Provider.of<Categories>(context).fetchAndSetCategories();
      Provider.of<Products>(context).fetchAndSetProducts();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<Categories>(context).categories;
    final productsData = Provider.of<Products>(context).items;
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 35.0,),
            Text(
              "Все котегории",
              style: Theme.of(context)
                  .textTheme
                  .display1
                  .copyWith(fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)),
            ),
            SizedBox(height: 15),
            Expanded(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 50,
                    margin: const EdgeInsets.only(right: 15),
                    child: ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (ctx, i) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCat = i;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 25.0),
                            // padding: const EdgeInsets.symmetric(vertical: 45.0),
                            width: 50,
                            constraints: BoxConstraints(minHeight: 101),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: _selectedCat == i ? Border.all() : Border(),
                              color: _selectedCat == i
                                  ? Colors.transparent
                                  : Color(0xFF1B5E20),
                              borderRadius: BorderRadius.circular(9.0),
                            ),
                            // child: Transform.rotate(
                            //   angle: -pi / 2,
                            child: RotatedBox(
                              quarterTurns: -1,
                              child: Text(
                                "${categories[i].title}",
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    .copyWith(
                                    color: _selectedCat == i
                                        ? Color(0xFF1B5E20)
                                        : Colors.white),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      /// List of middleCategory
                      child: categories.length == 0
                          ? SizedBox()
                          : ListView.builder(
                        key: Key('builder ${selected.toString()}'),
                        itemCount: categories[_selectedCat].children.length,
                        itemBuilder: (ctx, index) {
                          return Container(
                            padding: const EdgeInsets.all(9.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: ListTileTheme(
                              iconColor: Color(0xFF00AB50),
                              selectedColor: Color(0xFF00AB50),
                              dense: true,
                              child: ExpansionTile(
                                key: Key(index.toString()), /// Attention
                                initiallyExpanded : index==selected, /// Attention
                                onExpansionChanged: ((newState){
                                  if(newState)
                                    setState(() {
                                      Duration(seconds:  20000);
                                      selected = index;
                                    });
                                  else setState(() {
                                    selected = -1;
                                  });
                                }),
                                title: Text(
                                  "${categories[_selectedCat].children[index].title}",
                                  style: TextStyle(
                                    fontFamily: "Gotik",
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,),),
                                /// List of miniCategory
                                children: <Widget>[
                                  Container(child: GestureDetector(
                                      child: ListTile(
                                        leading: Text("Все продукты",
                                          style: TextStyle(
                                            fontFamily: "Gotik",
                                            fontWeight: FontWeight.w400,),),
                                        onTap: (){
                                          List<Product> items = [];
                                          categories[_selectedCat].children[index].children.forEach((element){
                                            items.addAll(productsData.where((e) => e.category == element.id.toString()));
                                          });
                                        },))),
                                  Divider(),
                                  ListView.separated(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: categories[_selectedCat].children[index].children.length,
                                    itemBuilder: (ctx, ind){
                                      return GestureDetector(
                                        onTap: (){
                                          Navigator.of(context, rootNavigator: false).push(
                                            MaterialPageRoute(
                                                builder: (context) => Catalogue(
                                                    children: categories[_selectedCat].children[index]),
                                                maintainState: false),
                                          );
                                        },
                                        child: ListTile(
                                          leading: Text(categories[_selectedCat].children[index].children[ind].title,
                                            style: TextStyle(
                                              fontFamily: "Gotik",
                                              fontWeight: FontWeight.w400,
                                            ),),
                                        ),
                                      );},
                                    separatorBuilder: (context, index) {
                                      return Divider();},
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

