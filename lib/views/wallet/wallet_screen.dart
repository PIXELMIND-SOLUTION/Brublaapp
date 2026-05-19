
// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'dart:math' as math;

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with TickerProviderStateMixin {
  late AnimationController _cardController;
  late AnimationController _listController;
  late AnimationController _balanceController;
  late AnimationController _shimmerController;
  late AnimationController _pulseController;

  late Animation<double> _cardSlide;
  late Animation<double> _cardFade;
  late Animation<double> _balanceScale;
  late Animation<double> _shimmer;
  late Animation<double> _pulse;

  double walletBalance = 0.0;

  @override
  void initState() {
    super.initState();

    _cardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _listController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _balanceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _cardSlide = Tween<double>(begin: 60, end: 0).animate(
      CurvedAnimation(parent: _cardController, curve: Curves.easeOutCubic),
    );
    _cardFade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));
    _balanceScale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _balanceController, curve: Curves.elasticOut),
    );
    _shimmer = Tween<double>(begin: -1.5, end: 2.5).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );
    _pulse = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    Future.delayed(const Duration(milliseconds: 100), () {
      _cardController.forward();
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      _balanceController.forward();
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      _listController.forward();
    });
  }

  @override
  void dispose() {
    _cardController.dispose();
    _listController.dispose();
    _balanceController.dispose();
    _shimmerController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _showAddAmountModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _AddAmountModal(
        onAmountAdded: (amount) {
          setState(() {
            walletBalance += amount;
          });
          _balanceController.reset();
          _balanceController.forward();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    _buildWalletCard(),
                    const SizedBox(height: 28),
                    _buildQuickActions(),
                    const SizedBox(height: 28),
                    _buildTransactionSection(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white24),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white.withOpacity(0.05),
              ),
              child: const Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
          const Expanded(
            child: Text(
              'Wallet',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletCard() {
    return AnimatedBuilder(
      animation: _cardController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _cardSlide.value),
          child: Opacity(opacity: _cardFade.value, child: child),
        );
      },
      child: AnimatedBuilder(
        animation: _shimmerController,
        builder: (context, child) {
          return Container(
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.12),
                  blurRadius: 30,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Stack(
                children: [
                  Positioned(
                    top: -30,
                    right: -30,
                    child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.05),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -40,
                    left: -20,
                    child: Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.04),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    right: 60,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.03),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: ShaderMask(
                      shaderCallback: (bounds) {
                        return LinearGradient(
                          begin: Alignment(_shimmer.value - 1, 0),
                          end: Alignment(_shimmer.value, 0),
                          colors: [
                            Colors.transparent,
                            Colors.white.withOpacity(0.25),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ).createShader(bounds);
                      },
                      child: Container(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'TOTAL BALANCE',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black.withOpacity(0.4),
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                AnimatedBuilder(
                                  animation: _balanceController,
                                  builder: (context, child) {
                                    return Transform.scale(
                                      scale: _balanceScale.value,
                                      alignment: Alignment.centerLeft,
                                      child: child,
                                    );
                                  },
                                  child: Text(
                                    '₹${walletBalance.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 38,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                      letterSpacing: -1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            AnimatedBuilder(
                              animation: _pulseController,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _pulse.value,
                                  child: child,
                                );
                              },
                              child: Container(
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Icon(
                                  Icons.account_balance_wallet_rounded,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Row(
                                  children: [],
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: _showAddAmountModal,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'Add Amount',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      {'icon': Icons.add_rounded, 'label': 'Add', 'action': _showAddAmountModal},
      {'icon': Icons.send_rounded, 'label': 'Send'},
      {'icon': Icons.swap_horiz_rounded, 'label': 'Transfer'},
      {'icon': Icons.history_rounded, 'label': 'History'},
    ];

    return AnimatedBuilder(
      animation: _listController,
      builder: (context, child) {
        return Opacity(
          opacity: _listController.value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - _listController.value)),
            child: child,
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(actions.length, (i) {
          return _QuickActionButton(
            icon: actions[i]['icon'] as IconData,
            label: actions[i]['label'] as String,
            delay: i * 80,
            onTap: actions[i]['action'] != null 
                ? actions[i]['action'] as VoidCallback 
                : null,
          );
        }),
      ),
    );
  }

  Widget _buildTransactionSection() {
    final transactions = [
      {
        'type': 'credit',
        'title': 'Received From',
        'subtitle': 'Referral • #123456',
        'amount': '+₹30',
        'time': '1 day ago',
        'category': 'Referral Bonus',
      },
      {
        'type': 'debit',
        'title': 'Paid To',
        'subtitle': 'Order • #789012',
        'amount': '-₹30',
        'time': '2 days ago',
        'category': 'Purchase',
      },
      {
        'type': 'credit',
        'title': 'Cashback',
        'subtitle': 'Reward • #345678',
        'amount': '+₹15',
        'time': '3 days ago',
        'category': 'Cashback',
      },
    ];

    return AnimatedBuilder(
      animation: _listController,
      builder: (context, child) {
        return Opacity(
          opacity: _listController.value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - _listController.value)),
            child: child,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Transactions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 0.2,
                ),
              ),
              Text(
                'See all',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.04),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: Column(
              children: List.generate(transactions.length, (index) {
                final tx = transactions[index];
                return _TransactionRow(
                  type: tx['type']!,
                  title: tx['title']!,
                  subtitle: tx['subtitle']!,
                  amount: tx['amount']!,
                  time: tx['time']!,
                  category: tx['category']!,
                  showDivider: index < transactions.length - 1,
                  animationDelay: index * 100,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final int delay;
  final VoidCallback? onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.delay,
    this.onTap,
  });

  @override
  State<_QuickActionButton> createState() => _QuickActionButtonState();
}

class _QuickActionButtonState extends State<_QuickActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _tapController;
  late Animation<double> _tapScale;

  @override
  void initState() {
    super.initState();
    _tapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _tapScale = Tween<double>(
      begin: 1.0,
      end: 0.92,
    ).animate(CurvedAnimation(parent: _tapController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _tapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _tapController.forward(),
      onTapUp: (_) {
        _tapController.reverse();
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      onTapCancel: () => _tapController.reverse(),
      child: AnimatedBuilder(
        animation: _tapController,
        builder: (context, child) {
          return Transform.scale(scale: _tapScale.value, child: child);
        },
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(widget.icon, color: Colors.black, size: 26),
            ),
            const SizedBox(height: 8),
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.7),
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionRow extends StatefulWidget {
  final String type;
  final String title;
  final String subtitle;
  final String amount;
  final String time;
  final String category;
  final bool showDivider;
  final int animationDelay;

  const _TransactionRow({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.time,
    required this.category,
    required this.showDivider,
    required this.animationDelay,
  });

  @override
  State<_TransactionRow> createState() => _TransactionRowState();
}

class _TransactionRowState extends State<_TransactionRow>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<Color?> _bgColor;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _bgColor = ColorTween(
      begin: Colors.transparent,
      end: Colors.white.withOpacity(0.04),
    ).animate(_hoverController);
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCredit = widget.type == 'credit';

    return GestureDetector(
      onTapDown: (_) => _hoverController.forward(),
      onTapUp: (_) => _hoverController.reverse(),
      onTapCancel: () => _hoverController.reverse(),
      child: AnimatedBuilder(
        animation: _hoverController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              color: _bgColor.value,
              borderRadius: BorderRadius.circular(20),
            ),
            child: child,
          );
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: isCredit
                          ? Colors.white.withOpacity(0.1)
                          : Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isCredit
                            ? Colors.white.withOpacity(0.2)
                            : Colors.white.withOpacity(0.1),
                      ),
                    ),
                    child: Icon(
                      isCredit
                          ? Icons.arrow_downward_rounded
                          : Icons.arrow_upward_rounded,
                      color: isCredit ? Colors.white : Colors.white54,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          widget.subtitle,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.4),
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.amount,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: isCredit ? Colors.white : Colors.white54,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        widget.time,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (widget.showDivider)
              Container(
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.white.withOpacity(0.06),
              ),
          ],
        ),
      ),
    );
  }
}

class _AddAmountModal extends StatefulWidget {
  final Function(double) onAmountAdded;

  const _AddAmountModal({required this.onAmountAdded});

  @override
  State<_AddAmountModal> createState() => _AddAmountModalState();
}

class _AddAmountModalState extends State<_AddAmountModal>
    with SingleTickerProviderStateMixin {
  final TextEditingController _amountController = TextEditingController();
  final List<double> _presetAmounts = [100, 500, 1000, 2000, 5000];
  double? _selectedPreset;
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _slideAnimation = Tween<double>(begin: 0.3, end: 0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _addAmount() {
    double amount = _selectedPreset ?? 0;
    if (_amountController.text.isNotEmpty) {
      amount = double.tryParse(_amountController.text) ?? 0;
    }
    
    if (amount > 0) {
      widget.onAmountAdded(amount);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value * MediaQuery.of(context).size.height),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF1A1A1A),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Add Money to Wallet',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Securely add funds to your wallet',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          prefixText: '₹ ',
                          prefixStyle: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                          hintText: '0',
                          hintStyle: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Colors.white.withOpacity(0.3),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _selectedPreset = null;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: _presetAmounts.map((amount) {
                        final isSelected = _selectedPreset == amount;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedPreset = amount;
                              _amountController.clear();
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.transparent
                                    : Colors.white.withOpacity(0.1),
                              ),
                            ),
                            child: Text(
                              '₹$amount',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: isSelected
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: GestureDetector(
                      onTap: _addAmount,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Text(
                          'Add Amount',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock_outline,
                          size: 14,
                          color: Colors.white.withOpacity(0.4),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Secure transaction',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}