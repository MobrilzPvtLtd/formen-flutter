class EditProfileState {}

class EditInitState extends EditProfileState {}

class EditLoadingState extends EditProfileState {}

class EditInnerLoadingState extends EditProfileState {}

class EditInerLoadingState extends EditProfileState {}

class EditDataTransfer extends EditProfileState {}

class EditSuccess extends EditProfileState {}

class EditComplete extends EditProfileState {}

class EditErrorState extends EditProfileState {
  String error;
  EditErrorState(this.error);
}
