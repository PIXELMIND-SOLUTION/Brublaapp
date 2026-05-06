// import 'package:brublaapp/views/paymentdetails/payment_details.dart';
// import 'package:flutter/material.dart';

// class TailerScreen extends StatefulWidget {
//   const TailerScreen({super.key});

//   @override
//   State<TailerScreen> createState() => _TailerScreenState();
// }

// class _TailerScreenState extends State<TailerScreen> {
//   final _userNameController = TextEditingController();
//   final _mobileController = TextEditingController();
//   final _locationController = TextEditingController();
//   final _reasonController = TextEditingController();
//   final _dateController = TextEditingController();
//   final _timeController = TextEditingController();

//   @override
//   void dispose() {
//     _userNameController.dispose();
//     _mobileController.dispose();
//     _locationController.dispose();
//     _reasonController.dispose();
//     _dateController.dispose();
//     _timeController.dispose();
//     super.dispose();
//   }

//   InputDecoration _inputDecoration(String hint) {
//     return InputDecoration(
//       hintText: hint,
//       hintStyle: const TextStyle(
//         color: Color(0xFFAAAAAA),
//         fontSize: 14,
//         fontWeight: FontWeight.w400,
//       ),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: const BorderSide(color: Color(0xFFD6D6D6), width: 1),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: const BorderSide(color: Color(0xFFC8A97E), width: 1.5),
//       ),
//       filled: true,
//       fillColor: Colors.white,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//         elevation: 0,
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         // leading: const BackButton(color: Colors.black),
//         title: const Text(
//           'Tailor',
//           style: TextStyle(
//             color: Color.fromARGB(255, 0, 0, 0),
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       resizeToAvoidBottomInset: true,
//       body: SingleChildScrollView(
//         keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: _userNameController,
//               decoration: _inputDecoration('User Name'),
//             ),
//             const SizedBox(height: 12),
//             TextField(
//               controller: _mobileController,
//               keyboardType: TextInputType.phone,
//               decoration: _inputDecoration('Mobile Number'),
//             ),
//             const SizedBox(height: 12),
//             TextField(
//               controller: _locationController,
//               decoration: _inputDecoration('Location'),
//             ),
//             const SizedBox(height: 12),
//             TextField(
//               controller: _reasonController,
//               decoration: _inputDecoration('Reason For Booking'),
//             ),
//             const SizedBox(height: 12),
//             TextField(
//               controller: _dateController,
//               readOnly: true,
//               onTap: () async {
//                 final picked = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime.now(),
//                   lastDate: DateTime(2100),
//                 );
//                 if (picked != null) {
//                   _dateController.text =
//                       '${picked.day}/${picked.month}/${picked.year}';
//                 }
//               },
//               decoration: _inputDecoration('Date'),
//             ),
//             const SizedBox(height: 12),
//             SizedBox(
//               width: 140,
//               child: TextField(
//                 controller: _timeController,
//                 readOnly: true,
//                 onTap: () async {
//                   final picked = await showTimePicker(
//                     context: context,
//                     initialTime: TimeOfDay.now(),
//                   );
//                   if (picked != null) {
//                     _timeController.text = picked.format(context);
//                   }
//                 },
//                 decoration: _inputDecoration('Time'),
//               ),
//             ),
//             const SizedBox(height: 100),
//             SizedBox(
//               width: double.infinity,
//               height: 52,
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentDetails()));
//                   // ScaffoldMessenger.of(context).showSnackBar(
//                   //   SnackBar(
//                   //     backgroundColor: Colors.green,
//                   //     content: Text('Processing Payment!..'),
//                   //   ),
//                   // );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromARGB(255, 0, 0, 0),
//                   foregroundColor: Colors.white,
//                   elevation: 0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: const Text(
//                   'Proceed ( \$200/- )',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     letterSpacing: 0.3,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//           ],
//         ),
//       ),
//     );
//   }
// }



















import 'package:brublaapp/views/paymentdetails/payment_details.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class TailerScreen extends StatefulWidget {
  const TailerScreen({super.key});

  @override
  State<TailerScreen> createState() => _TailerScreenState();
}

