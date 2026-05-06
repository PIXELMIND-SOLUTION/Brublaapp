import 'package:brublaapp/views/home/tailer_screen.dart';
import 'package:flutter/material.dart';


enum BookingStatus { pending, accepted, rejected }

class TailorBooking {
  final String id;
  final String productName;
  final String imageUrl;
  final double price;
  final BookingStatus status;
  final DateTime date;

  const TailorBooking({
    required this.id,
    required this.productName,
    required this.imageUrl,
    required this.price,
    required this.status,
    required this.date,
  });
}

final List<TailorBooking> _sampleBookings = [
  TailorBooking(
    id: '#T-1042',
    productName: 'Silk Kurta Set',
    imageUrl: 'https://images.unsplash.com/photo-1594938298603-c8148c4b4457?w=400',
    price: 1850.00,
    status: BookingStatus.accepted,
    date: DateTime.now().subtract(const Duration(days: 1)),
  ),
  TailorBooking(
    id: '#T-1041',
    productName: 'Bridal Lehenga',
    imageUrl: 'https://images.unsplash.com/photo-1610030469983-98e550d6193c?w=400',
    price: 12500.00,
    status: BookingStatus.pending,
    date: DateTime.now().subtract(const Duration(days: 3)),
  ),
  TailorBooking(
    id: '#T-1039',
    productName: 'Cotton Salwar Suit',
    imageUrl: 'https://images.unsplash.com/photo-1583391733956-3750e0ff4e8b?w=400',
    price: 950.00,
    status: BookingStatus.rejected,
    date: DateTime.now().subtract(const Duration(days: 7)),
  ),
  TailorBooking(
    id: '#T-1038',
    productName: 'Men\'s Sherwani',
    imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400',
    price: 8200.00,
    status: BookingStatus.accepted,
    date: DateTime.now().subtract(const Duration(days: 10)),
  ),
  TailorBooking(
    id: '#T-1035',
    productName: 'Anarkali Suit',
    imageUrl: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400',
    price: 3400.00,
    status: BookingStatus.pending,
    date: DateTime.now().subtract(const Duration(days: 14)),
  ),
];

class TailorHistoryScreen extends StatefulWidget {
  const TailorHistoryScreen({super.key});

  @override
  State<TailorHistoryScreen> createState() => _TailorHistoryScreenState();
}

class _TailorHistoryScreenState extends State<TailorHistoryScreen> {
  BookingStatus? _selectedFilter; 

  List<TailorBooking> get _filteredBookings {
    if (_selectedFilter == null) return _sampleBookings;
    return _sampleBookings.where((b) => b.status == _selectedFilter).toList();
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return _FilterBottomSheet(
          selectedFilter: _selectedFilter,
          onFilterSelected: (status) {
            setState(() => _selectedFilter = status);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          Expanded(
            child: _filteredBookings.isEmpty
                ? _buildEmptyState()
                : _buildBookingList(),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.black,
      elevation: 0,
      title: const Text(
        'Orders',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
      centerTitle: false,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TailerScreen()),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'Create Tailor',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ),
        // Filter Button
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              onPressed: _showFilterBottomSheet,
              icon: const Icon(Icons.tune_rounded, color: Colors.white),
            ),
            if (_selectedFilter != null)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeader() {
    final activeCount = _sampleBookings
        .where((b) =>
            b.status == BookingStatus.pending ||
            b.status == BookingStatus.accepted)
        .length;

    return Container(
      color: Colors.black,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Row(
        children: [
          _buildStatChip('Total', '${_sampleBookings.length}'),
          const SizedBox(width: 10),
          _buildStatChip('Active', '$activeCount'),
          if (_selectedFilter != null) ...[
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () => setState(() => _selectedFilter = null),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border:
                      Border.all(color: Colors.redAccent.withOpacity(0.5)),
                ),
                child: const Row(
                  children: [
                    Text(
                      'Clear Filter',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.close_rounded,
                        size: 12, color: Colors.redAccent),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatChip(String label, String count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Text(
            count,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      itemCount: _filteredBookings.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 12),
            child: Text(
              _selectedFilter == null
                  ? 'RECENT BOOKINGS'
                  : '${_statusLabel(_selectedFilter!).toUpperCase()} BOOKINGS',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Colors.black54,
                letterSpacing: 1.4,
              ),
            ),
          );
        }
        return _BookingCard(booking: _filteredBookings[index - 1]);
      },
    );
  }

  String _statusLabel(BookingStatus status) {
    switch (status) {
      case BookingStatus.pending:
        return 'Pending';
      case BookingStatus.accepted:
        return 'Accepted';
      case BookingStatus.rejected:
        return 'Rejected';
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.06),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.content_cut_rounded,
                size: 36, color: Colors.black38),
          ),
          const SizedBox(height: 16),
          const Text(
            'No bookings found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Try changing the filter',
            style: TextStyle(fontSize: 14, color: Colors.black45),
          ),
        ],
      ),
    );
  }
}

