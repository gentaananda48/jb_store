class User {
  final int id;
  final String email;
  final String username;
  final String password;
  final Name name;
  final Address address;
  final String phone;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.address,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      name: Name.fromJson(json['name'] ?? {}),
      address: Address.fromJson(json['address'] ?? {}),
      phone: json['phone'] ?? '',
    );
  }
}

class Name {
  final String firstname;
  final String lastname;

  Name({required this.firstname, required this.lastname});

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
    );
  }
}

class Address {
  final String city;
  final String street;
  final int number;
  final String zipcode;
  final Geolocation geolocation;

  Address({
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
    required this.geolocation,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city'] ?? '',
      street: json['street'] ?? '',
      number: json['number'] ?? 0,
      zipcode: json['zipcode'] ?? '',
      geolocation: Geolocation.fromJson(json['geolocation'] ?? {}),
    );
  }
}

class Geolocation {
  final String lat;
  final String long;

  Geolocation({required this.lat, required this.long});

  factory Geolocation.fromJson(Map<String, dynamic> json) {
    return Geolocation(
      lat: json['lat'] ?? '0.0',
      long: json['long'] ?? '0.0',
    );
  }
}
