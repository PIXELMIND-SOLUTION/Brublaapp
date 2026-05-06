// import 'package:brublaapp/views/paymentdetails/payment_details.dart';
// import 'package:flutter/material.dart';

// class StylistScreen extends StatefulWidget {
//   const StylistScreen({super.key});

//   @override
//   State<StylistScreen> createState() => _TailerScreenState();
// }

// class _TailerScreenState extends State<StylistScreen> {
//   final _userNameController = TextEditingController();
//   final _mobileController = TextEditingController();
//   final _locationController = TextEditingController();
//   final _reasonController = TextEditingController();
//   final _dateController = TextEditingController();
//   final _timeController = TextEditingController();
//   final _endTimeController = TextEditingController(); 

//   @override
//   void dispose() {
//     _userNameController.dispose();
//     _mobileController.dispose();
//     _locationController.dispose();
//     _reasonController.dispose();
//     _dateController.dispose();
//     _timeController.dispose();
//     _endTimeController.dispose();
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

//   Future<void> _pickTime(TextEditingController controller) async {
//     final picked = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//     if (picked != null) {
//       controller.text = picked.format(context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: const Color(0xFFFAF8F5),
//             backgroundColor: const Color.fromARGB(255, 255, 255, 255),

//       appBar: AppBar(
//         // backgroundColor: const Color(0xFFFAF8F5),
//                 backgroundColor: const Color.fromARGB(255, 255, 255, 255),

//         elevation: 0,
//         centerTitle: true,
//         leading: IconButton(onPressed: (){
//           Navigator.of(context).pop();
//         }, icon: Icon(Icons.arrow_back_ios,color: const Color.fromARGB(255, 0, 0, 0),)),
//         // automaticallyImplyLeading: false,
//         title: const Text(
//           'Stylist',
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

//             // ✅ START TIME + END TIME ROW
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _timeController,
//                     readOnly: true,
//                     onTap: () => _pickTime(_timeController),
//                     decoration: _inputDecoration('Start Time'),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: TextField(
//                     controller: _endTimeController,
//                     readOnly: true,
//                     onTap: () => _pickTime(_endTimeController),
//                     decoration: _inputDecoration('End Time'),
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 100),

//             SizedBox(
//               width: double.infinity,
//               height: 52,
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => PaymentDetails(),
//                     ),
//                   );
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

class StylistScreen extends StatefulWidget {
  const StylistScreen({super.key});

  @override
  State<StylistScreen> createState() => _TailerScreenState();
}

