class User {
  String? id;
  String? name;
  String? firstname;
  String? username;
  String? email;
  String? phone;
  String? access_token;
  List<String>? roles;
  String? status;
  String? refresh_token;
  String? zoneId;

  User(
      {this.id,
      this.name,
      this.firstname,
      this.username,
      this.email,
      this.phone,
      this.access_token,
      this.roles,
      this.status,
      this.refresh_token,
      this.zoneId});

  static User empty() => User.fromJson(null, {});

  User.fromJson(String? id, Map<String, dynamic> data) {
    this.id = id;
    if (data.containsKey('id')) {
      this.id = "${data['id']}";
    }
    if (data.containsKey('sub')) {
      this.id = "${data['sub']}";
    }
    if (data.containsKey('family_name')) {
      name = data['family_name'];
    }
    if (data.containsKey('given_name')) {
      firstname = data['given_name'];
    }

    if (data.containsKey('roles')) {
      roles = List.from(data['roles']);
    }
    if (data.containsKey('status')) {
      status = data['status'];
    }
    if (data.containsKey('access_token')) {
      access_token = data['access_token'];
    }
    if (data.containsKey('refresh_token')) {
      refresh_token = data['refresh_token'];
    }
    if (data.containsKey('email')) {
      email = data['email'];
    }
    if (data.containsKey('name')) {
      username = data['name'];
    }
    if (data.containsKey('phone')) {
      phone = data['phone'];
    }
    if (data.containsKey('zoneId')) {
      zoneId = data['zoneId'];
    }
  }

  User.fromJson2(String? id, Map<String, dynamic> data) {
    this.id = id;
    if (data.containsKey('id')) {
      this.id = "${data['id']}";
    }
    if (data.containsKey('name')) {
      name = data['name'];
    }
    if (data.containsKey('firstname')) {
      firstname = data['firstname'];
    }
    if (data.containsKey('roles')) {
      roles = List.from(data['roles']);
    }
    if (data.containsKey('status')) {
      status = data['status'];
    }
    if (data.containsKey('access_token')) {
      access_token = data['access_token'];
    }
    if (data.containsKey('refresh_token')) {
      refresh_token = data['refresh_token'];
    }
    if (data.containsKey('email')) {
      email = data['email'];
    }
    if (data.containsKey('username')) {
      username = data['username'];
    }
    if (data.containsKey('phone')) {
      phone = data['phone'];
    }
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "firstname": firstname,
      "email": email,
      "username": username,
      "phone": phone,
      "roles": roles,
      "status": status,
      "refresh_token": refresh_token,
    };
  }

  @override
  String toString() {
    return 'User{id: $id,firstname: $firstname, name: $name,username: $username, email: $email, phone: $phone, status: $status, token: $access_token, refresh_token: $refresh_token}';
  }
}
