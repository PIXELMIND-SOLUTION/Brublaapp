import 'package:brublaapp/widgets/profile/profile_type_widget.dart';
import 'package:brublaapp/widgets/profile/status_widget.dart';
import 'package:flutter/material.dart';


class ApprovalPendingView extends StatelessWidget {
  final ProfileType profileType;

  const ApprovalPendingView({super.key, required this.profileType});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 60),
        Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(28),
            ),
            child: const Icon(
              Icons.hourglass_top_rounded,
              color: Colors.white,
              size: 48,
            ),
          ),
        ),
        const SizedBox(height: 28),
        const Text(
          'Application Submitted!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Colors.black,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Your ${profileType.label} application has been received. Our admin team will review your details.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.6),
        ),
        const SizedBox(height: 32),
        StatusStep(
          number: '1',
          title: 'Application Received',
          subtitle: 'Your details have been submitted successfully.',
          isDone: true,
        ),
        const SizedBox(height: 12),
        StatusStep(
          number: '2',
          title: 'Under Admin Review',
          subtitle:
              'Our team is reviewing your ${profileType.label.toLowerCase()} credentials.',
          isPending: true,
        ),
        const SizedBox(height: 12),
        StatusStep(
          number: '3',
          title: 'Login Access Granted',
          subtitle:
              'Once approved, you can log in using your ${profileType.label} credentials.',
        ),
        const SizedBox(height: 36),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.black12, width: 1.2),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.notifications_outlined,
                size: 18,
                color: Colors.black54,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'You will receive an email notification once the admin approves your account. This usually takes 1–3 business days.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: 0,
            ),
            child: const Text(
              'Back to Home',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        const SizedBox(height: 60),
      ],
    );
  }
}