class _TailerScreenState extends State<StylistScreen>
    with TickerProviderStateMixin {
  final _userNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _locationController = TextEditingController();
  final _reasonController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _endTimeController = TextEditingController();

  // Animation controllers
  late AnimationController _rotateController;
  late AnimationController _pulseController;
  late AnimationController _dotsController;
  late AnimationController _checkController;

  late Animation<double> _pulseAnimation;
  late Animation<double> _checkAnimation;

  bool _isConfirmed = false;

  @override
  void initState() {
    super.initState();

    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    _checkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.12).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _checkAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _checkController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _mobileController.dispose();
    _locationController.dispose();
    _reasonController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _endTimeController.dispose();
    _rotateController.dispose();
    _pulseController.dispose();
    _dotsController.dispose();
    _checkController.dispose();
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

  Future<void> _pickTime(TextEditingController controller) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      controller.text = picked.format(context);
    }
  }

  // ── Animated Popup ────────────────────────────────────────────────────────────
  void _showConfirmationPopup() {
    setState(() => _isConfirmed = false);
    _checkController.reset();

    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ── Animated icon area ──────────────────────────────────
                    SizedBox(
                      height: 130,
                      width: 130,
                      child: AnimatedBuilder(
                        animation: Listenable.merge([
                          _rotateController,
                          _pulseController,
                          _checkController,
                        ]),
                        builder: (_, __) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              // Outer rotating ring
                              if (!_isConfirmed)
                                Transform.rotate(
                                  angle:
                                      _rotateController.value * 2 * math.pi,
                                  child: CustomPaint(
                                    size: const Size(120, 120),
                                    painter: _ArcPainter(
                                      color: const Color(0xFFF97316),
                                      strokeWidth: 3,
                                    ),
                                  ),
                                ),
                              // Confirmed outer ring
                              if (_isConfirmed)
                                ScaleTransition(
                                  scale: _checkAnimation,
                                  child: Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0xFF22C55E),
                                        width: 3,
                                      ),
                                    ),
                                  ),
                                ),
                              // Inner pulse circle
                              ScaleTransition(
                                scale: _isConfirmed
                                    ? _checkAnimation
                                    : _pulseAnimation,
                                child: Container(
                                  width: 88,
                                  height: 88,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _isConfirmed
                                        ? const Color(0xFFDCFCE7)
                                        : const Color(0xFFFFF7ED),
                                  ),
                                  child: Icon(
                                    _isConfirmed
                                        ? Icons.check_rounded
                                        // : Icons.content_cut_rounded,
                                        : Icons.hourglass_top_rounded,

                                    color: _isConfirmed
                                        ? const Color(0xFF22C55E)
                                        : const Color(0xFFF97316),
                                    size: 38,
                                  ),
                                ),
                              ),
                              // Orbiting dots
                              if (!_isConfirmed)
                                ...List.generate(4, (i) {
                                  final angle = (_dotsController.value *
                                          2 *
                                          math.pi) +
                                      (i * math.pi / 2);
                                  return Transform.translate(
                                    offset: Offset(
                                      52 * math.cos(angle),
                                      52 * math.sin(angle),
                                    ),
                                    child: Container(
                                      width: i % 2 == 0 ? 7 : 5,
                                      height: i % 2 == 0 ? 7 : 5,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: const Color(0xFFF97316)
                                            .withOpacity(
                                                i % 2 == 0 ? 0.9 : 0.4),
                                      ),
                                    ),
                                  );
                                }),
                            ],
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ── Title ───────────────────────────────────────────────
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: Text(
                        _isConfirmed ? 'Booking Confirmed!' : 'Please Wait...',
                        key: ValueKey(_isConfirmed),
                        style: TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: _isConfirmed
                              ? const Color(0xFF22C55E)
                              : const Color(0xFF111827),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // ── Subtitle ────────────────────────────────────────────
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: _isConfirmed
                          ? const Text(
                              'Your stylist has confirmed the order.\nGet ready for your session!',
                              key: ValueKey('confirmed'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF6B7280),
                                height: 1.6,
                              ),
                            )
                          : _AnimatedDotsText(
                              key: const ValueKey('waiting'),
                              text:
                                  'Your stylist is reviewing your booking and will confirm shortly',
                            ),
                    ),

                    const SizedBox(height: 24),

                    // ── Progress bar (only while waiting) ──────────────────
                    if (!_isConfirmed)
                      AnimatedBuilder(
                        animation: _dotsController,
                        builder: (_, __) {
                          return Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: null,
                                  minHeight: 5,
                                  backgroundColor:
                                      const Color(0xFFF3F4F6),
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                    Color(0xFFF97316),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF22C55E),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Text(
                                    'Stylist is online',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF22C55E),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),

                    // ── Confirmed action button ─────────────────────────────
                    if (_isConfirmed) ...[
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(ctx);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentDetails(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF111827),
                            foregroundColor: Colors.white,
                            padding:
                                const EdgeInsets.symmetric(vertical: 15),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text(
                            'Proceed to Payment',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    // Simulate stylist confirmation after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => _isConfirmed = true);
        _rotateController.stop();
        _pulseController.stop();
        _dotsController.stop();
        _checkController.forward();
      }
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
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        title: const Text(
          'Stylist',
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

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _timeController,
                    readOnly: true,
                    onTap: () => _pickTime(_timeController),
                    decoration: _inputDecoration('Start Time'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _endTimeController,
                    readOnly: true,
                    onTap: () => _pickTime(_endTimeController),
                    decoration: _inputDecoration('End Time'),
                  ),
                ),
              ],
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

// ── Arc Painter ───────────────────────────────────────────────────────────────
class _ArcPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _ArcPainter({required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - strokeWidth / 2;

    // Draw 3 arcs with gaps for spinner effect
    for (int i = 0; i < 3; i++) {
      final startAngle = (i * 2 * math.pi / 3);
      paint.color = color.withOpacity(1.0 - (i * 0.3));
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        math.pi / 2.2,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ── Animated Dots Text ────────────────────────────────────────────────────────
class _AnimatedDotsText extends StatefulWidget {
  final String text;

  const _AnimatedDotsText({super.key, required this.text});

  @override
  State<_AnimatedDotsText> createState() => _AnimatedDotsTextState();
}

class _AnimatedDotsTextState extends State<_AnimatedDotsText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _dotCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() => _dotCount = (_dotCount + 1) % 4);
          _controller.reset();
          _controller.forward();
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${widget.text}${'.' * _dotCount}',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 14,
        color: Color(0xFF6B7280),
        height: 1.6,
      ),
    );
  }
}