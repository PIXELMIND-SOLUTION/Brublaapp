import 'package:flutter/material.dart';

enum ProfileType { userProfile, designerProfile, tailorProfile, stylistProfile }

extension ProfileTypeExtension on ProfileType {
  String get label {
    switch (this) {
      case ProfileType.userProfile:
        return 'User Profile';
      case ProfileType.designerProfile:
        return 'Designer Profile';
      case ProfileType.tailorProfile:
        return 'Tailor Profile';
      case ProfileType.stylistProfile:
        return 'Stylist Profile';
    }
  }

  IconData get icon {
    switch (this) {
      case ProfileType.userProfile:
        return Icons.person_outline;
      case ProfileType.designerProfile:
        return Icons.design_services_outlined;
      case ProfileType.tailorProfile:
        return Icons.content_cut_outlined;
      case ProfileType.stylistProfile:
        return Icons.style_outlined;
    }
  }

  String get description {
    switch (this) {
      case ProfileType.userProfile:
        return 'Browse and shop fashion items';
      case ProfileType.designerProfile:
        return 'Create and sell your designs';
      case ProfileType.tailorProfile:
        return 'Offer tailoring services';
      case ProfileType.stylistProfile:
        return 'Provide personal styling advice';
    }
  }

  bool get requiresApproval {
    return this != ProfileType.userProfile;
  }
}