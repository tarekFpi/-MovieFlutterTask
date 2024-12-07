
import 'package:basie_project/core/features/home/model/MovieResponse.dart';
import 'package:basie_project/core/features/theme/color_scheme.dart';
import 'package:flutter/material.dart';

class SearchDetails extends StatefulWidget {

  final Search movielist;

    SearchDetails({super.key,required this.movielist});

  @override
  State<SearchDetails> createState() => _SearchDetailsState();
}

class _SearchDetailsState extends State<SearchDetails> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        appBar: AppBar(
            leading: const BackButton(
                color: Colors.white
            ),
            backgroundColor:Colors.redAccent,
            elevation: 2,
            centerTitle: true,
            title: Text(
              "Details page",
              style: textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            )
        ),

     body: SingleChildScrollView(
       child: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 12),
         child: Card(
           child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                const SizedBox(
                  height: 12,
                ),

                Image.network("${widget.movielist.poster}",height: 150,width: 300, fit: BoxFit.fill),

                const SizedBox(
                  height: 8,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    SizedBox(

                      child: Text(
                        "title :${widget.movielist.title}",
                        style: textTheme.bodySmall?.copyWith(
                            color: lightColorScheme.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),

                    Text(
                      "year :${widget.movielist.year}",
                      style: textTheme.bodySmall?.copyWith(
                          color: lightColorScheme.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                  ],
                 ),
           ),
         ),
       ),
     ),
    );
  }
}
