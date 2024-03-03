import 'package:flutter/material.dart';


import 'color.dart';


class Choice {
  const Choice({required this.title, required this.icon});
  final String title;
  final IconData icon;

}
List<dynamic>devices=[];



class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.secondColor,

        title: Text(
          'electrioinc devices',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),

        ),
      ),
      backgroundColor: AppColor.primeColor,
      body:GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal,
            child: Column(
              children: [
                Expanded(
                  child: Container(width:300 ,
                      height: 300,
                      child: Image.network('https://etisal-storeapi.witheldokan.com/storage/uploads/iphone-13-blue-select-2021_1_1_1.png',fit:BoxFit.scaleDown)),
                ),
                Text('Apple Iphone 12 Pro Max 256 GB 6 G',maxLines: 1,style: TextStyle(
                    fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                    Text('25000 EGP ',style: TextStyle(
                        color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),)
                    ,
                    Spacer(
                      flex: 1,

                    ) ,
                    Icon(Icons.favorite)
                  ]
                    ,),
                )
              ],
            )
          ),
          Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal,
              child: Column(
                children: [
                  Expanded(
                    child: Container(width:300 ,
                        height: 300,
                        child: Image.network('https://etisal-storeapi.witheldokan.com/storage/uploads/iphone-13-blue-select-2021_1_1_1.png',fit:BoxFit.scaleDown)),
                  ),
                  Text('Apple Iphone 12 Pro Max 256 GB 6 G',maxLines: 1,style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      Text('25000 EGP ',style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),)
                      ,
                      Spacer(
                        flex: 1,

                      ) ,
                      Icon(Icons.favorite)
                    ]
                      ,),
                  )
                ],
              )
          ),
          Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal,
              child: Column(
                children: [
                  Expanded(
                    child: Container(width:300 ,
                        height: 300,
                        child: Image.network('https://etisal-storeapi.witheldokan.com/storage/uploads/iphone-13-blue-select-2021_1_1_1.png',fit:BoxFit.scaleDown)),
                  ),
                  Text('Apple Iphone 12 Pro Max 256 GB 6 G',maxLines: 1,style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      Text('25000 EGP ',style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),)
                      ,
                      Spacer(
                        flex: 1,

                      ) ,
                      Icon(Icons.favorite)
                    ]
                      ,),
                  )
                ],
              )
          ),
          Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal,
              child: Column(
                children: [
                  Expanded(
                    child: Container(width:300 ,
                        height: 300,
                        child: Image.network('https://etisal-storeapi.witheldokan.com/storage/uploads/iphone-13-blue-select-2021_1_1_1.png',fit:BoxFit.scaleDown)),
                  ),
                  Text('Apple Iphone 12 Pro Max 256 GB 6 G',maxLines: 1,style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      Text('25000 EGP ',style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),)
                      ,
                      Spacer(
                        flex: 1,

                      ) ,
                      Icon(Icons.favorite)
                    ]
                      ,),
                  )
                ],
              )
          ),
          Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal,
              child: Column(
                children: [
                  Expanded(
                    child: Container(width:300 ,
                        height: 300,
                        child: Image.network('https://etisal-storeapi.witheldokan.com/storage/uploads/iphone-13-blue-select-2021_1_1_1.png',fit:BoxFit.scaleDown)),
                  ),
                  Text('Apple Iphone 12 Pro Max 256 GB 6 G',maxLines: 1,style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      Text('25000 EGP ',style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),)
                      ,
                      Spacer(
                        flex: 1,

                      ) ,
                      Icon(Icons.favorite)
                    ]
                      ,),
                  )
                ],
              )
          ),
          Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal,
              child: Column(
                children: [
                  Expanded(
                    child: Container(width:300 ,
                        height: 300,
                        child: Image.network('https://etisal-storeapi.witheldokan.com/storage/uploads/iphone-13-blue-select-2021_1_1_1.png',fit:BoxFit.scaleDown)),
                  ),
                  Text('Apple Iphone 12 Pro Max 256 GB 6 G',maxLines: 1,style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      Text('25000 EGP ',style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),)
                      ,
                      Spacer(
                        flex: 1,

                      ) ,
                      Icon(Icons.favorite)
                    ]
                      ,),
                  )
                ],
              )
          ),
          Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal,
              child: Column(
                children: [
                  Expanded(
                    child: Container(width:300 ,
                        height: 300,
                        child: Image.network('https://etisal-storeapi.witheldokan.com/storage/uploads/iphone-13-blue-select-2021_1_1_1.png',fit:BoxFit.scaleDown)),
                  ),
                  Text('Apple Iphone 12 Pro Max 256 GB 6 G',maxLines: 1,style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      Text('25000 EGP ',style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),)
                      ,
                      Spacer(
                        flex: 1,

                      ) ,
                      Icon(Icons.favorite)
                    ]
                      ,),
                  )
                ],
              )
          ),



        ],
      )
    );
  }
}
