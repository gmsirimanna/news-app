class LoginResponse {
  String accessToken;
  String tokenType;
  Tenant tenant;

  LoginResponse({this.accessToken, this.tokenType, this.tenant});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    tenant = json['tenant'] != null ? Tenant.fromJson(json['tenant']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    if (tenant = null) {
      data['tenant'] = tenant.toJson();
    }
    return data;
  }
}

class Tenant {
  int id;
  String firstName;
  String middleName;
  String lastName;
  String dateOfBirth;
  String gender;
  int nationalityId;
  String passportNo;
  String email;
  String emailOptional;
  String companyName;
  String companyContact;
  String compnayTaxId;
  String phone;
  String phoneOptional;
  int provinceId;
  int cityId;
  String tenantImg;

  Tenant(
      {this.id,
      this.firstName,
      this.middleName,
      this.lastName,
      this.dateOfBirth,
      this.gender,
      this.nationalityId,
      this.passportNo,
      this.email,
      this.emailOptional,
      this.companyName,
      this.companyContact,
      this.compnayTaxId,
      this.phone,
      this.phoneOptional,
      this.provinceId,
      this.cityId,
      this.tenantImg});

  Tenant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    nationalityId = json['nationality_id'];
    passportNo = json['passport_no'];
    email = json['email'];
    emailOptional = json['email_optional'];
    companyName = json['company_name'];
    companyContact = json['company_contact'];
    compnayTaxId = json['compnay_tax_id'];
    phone = json['phone'];
    phoneOptional = json['phone_optional'];
    provinceId = json['province_id'];
    cityId = json['city_id'];
    tenantImg = json['tenant_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['date_of_birth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['nationality_id'] = this.nationalityId;
    data['passport_no'] = this.passportNo;
    data['email'] = this.email;
    data['email_optional'] = this.emailOptional;
    data['company_name'] = this.companyName;
    data['company_contact'] = this.companyContact;
    data['compnay_tax_id'] = this.compnayTaxId;
    data['phone'] = this.phone;
    data['phone_optional'] = this.phoneOptional;
    data['province_id'] = this.provinceId;
    data['city_id'] = this.cityId;
    data['tenant_img'] = this.tenantImg;
    return data;
  }
}
