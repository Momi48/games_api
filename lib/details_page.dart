
import 'package:flutter/material.dart';
import 'package:quotes_api/colors.dart';

class DetailsPage extends StatefulWidget {
  final String imageUrl;
  final String desc;
  final String pub;
  final String dev;
  final String rel;
 
  final VoidCallback onTap;

 const  DetailsPage({
    super.key,
    required this.imageUrl,
    required this.desc,
    required this.pub,
    required this.dev,
    required this.rel,
   
    required this.onTap,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyDark,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          'Games Details Page',
          style: text,
        ),
        centerTitle: true,
        backgroundColor: greyDark,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.fill,
                  
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Overview',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text('Description: ${widget.desc}', style: text),
            Text('Release Date: ${widget.rel}', style: text),
            Text('Publisher: ${widget.pub}', style: text),
            Text('Developers: ${widget.dev}', style: text),
          
            const SizedBox(height: 10),
            Center(
              child: Container(
                height: 50,
                width: 230,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                 color: Colors.amber
                ),
                child: GestureDetector(
                  onTap:  widget.onTap,
                  child: const  Center(
                   child: Text('Official Website ',style: text,),),
                  ),
                ),
              ),
          ]
            ),
            
          
          
        ),
        
      );
      
    
  }
}
