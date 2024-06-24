import 'package:flutter/material.dart';
import 'package:neat/components/color.dart';


class ImageDisplayPage extends StatefulWidget {
  final String imageUrl;

  ImageDisplayPage({super.key, required this.imageUrl});
  @override
  State<ImageDisplayPage> createState() => _ImageDisplayPageState();
}

class _ImageDisplayPageState extends State<ImageDisplayPage> {
  final String imageUrl = 'https://example.com/path/to/your/image.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primeColor,
        leading:  IconButton(
          icon: Icon(Icons.arrow_back , color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}