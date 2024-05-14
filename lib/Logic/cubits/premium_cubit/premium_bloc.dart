import 'package:dating/Logic/cubits/onBording_cubit/onbording_state.dart';
import 'package:dating/Logic/cubits/premium_cubit/premium_state.dart';
import 'package:dating/core/api.dart';
import 'package:dating/core/config.dart';
import 'package:dating/data/models/paymentmodel.dart';
import 'package:dating/data/models/premiummodel.dart';
import 'package:dating/presentation/screens/BottomNavBar/bottombar.dart';
import 'package:dating/presentation/screens/BottomNavBar/homeProvider/homeprovier.dart';
import 'package:dating/presentation/screens/other/premium/premium_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class PremiumBloc extends Cubit<PremiumState>{
  PremiumBloc() : super(PremiumInit());

  final Api _api = Api();

  Future<PremiumModel> planDataApi(context) async {
    Map data = {
      "uid": Provider.of<HomeProvider>(context,listen: false).uid,
    };
    try{
      Response response = await _api.sendRequest.post("${Config.baseUrlApi}${Config.plan}",data: data);
      PremiumModel premiumModel  = PremiumModel.fromJson(response.data);
      if(response.statusCode == 200){
        if(response.data["Result"] == "true"){


          return premiumModel;
        }else{
          emit(PremiumError(response.data["ResponseMsg"]));
          return premiumModel;
        }
      }else{
        emit(PremiumError(response.data["ResponseMsg"]));
        return premiumModel;
      }
    }catch(e){
      emit(PremiumError(e.toString()));
     rethrow;
    }
  }
  Future<PaymentModel> paymentGateway(context) async {
    try{
      Response response = await _api.sendRequest.get("${Config.baseUrlApi}${Config.paymentGateway}");
      PaymentModel premiumModel  = PaymentModel.fromJson(response.data);
      if(response.statusCode == 200){
        if(response.data["Result"] == "true"){
         return premiumModel;
        }else{
          emit(PremiumError(response.data["ResponseMsg"]));
          return premiumModel;
        }
      }else{
        emit(PremiumError(response.data["ResponseMsg"]));
        return premiumModel;
      }
    }catch(e){
      emit(PremiumError(e.toString()));
    rethrow;
    }
  }

  Future planPurchase({required String planId,required String tranID,required String pname,required String pMethodId,required context})async{
    Map data = {
      "plan_id" : planId,
      "transaction_id" : tranID,
      "uid": Provider.of<HomeProvider>(context,listen: false).uid,
      "pname" : pname,
      "p_method_id" : pMethodId
    };
    try{
      Response response = await _api.sendRequest.post("${Config.baseUrlApi}${Config.planPurchase}",data: data);

      if(response.statusCode == 200){
        if(response.data["Result"] == "true"){
          Provider.of<HomeProvider>(context,listen: false).setSelectPage(0);
          Fluttertoast.showToast(msg: response.data["ResponseMsg"]);
          Navigator.pushNamedAndRemoveUntil(context, BottomBar.bottomBarRoute, (route) => false);
        }else{
          Fluttertoast.showToast(msg: response.data["ResponseMsg"]);
          Navigator.pop(context);
        }
      }
    }catch(e){
      emit(PremiumError(e.toString()));
    }
  }


  completeApi(List<PlanDatum> planData, List<Paymentdatum> paymet){
    emit(PremiumComplete(planData,paymet));
  }



}