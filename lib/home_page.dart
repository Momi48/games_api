import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:quotes_api/colors.dart';
import 'package:http/http.dart' as http;
import 'package:quotes_api/details_page.dart';
import 'package:quotes_api/games_model.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  List<GamesModel> gamesList = [];
  Future<List<GamesModel>> getGamesAPI() async {
    final response =
        await http.get(Uri.parse('https://www.freetogame.com/api/games'));
          final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
          
          for(Map<String,dynamic> i in data){
              gamesList.add(GamesModel.fromJson(i));
          }
          return gamesList;
          
     } 
     
     else {

      throw 'An Unexpected Error ';
      
    }
        
  }
 List<GamesModel> racingList = [];
  Future<List<GamesModel>> getRacingApi() async {
    final response =
        await http.get(Uri.parse('https://www.freetogame.com/api/games?category=racing'));
          final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
          for(Map<String,dynamic> i in data){
              racingList.add(GamesModel.fromJson(i));
          }
          return racingList;
     } 
     
     else {

      throw 'An Unexpected Error ';
      
    }
        
  }
   void launchUrl(String url) async {
    
    
   
    if(await launch(url)){
      
    }
    else {
      throw "Error 404";
    }
  }

List<GamesModel> fightList = [];
  Future<List<GamesModel>> getFightingApi() async {
    final response =
        await http.get(Uri.parse('https://www.freetogame.com/api/games?category=fighting'));
          final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
          for(Map<String,dynamic> i in data){
              fightList.add(GamesModel.fromJson(i));
          }
          return fightList;
     } 
     
     else {

      throw 'An Unexpected Error ';
      
    }
        
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: greyDark,
      appBar: AppBar(
        title: Image.asset(
          'assets/PlayFusion.png',
          height: 100,
          width: 150,
        ),
        centerTitle: true,
        backgroundColor: greyDark,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
              
             const  Text(
                'Free to Play Games',
                style: text
              ),
             const SizedBox(height: 10,),
              Row(
                children: [
                Expanded(
                  child: FutureBuilder(
                    future: getGamesAPI(),
                    builder: ( context,snapshot) {
        
        if(snapshot.connectionState == ConnectionState.waiting){
           return const Center(child: CircularProgressIndicator.adaptive());
          
        }
        
        if(snapshot.hasError){
          return Text(snapshot.error.toString());
        }
         if (snapshot.data == null || snapshot.data!.isEmpty) {
                return const Center(child: Text("No data available"));
              }
         
           
             return CarouselSlider.builder(
              itemCount: 10,
              itemBuilder: (BuildContext  context, itemIndex, realIndex) {
               final data = snapshot.data![itemIndex];
               final urlLink = data.gameUrl.toString();
               
               return  GestureDetector(
                 onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>
                       DetailsPage(
                       imageUrl: data.thumbnail.toString(),
                       desc: data.shortDescription.toString(),
                       dev: data.developer.toString(),
                       pub: data.publisher.toString(),
                       rel: data.releaseDate.toString(),
                       
                         onTap: (){
                          setState(() {
                            
                          });
                          launchUrl(urlLink.toString()); //link of a game
                          
                        }
                       )
                       
                     )
                     );
                 },
                 child: Card(
                         child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(data.thumbnail.toString(),fit: BoxFit.fill,)
                          )
                     ),
               );
                   //Text(data.title.toString(),style:  text),
                   
               
             }, options: CarouselOptions(
                
        
              autoPlay: true,
              autoPlayAnimationDuration: const Duration(seconds: 3),
              viewportFraction: 0.55,
              enlargeCenterPage: true,
          
              autoPlayCurve: Curves.fastOutSlowIn
             ),
            
             );
             
        
                    }
        
                    ),
                ),
              
              ]
              ),
          
         const Text('Racing Games',style: text,),
         const SizedBox(height: 10,),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: FutureBuilder(
              future: getRacingApi(), builder: (context,snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator.adaptive(),);
                }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: racingList.length,
                itemBuilder: (context,index){
                
                final image = racingList[index];
                final imageUpdatedUrl = image.thumbnail;
                // print("Crossout $");
                final urlLink = image.gameUrl;

                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>
                       DetailsPage(
                       imageUrl: imageUpdatedUrl.toString(),
                       desc: image.shortDescription.toString(),
                       dev: image.developer.toString(),
                       pub: image.publisher.toString(),
                       rel: image.releaseDate.toString(),
                        //link of a game
                         onTap: (){
                          setState(() {
                            
                          });
                          launchUrl(urlLink.toString());
                          
                        }
                       )
                      )
                     );
                    },
                    child: Container(
                      margin:const EdgeInsets.symmetric(horizontal: 8),
                      child: Image.network(imageUpdatedUrl.toString()
                      ),
                    ),
                  );
              });
            }),
          ),
          const SizedBox(height: 10,),
          const Text('Fighting Games',style: text,),
          const SizedBox(height: 10,),

          SizedBox(
            height: 200,
            width: double.infinity,
            child: FutureBuilder(
              future: getFightingApi(), builder: (context,snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator.adaptive(),);
                }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: fightList.length,
                itemBuilder: (context,fightingindex){
                
                final image = fightList[fightingindex];
                final gameUrl = image.gameUrl;
                  return GestureDetector(
                    onTap: (){
                       Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>
                       DetailsPage(
                       imageUrl: image.thumbnail.toString(),
                       desc: image.shortDescription.toString(),
                       dev: image.developer.toString(),
                       pub: image.publisher.toString(),
                       rel: image.releaseDate.toString(),
                       //link of a game
                         onTap: (){
                          setState(() {
                            
                          });
                          launchUrl(gameUrl.toString());
                          
                        }
                       )
                      )
                     );

                    },
                    child: Container(
                      margin:const EdgeInsets.symmetric(horizontal: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(image.thumbnail.toString()
                        )
                        ),
                    ),
                  );
              });
            }),
          )      
        ]
        ),
      ),
    );
  }
}