class _TailerScreenState extends State<TailerScreen> {
  final _userNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _locationController = TextEditingController();
  final _reasonController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _mobileController.dispose();
    _locationController.dispose();
    _reasonController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Color(0xFFAAAAAA),
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFD6D6D6), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFC8A97E), width: 1.5),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }

  void _showConfirmationPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (context) => const _ConfirmationDialog(),
    ).then((_) {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => PaymentDetails()),
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Tailor',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _userNameController,
              decoration: _inputDecoration('User Name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _mobileController,
              keyboardType: TextInputType.phone,
              decoration: _inputDecoration('Mobile Number'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _locationController,
              decoration: _inputDecoration('Location'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _reasonController,
              decoration: _inputDecoration('Reason For Booking'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _dateController,
              readOnly: true,
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  _dateController.text =
                      '${picked.day}/${picked.month}/${picked.year}';
                }
              },
              decoration: _inputDecoration('Date'),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: 140,
              child: TextField(
                controller: _timeController,
                readOnly: true,
                onTap: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) {
                    _timeController.text = picked.format(context);
                  }
                },
                decoration: _inputDecoration('Time'),
              ),
            ),
            const SizedBox(height: 100),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _showConfirmationPopup,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Proceed ( \$200/- )',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Confirmation Dialog Widget
// ─────────────────────────────────────────────
class _ConfirmationDialog extends StatefulWidget {
  const _ConfirmationDialog();

  @override
  State<_ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<_ConfirmationDialog>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _rotateController;
  late AnimationController _pulseController;
  late AnimationController _dotsController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;

  int _dotCount = 0;

  @override
  void initState() {
    super.initState();

    // Scale-in popup
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    );
    _scaleController.forward();

    // Rotate scissors icon
    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Pulse glow ring
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.85, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Animated dots
    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() => _dotCount = (_dotCount + 1) % 4);
          _dotsController.forward(from: 0);
        }
      });
    _dotsController.forward();

    // Auto-dismiss after 3 seconds
    // Future.delayed(const Duration(seconds: 3), () {
    //   if (mounted) Navigator.of(context).pop();
    // });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotateController.dispose();
    _pulseController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  String get _dots => '.' * _dotCount;

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 40,
                spreadRadius: 2,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Animated Icon ──
              AnimatedBuilder(
                animation: Listenable.merge([_pulseController, _rotateController]),
                builder: (context, child) {
                  return Transform.scale(
                    scale: _pulseAnimation.value,
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFFC8A97E), Color(0xFF8B5E3C)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFC8A97E).withOpacity(0.5),
                            blurRadius: 20,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: Transform.rotate(
                        angle: _rotateController.value * 2 * math.pi,
                        child: const Icon(
                          // Icons.access_time_rounded,
                          Icons.hourglass_top_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              // ── Title ──
              const Text(
                'Please Wait a Moment',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A1A),
                  letterSpacing: 0.3,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 10),

              // ── Subtitle with animated dots ──
              AnimatedBuilder(
                animation: _dotsController,
                builder: (context, _) {
                  return Text(
                    'Your Tailor is confirming\nyour order$_dots',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF888888),
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  );
                },
              ),

              const SizedBox(height: 28),

              // ── Progress Bar ──
              _AnimatedProgressBar(),

              const SizedBox(height: 20),

              // ── Status Chips ──
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _StatusChip(label: '✂️ Tailor', delay: 0),
                  const SizedBox(width: 8),
                  _StatusChip(label: '📋 Order', delay: 300),
                  const SizedBox(width: 8),
                  _StatusChip(label: '✅ Confirm', delay: 600),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Animated Progress Bar
// ─────────────────────────────────────────────
class _AnimatedProgressBar extends StatefulWidget {
  @override
  State<_AnimatedProgressBar> createState() => _AnimatedProgressBarState();
}

class _AnimatedProgressBarState extends State<_AnimatedProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, _) {
        return Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: LinearProgressIndicator(
                value: _anim.value,
                minHeight: 6,
                backgroundColor: const Color(0xFFF0EAE2),
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFC8A97E)),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '${(_anim.value * 100).toInt()}%',
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFFC8A97E),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      },
    );
  }
}

// ─────────────────────────────────────────────
//  Status Chip with fade-in delay
// ─────────────────────────────────────────────
class _StatusChip extends StatefulWidget {
  final String label;
  final int delay;

  const _StatusChip({required this.label, required this.delay});

  @override
  State<_StatusChip> createState() => _StatusChipState();
}

class _StatusChipState extends State<_StatusChip>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFFDF6EE),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFC8A97E), width: 1),
        ),
        child: Text(
          widget.label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xFF8B5E3C),
          ),
        ),
      ),
    );
  }
}