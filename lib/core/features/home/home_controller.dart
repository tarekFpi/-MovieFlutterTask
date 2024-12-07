
import 'package:basie_project/core/features/home/model/MovieResponse.dart';
import 'package:basie_project/core/features/network/dio_client.dart';
import 'package:basie_project/core/features/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with StateMixin<List<Search>> {

  final dioClient = DioClient.instance;

  final movieList = <Search>[].obs;


  Future<void> showMovielist() async{

    try {

      change(null, status: RxStatus.loading());

      final res = await dioClient.get("/?apikey=e54276c0&s=movie");

      final  response = MovieResponse.fromJson(res);

      if(response.search!=null){

        final list = response.search ?? [];

        movieList.assignAll(list);

        change(movieList, status: RxStatus.success());



        if(movieList.isEmpty){

          change(null, status: RxStatus.empty());
        }

      }else {

        Toast.errorToast("Data Not Found..");

      }

    } catch(e) {

      Toast.errorToast("${e.toString()}");

      debugPrint(e.toString());

      change(null, status: RxStatus.error(e.toString()));
    }
  }


  void filterMovie(String? query) {

    change(null, status: RxStatus.loading());

    if (query == null || query.isEmpty) {

      change(movieList.value, status: RxStatus.success());

    }else{

      try{

        debugPrint("result:${query}");

        final list = movieList.value
            .where((element) =>
            element.year!
                .toLowerCase()
                .contains(query!.toLowerCase().trim())
        ).toList();

        if(list.isEmpty){

          change([], status: RxStatus.empty());

        }else {
          change(list, status: RxStatus.success());
        }

      }catch(e){

        debugPrint(e.toString());
      }
    }

  }
}