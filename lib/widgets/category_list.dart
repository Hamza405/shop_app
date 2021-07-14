import 'package:flutter/material.dart';

class CategoriesListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(25), // if you need this
    side: BorderSide(
      color: Colors.grey.withOpacity(0.2),
      width: 1,
    ),
  ),
      elevation: 5,
      shadowColor: Theme.of(context).primaryColor,
          child: Container(
        padding: EdgeInsets.only(left:5),
        height: 75,
        width: double.infinity,
        child: ListView(
          
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
              height: 15,
              child: Center(child: Image.asset('assets/categories/devices.png',fit: BoxFit.cover,height: 50,width: 50,)),
            ),
            SizedBox(width: 25),
            Container(
              height: 15,
              child: Center(child: Image.asset('assets/categories/Gaming.png',fit: BoxFit.cover,height: 50,width: 50,)),
            ),
            SizedBox(width: 25),
            Container(
              height: 15,
              child:
                  Center(child: Image.asset('assets/categories/headphone.png',fit: BoxFit.cover,height: 50,width: 50,)),
            ),
            SizedBox(width: 25),
            Container(
              height: 15,
              child: Center(child: Image.asset('assets/categories/shoes.png',fit: BoxFit.cover,height: 50,width: 60,)),
            ),
            SizedBox(width: 25),
            Container(
              height: 15,
              child: Center(child: Image.asset('assets/categories/women.png',height: 50,width: 50,)),
            ),
          ],
        ),
      ),
    );
  }
}
