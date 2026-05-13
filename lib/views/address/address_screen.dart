import 'package:brublaapp/provider/address/address_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:brublaapp/model/address_model.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  String _selectedAddressType = 'Home';
  bool _isDefault = false;

  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _line1Controller = TextEditingController();
  final _line2Controller = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _pincodeController = TextEditingController();

  bool _showAddForm = false;

  String? _editingAddressId;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _fadeController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AddressProvider>().fetchAddresses();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _fullNameController.dispose();
    _phoneController.dispose();
    _line1Controller.dispose();
    _line2Controller.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }

  static const Color _bg = Color(0xFFF7F5F2);
  static const Color _surface = Color(0xFFFFFFFF);
  static const Color _ink = Color(0xFF1A1512);
  static const Color _accent = Color(0xFFD4622A);
  static const Color _accentLight = Color(0xFFFAEDE6);
  static const Color _muted = Color(0xFF8C7B72);
  static const Color _border = Color(0xFFE8E2DC);
  static const Color _success = Color(0xFF2D7D46);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: Consumer<AddressProvider>(
            builder: (context, provider, _) {
              return CustomScrollView(
                slivers: [
                  _buildAppBar(),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (provider.status == AddressStatus.error &&
                              provider.errorMessage != null)
                            _ErrorBanner(
                              message: provider.errorMessage!,
                              onDismiss: provider.clearError,
                              accent: _accent,
                            ),

                          if (provider.status == AddressStatus.loading &&
                              provider.addresses.isEmpty)
                            const _LoadingSkeleton()
                          else ...[
                            // ── Saved addresses ───────────────────────
                            if (provider.addresses.isNotEmpty) ...[
                              _sectionLabel('SAVED ADDRESSES'),
                              const SizedBox(height: 12),
                              ...provider.addresses.map(
                                (address) => _AddressCard(
                                  data: address,
                                  accent: _accent,
                                  accentLight: _accentLight,
                                  ink: _ink,
                                  muted: _muted,
                                  border: _border,
                                  surface: _surface,
                                  success: _success,
                                  isLoading: provider.isLoading,
                                  onEdit: () => _openEditForm(address),
                                  onDelete: () =>
                                      _handleDelete(context, provider, address),
                                  onSetDefault: () =>
                                      _handleSetDefault(context, provider, address),
                                ),
                              ),
                              const SizedBox(height: 24),
                            ],

                            if (!_showAddForm)
                              _AddNewButton(
                                accent: _accent,
                                accentLight: _accentLight,
                                ink: _ink,
                                onTap: () {
                                  _resetForm();
                                  setState(() => _showAddForm = true);
                                },
                              )
                            else ...[
                              _sectionLabel(_editingAddressId == null
                                  ? 'ADD NEW ADDRESS'
                                  : 'EDIT ADDRESS'),
                              const SizedBox(height: 14),
                              _buildAddressForm(provider),
                            ],
                          ],

                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }


  Widget _buildAppBar() {
    return SliverAppBar(
      backgroundColor: _bg,
      surfaceTintColor: const Color.fromARGB(0, 255, 255, 255),
      elevation: 0,
      pinned: true,
      expandedHeight: 100,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: const Color.fromARGB(255, 255, 252, 250),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
        title: const Text(
          'Delivery Address',
          style: TextStyle(
            fontFamily: 'Georgia',
            color: Color.fromARGB(255, 255, 253, 251),
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        background: Container(color: const Color.fromARGB(255, 0, 0, 0)),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: _border),
      ),
    );
  }


  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.8,
        color: _muted,
      ),
    );
  }


  Widget _buildAddressForm(AddressProvider provider) {
    return Container(
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _border),
        boxShadow: [
          BoxShadow(
            color: _ink.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionLabel('ADDRESS TYPE'),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ['Home', 'Work', 'Other'].map((type) {
                final selected = _selectedAddressType == type;
                return GestureDetector(
                  onTap: () => setState(() => _selectedAddressType = type),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: selected ? _accent : _bg,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                          color: selected ? _accent : _border, width: 1.5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          type == 'Home'
                              ? Icons.home_rounded
                              : type == 'Work'
                                  ? Icons.work_rounded
                                  : Icons.location_on_rounded,
                          size: 14,
                          color: selected ? Colors.white : _muted,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          type,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: selected ? Colors.white : _ink,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),
            _buildDivider(),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: _FormField(
                    controller: _fullNameController,
                    label: 'Full Name',
                    hint: 'John Doe',
                    icon: Icons.person_outline_rounded,
                    accent: _accent,
                    ink: _ink,
                    muted: _muted,
                    border: _border,
                    bg: _bg,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Required' : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _FormField(
                    controller: _phoneController,
                    label: 'Phone',
                    hint: '98765 43210',
                    icon: Icons.phone_outlined,
                    accent: _accent,
                    ink: _ink,
                    muted: _muted,
                    border: _border,
                    bg: _bg,
                    keyboardType: TextInputType.phone,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Required' : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            _FormField(
              controller: _line1Controller,
              label: 'Address Line 1',
              hint: 'House No., Building, Street',
              icon: Icons.location_on_outlined,
              accent: _accent,
              ink: _ink,
              muted: _muted,
              border: _border,
              bg: _bg,
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 14),

            _FormField(
              controller: _line2Controller,
              label: 'Landmark (optional)',
              hint: 'Near Central Park',
              icon: Icons.map_outlined,
              accent: _accent,
              ink: _ink,
              muted: _muted,
              border: _border,
              bg: _bg,
            ),
            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: _FormField(
                    controller: _cityController,
                    label: 'City',
                    hint: 'New Delhi',
                    icon: Icons.location_city_outlined,
                    accent: _accent,
                    ink: _ink,
                    muted: _muted,
                    border: _border,
                    bg: _bg,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Required' : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _FormField(
                    controller: _stateController,
                    label: 'State',
                    hint: 'Delhi',
                    icon: Icons.map_rounded,
                    accent: _accent,
                    ink: _ink,
                    muted: _muted,
                    border: _border,
                    bg: _bg,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Required' : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            _FormField(
              controller: _pincodeController,
              label: 'PIN Code',
              hint: '110001',
              icon: Icons.pin_outlined,
              accent: _accent,
              ink: _ink,
              muted: _muted,
              border: _border,
              bg: _bg,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6),
              ],
              validator: (v) {
                if (v == null || v.isEmpty) return 'Required';
                if (v.length != 6) return 'Enter 6-digit PIN';
                return null;
              },
            ),

            const SizedBox(height: 20),
            _buildDivider(),
            const SizedBox(height: 16),

            GestureDetector(
              onTap: () => setState(() => _isDefault = !_isDefault),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: _isDefault ? _accent : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: _isDefault ? _accent : _border, width: 2),
                    ),
                    child: _isDefault
                        ? const Icon(Icons.check_rounded,
                            size: 14, color: Colors.white)
                        : null,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Set as default delivery address',
                    style: TextStyle(
                      fontSize: 14,
                      color: _ink,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: provider.isLoading
                        ? null
                        : () {
                            _resetForm();
                            setState(() => _showAddForm = false);
                          },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: _border, width: 1.5),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text(
                      'Cancel',
                      style:
                          TextStyle(color: _muted, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: _SaveButton(
                    isSaving: provider.isLoading,
                    accent: _accent,
                    onTap: () => _handleSave(context, provider),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() => const Divider(color: _border, thickness: 1, height: 1);


  void _openEditForm(AddressModel address) {
    setState(() {
      _editingAddressId = address.id;
      _selectedAddressType = _capitalize(address.type);
      _isDefault = address.isDefault;
      _fullNameController.text = address.fullName;
      _phoneController.text = address.mobile;
      _line1Controller.text = address.address;
      _line2Controller.text = address.landmark ?? '';
      _cityController.text = address.city;
      _stateController.text = address.state;
      _pincodeController.text = address.pincode;
      _showAddForm = true;
    });
  }

  void _resetForm() {
    _editingAddressId = null;
    _selectedAddressType = 'Home';
    _isDefault = false;
    _fullNameController.clear();
    _phoneController.clear();
    _line1Controller.clear();
    _line2Controller.clear();
    _cityController.clear();
    _stateController.clear();
    _pincodeController.clear();
  }

  Future<void> _handleSave(
      BuildContext context, AddressProvider provider) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final address = AddressModel(
      id: _editingAddressId,
      fullName: _fullNameController.text.trim(),
      mobile: _phoneController.text.trim(),
      address: _line1Controller.text.trim(),
      landmark: _line2Controller.text.trim().isEmpty
          ? null
          : _line2Controller.text.trim(),
      city: _cityController.text.trim(),
      state: _stateController.text.trim(),
      pincode: _pincodeController.text.trim(),
      type: _selectedAddressType.toLowerCase(),
      isDefault: _isDefault,
    );

    bool success;
    if (_editingAddressId != null) {
      success = await provider.updateAddress(
        addressId: _editingAddressId!,
        address: address,
      );
    } else {
      success = await provider.addAddress(address);
    }

    if (!mounted) return;

    if (success) {
      setState(() => _showAddForm = false);
      _resetForm();
      _showSnackBar(
        context,
        _editingAddressId != null
            ? 'Address updated successfully'
            : 'Address saved successfully',
        isError: false,
      );
    } else {
      _showSnackBar(
        context,
        provider.errorMessage ?? 'Something went wrong',
        isError: true,
      );
    }
  }

  Future<void> _handleDelete(
      BuildContext context, AddressProvider provider, AddressModel address) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Delete Address',
            style: TextStyle(fontWeight: FontWeight.w700)),
        content: const Text('Are you sure you want to remove this address?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel',
                style: TextStyle(color: _muted)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Delete',
                style: TextStyle(color: Colors.red.shade400,
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );

    if (confirmed != true || address.id == null) return;

    final success = await provider.deleteAddress(address.id!);
    if (!mounted) return;

    _showSnackBar(
      context,
      success ? 'Address deleted' : (provider.errorMessage ?? 'Delete failed'),
      isError: !success,
    );
  }

  Future<void> _handleSetDefault(
      BuildContext context, AddressProvider provider, AddressModel address) async {
    if (address.id == null) return;
    final updated = address.copyWith(isDefault: true);
    final success = await provider.updateAddress(
      addressId: address.id!,
      address: updated,
    );
    if (!mounted) return;
    if (!success) {
      _showSnackBar(
        context,
        provider.errorMessage ?? 'Failed to set default',
        isError: true,
      );
    }
  }

  void _showSnackBar(BuildContext context, String message,
      {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red.shade600 : _success,
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  String _capitalize(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1).toLowerCase();
}


class _ErrorBanner extends StatelessWidget {
  final String message;
  final VoidCallback onDismiss;
  final Color accent;

  const _ErrorBanner({
    required this.message,
    required this.onDismiss,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline_rounded,
              size: 18, color: Colors.red.shade600),
          const SizedBox(width: 8),
          Expanded(
            child: Text(message,
                style: TextStyle(
                    fontSize: 13, color: Colors.red.shade700)),
          ),
          GestureDetector(
            onTap: onDismiss,
            child: Icon(Icons.close_rounded,
                size: 16, color: Colors.red.shade400),
          ),
        ],
      ),
    );
  }
}

class _LoadingSkeleton extends StatelessWidget {
  const _LoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        2,
        (_) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          height: 110,
          decoration: BoxDecoration(
            color: const Color(0xFFEEE8E2),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}

class _AddressCard extends StatelessWidget {
  final AddressModel data;
  final Color accent, accentLight, ink, muted, border, surface, success;
  final bool isLoading;
  final VoidCallback onEdit, onDelete, onSetDefault;

  const _AddressCard({
    required this.data,
    required this.accent,
    required this.accentLight,
    required this.ink,
    required this.muted,
    required this.border,
    required this.surface,
    required this.success,
    required this.isLoading,
    required this.onEdit,
    required this.onDelete,
    required this.onSetDefault,
  });

  IconData get _typeIcon => data.type == 'home'
      ? Icons.home_rounded
      : data.type == 'work'
          ? Icons.work_rounded
          : Icons.location_on_rounded;

  String get _typeLabel {
    final t = data.type;
    return t.isEmpty ? t : t[0].toUpperCase() + t.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: data.isDefault ? accent.withOpacity(0.4) : border,
            width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: accentLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(_typeIcon, color: accent, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            _typeLabel,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: ink,
                            ),
                          ),
                          if (data.isDefault) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: success.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                'Default',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: success,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        data.fullName,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: ink,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        [
                          data.address,
                          if (data.landmark != null &&
                              data.landmark!.isNotEmpty)
                            data.landmark!,
                          data.city,
                          '${data.state} ${data.pincode}',
                        ].join(', '),
                        style: TextStyle(
                          fontSize: 12.5,
                          color: muted,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.phone_outlined,
                              size: 12, color: muted),
                          const SizedBox(width: 4),
                          Text(
                            data.mobile,
                            style: TextStyle(fontSize: 12, color: muted),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: border),
          Row(
            children: [
              if (!data.isDefault) ...[
                _CardAction(
                  icon: Icons.star_outline_rounded,
                  label: 'Set Default',
                  color: accent,
                  onTap: isLoading ? () {} : onSetDefault,
                ),
                VerticalDivider(width: 1, color: border, thickness: 1),
              ],
              _CardAction(
                icon: Icons.edit_outlined,
                label: 'Edit',
                color: ink,
                onTap: isLoading ? () {} : onEdit,
              ),
              VerticalDivider(width: 1, color: border, thickness: 1),
              _CardAction(
                icon: Icons.delete_outline_rounded,
                label: 'Delete',
                color: Colors.red.shade400,
                onTap: isLoading ? () {} : onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CardAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _CardAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 15, color: color),
              const SizedBox(width: 5),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddNewButton extends StatelessWidget {
  final Color accent, accentLight, ink;
  final VoidCallback onTap;

  const _AddNewButton({
    required this.accent,
    required this.accentLight,
    required this.ink,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        decoration: BoxDecoration(
          color: accentLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: accent.withOpacity(0.3),
              width: 1.5,
              strokeAlign: BorderSide.strokeAlignOutside),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.add_rounded,
                  color: Colors.white, size: 22),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add New Address',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: ink,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Home, work, or any location',
                  style: TextStyle(
                    fontSize: 12,
                    color: accent.withOpacity(0.8),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(Icons.chevron_right_rounded, color: accent, size: 22),
          ],
        ),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final TextEditingController controller;
  final String label, hint;
  final IconData icon;
  final Color accent, ink, muted, border, bg;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  const _FormField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    required this.accent,
    required this.ink,
    required this.muted,
    required this.border,
    required this.bg,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: muted,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
          style:
              TextStyle(fontSize: 14, color: ink, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle:
                TextStyle(color: muted.withOpacity(0.5), fontSize: 13),
            prefixIcon: Icon(icon, size: 18, color: muted),
            filled: true,
            fillColor: bg,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 13, horizontal: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: border, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: accent, width: 1.8),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: Colors.redAccent, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: Colors.redAccent, width: 1.8),
            ),
          ),
        ),
      ],
    );
  }
}

class _SaveButton extends StatelessWidget {
  final bool isSaving;
  final Color accent;
  final VoidCallback onTap;

  const _SaveButton({
    required this.isSaving,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isSaving ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 50,
        decoration: BoxDecoration(
          color: isSaving ? accent.withOpacity(0.7) : accent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: accent.withOpacity(0.35),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: isSaving
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.2,
                  ),
                )
              : const Text(
                  'Save Address',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    letterSpacing: 0.3,
                  ),
                ),
        ),
      ),
    );
  }
}