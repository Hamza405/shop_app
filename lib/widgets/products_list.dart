import 'package:flutter/material.dart';
import 'package:max_cours_shop_app/providers/products_provider.dart';
import 'package:max_cours_shop_app/widgets/category_list.dart';
import 'package:max_cours_shop_app/widgets/list_view_item.dart';
import 'package:max_cours_shop_app/widgets/product_item.dart';
import 'package:max_cours_shop_app/widgets/title_with_btn.dart';
import 'package:provider/provider.dart';

class ProductsList extends StatelessWidget {
  final bool _showFavorite;
  ProductsList(this._showFavorite);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final _products = productsData.items;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:20,top: 10),
              child: Row(
                children: [
                  TitleWithCustomUnderline(text: 'Categories',),
                ],
              ),
            ),
            SizedBox(height:15),
            CategoriesListView(),
            SizedBox(height:15),
            TitleWithMoreBtn(
              title: 'Used Products',
            ),
            Container(
              width: double.infinity,
              height: 250,
              child: ListView.separated(
                padding: EdgeInsets.all(16),
                scrollDirection: Axis.horizontal,
                itemCount: _products.length,
                separatorBuilder: (context, index) => SizedBox(
                  width: 10,
                ),
                itemBuilder: (context, index) => ChangeNotifierProvider.value(
                  value: _products[index],
                  child: ListViewItem(),
                ),
              ),
            ),
            TitleWithMoreBtn(
              title: 'New Products',
            ),
            Container(
              width: double.infinity,
              height: 250,
              child: ListView.separated(
                padding: EdgeInsets.all(16),
                scrollDirection: Axis.horizontal,
                itemCount: _products.length,
                separatorBuilder: (context, index) => SizedBox(
                  width: 10,
                ),
                itemBuilder: (context, index) => ChangeNotifierProvider.value(
                  value: _products[index],
                  child: ListViewItem(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
