enum OtpType {
  accountSetup('account_setup'),
  passwordReset('password_reset');

  const OtpType(this.value);
  final String value;
}
