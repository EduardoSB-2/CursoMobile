import 'dart:io';

import 'package:cine_favorite/controllers/movie_firestore_controller.dart';
import 'package:cine_favorite/models/movie_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cine_favorite/views/search_movie_view.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  // atributo
  final _movieFireStoreController = MovieFirestoreController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filmes Favoritos"),
        actions: [
          IconButton(
            onPressed: FirebaseAuth.instance.signOut, 
            icon: Icon(Icons.logout))
        ],
      ),
      //criar uma gridView com os filmes favoritos
      body: StreamBuilder<List<Movie>>(
        stream: _movieFireStoreController.getFavoriteMovies()      , 
        builder: (context, snapshot){
          //se deu erro
          if(snapshot.hasError) {
            return Center(child: Text("Erro ao Carregar a Lista de Favoritos"),);
          }
          // enquanto carrega a lista
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }
          //quando a lista esta vazia
          if(snapshot.data!.isEmpty){
            return Center(child: Text("Nenhum filme adiocionado aos favoritos"),);
          }
          // a contrução da Lista
          final favoriteMovies = snapshot.data!;
          return GridView.builder(
            padding: EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.7,),
            itemCount: favoriteMovies.length,
            itemBuilder: (context, index){
                final movie = favoriteMovies[index];
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(child:
                      GestureDetector(
                        onLongPress: () async {
                          _movieFireStoreController.removeFavoriteMovie(movie.id);
                        },
                        child: Image.file(
                        File(movie.posterPath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                    // titulo do filme
                    Padding(padding: EdgeInsets.all(8),
                    child: Text(movie.title),),
                      
                      //Nota do filme
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemSize: 20.0,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ),



                      //remover o fime favoritos
                       ElevatedButton(
                         onPressed: () async {
                           _movieFireStoreController.removeFavoriteMovie(movie.id);
                         },
                         child: Text("Remover"),
                       ),

                    ],
                  ),
                );

              });

        }),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> Navigator.push(context,
          MaterialPageRoute(builder: (context)=>SearchMovieView())),
        child: Icon(Icons.search),),
    );
  }
}