class _FilterBottomSheet extends StatelessWidget {
  final BookingStatus? selectedFilter;
  final ValueChanged<BookingStatus?> onFilterSelected;

  const _FilterBottomSheet({
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Filter by Status',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Select a status to filter your bookings',
            style: TextStyle(fontSize: 13, color: Colors.black45),
          ),
          const SizedBox(height: 20),

          // All option
          _FilterOption(
            label: 'All Bookings',
            icon: Icons.list_alt_rounded,
            isSelected: selectedFilter == null,
            dotColor: Colors.black,
            onTap: () => onFilterSelected(null),
          ),
          const SizedBox(height: 10),
          _FilterOption(
            label: 'Pending',
            icon: Icons.hourglass_top_rounded,
            isSelected: selectedFilter == BookingStatus.pending,
            dotColor: const Color(0xFFF59E0B),
            onTap: () => onFilterSelected(BookingStatus.pending),
          ),
          const SizedBox(height: 10),
          _FilterOption(
            label: 'Accepted',
            icon: Icons.check_circle_outline_rounded,
            isSelected: selectedFilter == BookingStatus.accepted,
            dotColor: const Color(0xFF22C55E),
            onTap: () => onFilterSelected(BookingStatus.accepted),
          ),
          const SizedBox(height: 10),
          _FilterOption(
            label: 'Rejected',
            icon: Icons.cancel_outlined,
            isSelected: selectedFilter == BookingStatus.rejected,
            dotColor: const Color(0xFFEF4444),
            onTap: () => onFilterSelected(BookingStatus.rejected),
          ),
        ],
      ),
    );
  }
}

class _FilterOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final Color dotColor;
  final VoidCallback onTap;

  const _FilterOption({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.dotColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.15)
                    : dotColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 18,
                color: isSelected ? Colors.white : dotColor,
              ),
            ),
            const SizedBox(width: 14),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_rounded, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }
}

// --- Booking Card ---
class _BookingCard extends StatelessWidget {
  final TailorBooking booking;

  const _BookingCard({required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildCardTop(),
          _buildCardBottom(),
        ],
      ),
    );
  }

  Widget _buildCardTop() {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              booking.imageUrl,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 90,
                height: 90,
                color: Colors.grey.shade200,
                child: const Icon(Icons.image_not_supported_rounded,
                    color: Colors.grey),
              ),
              loadingBuilder: (_, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: 90,
                  height: 90,
                  color: Colors.grey.shade100,
                  child: const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 14),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      booking.id,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.black45,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                    _StatusBadge(status: booking.status),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  booking.productName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  '₹${booking.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardBottom() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: const BoxDecoration(
        color: Color(0xFFF8F8F8),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
      child: Row(
        children: [
          const Icon(Icons.calendar_today_rounded,
              size: 12, color: Colors.black38),
          const SizedBox(width: 5),
          Text(
            _formatDate(booking.date),
            style: const TextStyle(fontSize: 12, color: Colors.black45),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: const Row(
              children: [
                Text(
                  'View Details',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(width: 3),
                Icon(Icons.arrow_forward_ios_rounded,
                    size: 10, color: Colors.black87),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    if (diff < 7) return '$diff days ago';
    return '${date.day}/${date.month}/${date.year}';
  }
}

// --- Status Badge ---
class _StatusBadge extends StatelessWidget {
  final BookingStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final config = _getConfig();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: config['bg'] as Color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: config['border'] as Color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: config['dot'] as Color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            config['label'] as String,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: config['text'] as Color,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _getConfig() {
    switch (status) {
      case BookingStatus.pending:
        return {
          'label': 'Pending',
          'bg': const Color(0xFFFFF8E1),
          'border': const Color(0xFFFFE082),
          'dot': const Color(0xFFF59E0B),
          'text': const Color(0xFF92400E),
        };
      case BookingStatus.accepted:
        return {
          'label': 'Accepted',
          'bg': const Color(0xFFF0FDF4),
          'border': const Color(0xFFBBF7D0),
          'dot': const Color(0xFF22C55E),
          'text': const Color(0xFF14532D),
        };
      case BookingStatus.rejected:
        return {
          'label': 'Rejected',
          'bg': const Color(0xFFFFF1F2),
          'border': const Color(0xFFFFCDD2),
          'dot': const Color(0xFFEF4444),
          'text': const Color(0xFF7F1D1D),
        };
    }
  }
}