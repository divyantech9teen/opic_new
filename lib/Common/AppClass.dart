class DataClass {
  String message;
  String value;
  String statusCode;
  String access_token;
  String otp;
  String accessToken;
  String driverName;
  String phone;
  String email;
  String available;
  List login_response;
  List studio;
  List studioDetail;
  List studioBanner;
  List studioPortfolio;

  List data;

  DataClass(
      {this.message,
        this.value,
        this.data,
        this.statusCode,
        this.accessToken,
        this.driverName,
        this.access_token,
        this.otp,
        this.phone,
        this.available,
        this.login_response,
        this.studio,
        this.studioBanner,
        this.studioDetail,
        this.studioPortfolio,
        this.email});

  factory DataClass.fromJson(Map<String, dynamic> json) {
    return DataClass(
      message: json['message'] as String,
      value: json['status'] as String,
      statusCode: json['responseCode'] as String,
      access_token: json['access_token'] as String,
      otp: json['otp'] as String,
      accessToken: json['accessToken'] as String,
      driverName: json['driver_name'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      login_response: json['login_response'] as List,
      studioBanner: json['studio_slider_banner'] as List,
      studioPortfolio: json['studio_portfolios'] as List,
      available: json['available'] as String,
      data: json['data'] as List,
    );
  }
}
