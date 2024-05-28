import 'package:dating/Logic/cubits/match_cubit/match_states.dart';
import 'package:dating/core/config.dart';
import 'package:dating/presentation/screens/BottomNavBar/homeProvider/homeprovier.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../core/api.dart';
import '../../../data/models/favoritelistmodel.dart';
import '../../../data/models/likememodel.dart';
import '../../../data/models/newmatchmodel.dart';
import '../../../data/models/passedmodel.dart';

class MatchCubit extends Cubit<MatchStates> {
  MatchCubit() : super(MatchInitState());

  final Api _api = Api();

  Future<LikeMeModel> likeMeApi(context) async{
    try{
      Map data = {
        "uid": Provider.of<HomeProvider>(context,listen: false).uid,
        "lats": Provider.of<HomeProvider>(context,listen: false).lat,
        "longs": Provider.of<HomeProvider>(context,listen: false).long
      };
      Response response = await _api.sendRequest.post("${Config.baseUrlApi}${Config.likeMe}",data: data);

      if(response.statusCode == 200){
        if(response.data["Result"] == "true"){
          return LikeMeModel.fromJson(response.data);
        }else{
          // emit(MatchErrorState(response.data["Result"]));
          return LikeMeModel.fromJson(response.data);
        }
      }else{
        emit(MatchErrorState(response.data["Result"]));
        return LikeMeModel.fromJson(response.data);
      }
    }catch(e){
      emit(MatchErrorState(e.toString()));
      rethrow;
    }
  }

  Future<FavlistModel> favouriteApi(context) async {
    try{

      Map data = {
        "uid": Provider.of<HomeProvider>(context,listen: false).uid,
        "lats": Provider.of<HomeProvider>(context,listen: false).lat,
        "longs": Provider.of<HomeProvider>(context,listen: false).long
      };

      Response response = await _api.sendRequest.post("${Config.baseUrlApi}${Config.favourite}",data: data);
      if(response.statusCode == 200){
        if(response.data["Result"] == "true"){
          return FavlistModel.fromJson(response.data);
        }else{
          // emit(MatchErrorState(response.data["ResponseMsg"]));
          return FavlistModel.fromJson(response.data);
        }

      }else{

        emit(MatchErrorState(response.data["ResponseMsg"]));
        return FavlistModel.fromJson(response.data);

      }

    }catch(e){

      emit(MatchErrorState(e.toString()));
       rethrow;

    }
  }

  Future<PassedModel> passedApi(context) async{
    try{
      Map data = {
        "uid": Provider.of<HomeProvider>(context,listen: false).uid,
        "lats": Provider.of<HomeProvider>(context,listen: false).lat,
        "longs": Provider.of<HomeProvider>(context,listen: false).long
      };
      Response response = await _api.sendRequest.post("${Config.baseUrlApi}${Config.passed}",data: data);

      if(response.statusCode == 200){
        if(response.data["Result"] == "true"){
          return PassedModel.fromJson(response.data);
        }else{
          // emit(MatchErrorState(response.data["Result"]));
          return PassedModel.fromJson(response.data);
        }
      }else{
        emit(MatchErrorState(response.data["Result"]));
        return PassedModel.fromJson(response.data);
      }
    }catch(e){
      emit(MatchErrorState(e.toString()));
      rethrow;
    }
  }

  Future<NewMatchModel> newMatchApi(context) async{
    try{
      Map data = {
        "uid": Provider.of<HomeProvider>(context,listen: false).uid,
        "lats": Provider.of<HomeProvider>(context,listen: false).lat,
        "longs": Provider.of<HomeProvider>(context,listen: false).long
      };
      Response response = await _api.sendRequest.post("${Config.baseUrlApi}${Config.newMatch}",data: data);

      if(response.statusCode == 200){
        if(response.data["Result"] == "true"){
          return NewMatchModel.fromJson(response.data);
        }else{
          // emit(MatchErrorState(response.data["Result"]));
          return NewMatchModel.fromJson(response.data);
        }
      }else{
        emit(MatchErrorState(response.data["Result"]));
        return NewMatchModel.fromJson(response.data);
      }
    }catch(e){
      emit(MatchErrorState(e.toString()));
      rethrow;
    }
  }

  Future profileLikeDislikeApi(
      {required String uid,
        required String proId,
        required String action,
      }) async {
    //"UNLIKE"
    //"LIKE"
    try {
      Map data = {"uid": uid, "profile_id": proId, "action": action};

      Response response = await _api.sendRequest.post("${Config.baseUrlApi}${Config.likeDislike}", data: data);

      if (response.statusCode == 200) {
        if (response.data["Result"] == "true") {
          return response.data["Result"];
        } else {
          Fluttertoast.showToast(msg: response.data["ResponseMsg"]);
        }
      }
    } catch (e) {
      emit(MatchErrorState(e.toString()));
      rethrow;
    }
  }

  loadingState(){
    emit(MatchLoadingState());
  }

  completeState(passedModel,likeMeModel,newMatchModel,favListModel){
    emit(MatchCompleteState(passedModel,likeMeModel,newMatchModel,favListModel));
  }

}