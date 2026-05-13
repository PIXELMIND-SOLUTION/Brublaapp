// class UserProfileModel {
//   final String id;
//   final String name;
//   final String email;
//   final String mobile;
//   final String role;
//   final String about;
//   final bool isVerified;
//   final List<dynamic> wishlist;
//   final List<dynamic> notifications;
//   final List<dynamic> addresses;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;

//   const UserProfileModel({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.mobile,
//     required this.role,
//     this.about = '',
//     this.isVerified = false,
//     this.wishlist = const [],
//     this.notifications = const [],
//     this.addresses = const [],
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory UserProfileModel.fromJson(Map<String, dynamic> json) {
//     return UserProfileModel(
//       id: json['_id'] as String? ?? '',
//       name: json['name'] as String? ?? '',
//       email: json['email'] as String? ?? '',
//       mobile: json['mobile'] as String? ?? '',
//       role: json['role'] as String? ?? '',
//       about: json['about'] as String? ?? '',
//       isVerified: json['isVerified'] as bool? ?? false,
//       wishlist: List<dynamic>.from(json['wishlist'] ?? []),
//       notifications: List<dynamic>.from(json['notifications'] ?? []),
//       addresses: List<dynamic>.from(json['addresses'] ?? []),
//       createdAt: json['createdAt'] != null
//           ? DateTime.tryParse(json['createdAt'] as String)
//           : null,
//       updatedAt: json['updatedAt'] != null
//           ? DateTime.tryParse(json['updatedAt'] as String)
//           : null,
//     );
//   }

//   Map<String, dynamic> toJson() => {
//     '_id': id,
//     'name': name,
//     'email': email,
//     'mobile': mobile,
//     'role': role,
//     'about': about,
//     'isVerified': isVerified,
//     'wishlist': wishlist,
//     'notifications': notifications,
//     'addresses': addresses,
//     if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
//     if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
//   };

//   Map<String, dynamic> toUpdateJson() => {
//     'name': name,
//     'email': email,
//     'about': about,
//   };

//   UserProfileModel copyWith({
//     String? id,
//     String? name,
//     String? email,
//     String? mobile,
//     String? role,
//     String? about,
//     bool? isVerified,
//     List<dynamic>? wishlist,
//     List<dynamic>? notifications,
//     List<dynamic>? addresses,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//   }) {
//     return UserProfileModel(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       email: email ?? this.email,
//       mobile: mobile ?? this.mobile,
//       role: role ?? this.role,
//       about: about ?? this.about,
//       isVerified: isVerified ?? this.isVerified,
//       wishlist: wishlist ?? this.wishlist,
//       notifications: notifications ?? this.notifications,
//       addresses: addresses ?? this.addresses,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//     );
//   }

//   @override
//   String toString() => 'UserProfileModel(id: $id, name: $name, email: $email)';
// }















class UserProfileModel {
  final String id;
  final String name;
  final String email;
  final String mobile;
  final String role;
  final String about;
  final String profileImage;
  final bool isVerified;
  final List<dynamic> wishlist;
  final List<dynamic> notifications;
  final List<dynamic> addresses;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.role,
    this.about = '',
    this.profileImage = '', 
    this.isVerified = false,
    this.wishlist = const [],
    this.notifications = const [],
    this.addresses = const [],
    this.createdAt,
    this.updatedAt,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      mobile: json['mobile'] as String? ?? '',
      role: json['role'] as String? ?? '',
      about: json['about'] as String? ?? '',
      profileImage: json['profileImage'] as String? ?? '', 
      isVerified: json['isVerified'] as bool? ?? false,
      wishlist: List<dynamic>.from(json['wishlist'] ?? []),
      notifications: List<dynamic>.from(json['notifications'] ?? []),
      addresses: List<dynamic>.from(json['addresses'] ?? []),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'email': email,
        'mobile': mobile,
        'role': role,
        'about': about,
        'profileImage': profileImage, 
        'isVerified': isVerified,
        'wishlist': wishlist,
        'notifications': notifications,
        'addresses': addresses,
        if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
        if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
      };

  Map<String, dynamic> toUpdateJson() => {
        'name': name,
        'email': email,
        'about': about,
      };

  UserProfileModel copyWith({
    String? id,
    String? name,
    String? email,
    String? mobile,
    String? role,
    String? about,
    String? profileImage, 
    bool? isVerified,
    List<dynamic>? wishlist,
    List<dynamic>? notifications,
    List<dynamic>? addresses,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      role: role ?? this.role,
      about: about ?? this.about,
      profileImage: profileImage ?? this.profileImage, 
      isVerified: isVerified ?? this.isVerified,
      wishlist: wishlist ?? this.wishlist,
      notifications: notifications ?? this.notifications,
      addresses: addresses ?? this.addresses,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() =>
      'UserProfileModel(id: $id, name: $name, email: $email, profileImage: $profileImage)';
}