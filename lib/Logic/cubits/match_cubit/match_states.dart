import '../../../data/models/favoritelistmodel.dart';
import '../../../data/models/likememodel.dart';
import '../../../data/models/newmatchmodel.dart';
import '../../../data/models/passedmodel.dart';

class MatchStates {}
class MatchInitState extends MatchStates {}
class MatchLoadingState extends MatchStates {}
class MatchErrorState extends MatchStates {
  String error;
  MatchErrorState(this.error);
}
class MatchCompleteState extends MatchStates {
   NewMatchModel newMatchModel;
   FavlistModel favListModel;
   LikeMeModel likeMeModel;
   PassedModel passedModel;
   MatchCompleteState(this.passedModel,this.likeMeModel,this.newMatchModel,this.favListModel);
}