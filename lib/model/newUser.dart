
class NewUser{
 String? userFirstname;
 String? userLastname;
 String? userMiddlename;
 String? username;
 String? email;
 String? phoneNumber;
 bool? isActive;
 String? createdAt;
 String? createdBy;
 int? channelId;
 int? zoneId;
 int? posId;
 int? region;
 int? city;
 String? township;
 int? distributionTypeId;
 NewUser({this.userFirstname,this.userLastname,this.userMiddlename,this.email,
 this.username, this.phoneNumber, this.isActive, this.createdAt, this.createdBy,
  this.channelId, this.zoneId, this.posId, this.region,
  this.city, this.township, this.distributionTypeId});

 factory NewUser.fromJson(Map<String, dynamic> json){
  return NewUser(
   userFirstname: json['userFirstname'],
   userLastname: json['userLastname'],
   userMiddlename: json['userMiddlename'],
   username: json['userName'],
   email: json['email'],
   phoneNumber: json['phoneNumber'],
   isActive: json['isActive'],
   createdAt: json['createdAt'],
   createdBy: json['createdBy'],
   channelId: json['channelId'],
   zoneId: json['zoneId'],
   region: json['region'],
   city: json['city'],
   township: json['township'],
   distributionTypeId: json['distributionTypeId']
  );
 }


 Map<String,dynamic> toMap(){
  return {
  'userFirstname':userFirstname,
  'userLastname':userLastname,
  'userMiddlename':userMiddlename,
   'userName':username,
   'email':email,
   'phoneNumber':phoneNumber,
  'isActive':isActive,
  'createdAt':createdAt,
  'createdBy':createdBy,
  'channelId':channelId,
  'zoneId':zoneId,
  'posId':posId,
  'region':region,
  'city':city,
   'township':township,
  'distributionTypeId':distributionTypeId
  };
 }

 static Future<List<NewUser>> newUsersfromJson(List<dynamic> data) async {
  return data.map((element) => NewUser.fromJson(element)).toList();
 }

}