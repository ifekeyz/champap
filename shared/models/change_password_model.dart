class ChangePasswordModel {
  String? oldPassword;
  String? newPassword;
  String? confirmPassword;

  ChangePasswordModel(
      {this.oldPassword, this.newPassword, this.confirmPassword});
}
