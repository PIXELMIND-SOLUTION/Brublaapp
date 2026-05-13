class AddressModel {
  final String? id;
  final String fullName;
  final String mobile;
  final String pincode;
  final String address;
  final String city;
  final String state;
  final String type; 
  final String? landmark;
  final bool isDefault;

  const AddressModel({
    this.id,
    required this.fullName,
    required this.mobile,
    required this.pincode,
    required this.address,
    required this.city,
    required this.state,
    required this.type,
    this.landmark,
    this.isDefault = false,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['_id'] as String?,
      fullName: json['fullName'] as String? ?? '',
      mobile: json['mobile'] as String? ?? '',
      pincode: json['pincode'] as String? ?? '',
      address: json['address'] as String? ?? '',
      city: json['city'] as String? ?? '',
      state: json['state'] as String? ?? '',
      type: json['type'] as String? ?? 'home',
      landmark: json['landmark'] as String?,
      isDefault: json['isDefault'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'mobile': mobile,
      'pincode': pincode,
      'address': address,
      'city': city,
      'state': state,
      'type': type,
      if (landmark != null) 'landmark': landmark,
      'isDefault': isDefault,
    };
  }

  AddressModel copyWith({
    String? id,
    String? fullName,
    String? mobile,
    String? pincode,
    String? address,
    String? city,
    String? state,
    String? type,
    String? landmark,
    bool? isDefault,
  }) {
    return AddressModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      mobile: mobile ?? this.mobile,
      pincode: pincode ?? this.pincode,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      type: type ?? this.type,
      landmark: landmark ?? this.landmark,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  String toString() =>
      'AddressModel(id: $id, fullName: $fullName, city: $city, isDefault: $isDefault)';
}