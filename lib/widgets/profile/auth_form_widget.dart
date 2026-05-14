import 'package:brublaapp/widgets/profile/auth_field_widget.dart';
import 'package:brublaapp/widgets/profile/profile_type_widget.dart';
import 'package:brublaapp/widgets/profile/section_label_widget.dart';
import 'package:flutter/material.dart';

class AuthFormView extends StatelessWidget {
  final ProfileType profileType;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final bool isPasswordVisible;
  final bool isLoading;
  final VoidCallback onTogglePassword;
  final VoidCallback onSubmit;

  const AuthFormView({
    super.key,
    required this.profileType,
    required this.emailController,
    required this.passwordController,
    required this.nameController,
    required this.isPasswordVisible,
    required this.isLoading,
    required this.onTogglePassword,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Center(
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(profileType.icon, color: Colors.white, size: 34),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: Text(
            'Register as ${profileType.label}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              letterSpacing: -0.5,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            profileType.description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ),
        const SizedBox(height: 12),
        if (profileType.requiresApproval) ...[
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.amber[50],
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.amber[200]!, width: 1.2),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, color: Colors.amber[700], size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'This profile type requires admin approval. Once you submit your details, our team will review your application.',
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Colors.amber[900],
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
        ] else
          const SizedBox(height: 28),
        const SectionLabel(label: 'YOUR DETAILS'),
        const SizedBox(height: 14),
        AuthField(
          controller: nameController,
          label: 'Full Name',
          icon: Icons.person_outline,
          keyboardType: TextInputType.name,
        ),
        const SizedBox(height: 14),
        AuthField(
          controller: emailController,
          label: 'Email Address',
          icon: Icons.mail_outline,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 14),
        AuthField(
          controller: passwordController,
          label: 'Password',
          icon: Icons.lock_outline,
          obscureText: !isPasswordVisible,
          suffixIcon: GestureDetector(
            onTap: onTogglePassword,
            child: Icon(
              isPasswordVisible
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: Colors.black45,
              size: 20,
            ),
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isLoading ? null : onSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.black54,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: 0,
            ),
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    profileType.requiresApproval
                        ? 'Submit for Approval'
                        : 'Create Account',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 48),
      ],
    );
  }
}