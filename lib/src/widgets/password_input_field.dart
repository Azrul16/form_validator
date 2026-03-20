import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../form_validator_core.dart';
import '../patterns.dart';
import '../typedefs.dart';

/// Describes the current password strength state shown by [PasswordInputField].
enum PasswordStrengthLevel { none, weak, fair, good, strong }

/// A reusable password form field with visibility toggle, strength feedback,
/// rule hints, caps lock awareness, and optional password matching.
class PasswordInputField extends StatefulWidget {
  const PasswordInputField({
    required this.controller,
    super.key,
    this.labelText = 'Password',
    this.hintText,
    this.decoration,
    this.focusNode,
    this.validator,
    this.matchController,
    this.mismatchMessage,
    this.onChanged,
    this.textInputAction,
    this.enabled = true,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.initiallyObscured = true,
    this.minLength = 8,
    this.requireUppercase = true,
    this.requireLowercase = true,
    this.requireNumber = true,
    this.requireSpecialChar = false,
    this.validateAgainstPolicy = true,
    this.showStrengthIndicator = true,
    this.showValidationHints = true,
    this.showCapsLockWarning = true,
  });

  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final InputDecoration? decoration;
  final FocusNode? focusNode;
  final ValidatorFunction? validator;
  final TextEditingController? matchController;
  final String? mismatchMessage;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final bool enabled;
  final AutovalidateMode autovalidateMode;
  final bool initiallyObscured;
  final int minLength;
  final bool requireUppercase;
  final bool requireLowercase;
  final bool requireNumber;
  final bool requireSpecialChar;
  final bool validateAgainstPolicy;
  final bool showStrengthIndicator;
  final bool showValidationHints;
  final bool showCapsLockWarning;

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  static final RegExp _uppercaseRegex = RegExp(r'[A-Z]');
  static final RegExp _lowercaseRegex = RegExp(r'[a-z]');
  static final RegExp _numberRegex = RegExp(r'\d');
  static final RegExp _specialCharacterRegex =
      ValidationPatterns.specialCharacter;

  late FocusNode _focusNode;
  late bool _ownsFocusNode;
  late bool _obscureText;
  bool _capsLockOn = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.initiallyObscured;
    _focusNode = widget.focusNode ?? FocusNode();
    _ownsFocusNode = widget.focusNode == null;
    widget.controller.addListener(_handleControllerChange);
    widget.matchController?.addListener(_handleControllerChange);
    _focusNode.addListener(_handleFocusChange);
    HardwareKeyboard.instance.addHandler(_handleHardwareKeyboardEvent);
    _updateCapsLockState();
  }

  @override
  void didUpdateWidget(covariant PasswordInputField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_handleControllerChange);
      widget.controller.addListener(_handleControllerChange);
    }

    if (oldWidget.matchController != widget.matchController) {
      oldWidget.matchController?.removeListener(_handleControllerChange);
      widget.matchController?.addListener(_handleControllerChange);
    }

    if (oldWidget.focusNode != widget.focusNode) {
      _focusNode.removeListener(_handleFocusChange);
      if (_ownsFocusNode) {
        _focusNode.dispose();
      }
      _focusNode = widget.focusNode ?? FocusNode();
      _ownsFocusNode = widget.focusNode == null;
      _focusNode.addListener(_handleFocusChange);
      _updateCapsLockState();
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleControllerChange);
    widget.matchController?.removeListener(_handleControllerChange);
    _focusNode.removeListener(_handleFocusChange);
    HardwareKeyboard.instance.removeHandler(_handleHardwareKeyboardEvent);
    if (_ownsFocusNode) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _handleControllerChange() {
    if (mounted) {
      setState(() {});
    }
  }

  void _handleFocusChange() {
    _updateCapsLockState();
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _updateCapsLockState() {
    final capsLockPressed = HardwareKeyboard.instance.logicalKeysPressed
        .contains(LogicalKeyboardKey.capsLock);

    final nextValue = _focusNode.hasFocus && capsLockPressed;
    if (mounted && nextValue != _capsLockOn) {
      setState(() {
        _capsLockOn = nextValue;
      });
    }
  }

  bool _handleHardwareKeyboardEvent(KeyEvent event) {
    _updateCapsLockState();
    return false;
  }

  ValidatorFunction? _buildValidator() {
    final validators = <ValidatorFunction>[];

    if (widget.validator != null) {
      validators.add(widget.validator!);
    }

    if (widget.validateAgainstPolicy) {
      validators.add(
        FormValidator.password(
          minLength: widget.minLength,
          requireUppercase: widget.requireUppercase,
          requireLowercase: widget.requireLowercase,
          requireNumber: widget.requireNumber,
          requireSpecialChar: widget.requireSpecialChar,
        ),
      );
    }

    if (widget.matchController != null) {
      validators.add(
        FormValidator.confirmPassword(
          widget.matchController!.text,
          message: widget.mismatchMessage,
        ),
      );
    }

    if (validators.isEmpty) {
      return null;
    }

    if (validators.length == 1) {
      return validators.first;
    }

    return FormValidator.combine(validators);
  }

  List<_PasswordRequirement> _requirements() {
    final requirements = <_PasswordRequirement>[];

    if (!widget.validateAgainstPolicy) {
      return requirements;
    }

    requirements.add(
      _PasswordRequirement(
        label: 'At least ${widget.minLength} characters',
        isMet: widget.controller.text.length >= widget.minLength,
      ),
    );

    if (widget.requireUppercase) {
      requirements.add(
        _PasswordRequirement(
          label: 'One uppercase letter',
          isMet: _uppercaseRegex.hasMatch(widget.controller.text),
        ),
      );
    }

    if (widget.requireLowercase) {
      requirements.add(
        _PasswordRequirement(
          label: 'One lowercase letter',
          isMet: _lowercaseRegex.hasMatch(widget.controller.text),
        ),
      );
    }

    if (widget.requireNumber) {
      requirements.add(
        _PasswordRequirement(
          label: 'One number',
          isMet: _numberRegex.hasMatch(widget.controller.text),
        ),
      );
    }

    if (widget.requireSpecialChar) {
      requirements.add(
        _PasswordRequirement(
          label: 'One special character',
          isMet: _specialCharacterRegex.hasMatch(widget.controller.text),
        ),
      );
    }

    return requirements;
  }

  PasswordStrengthLevel _strengthLevel() {
    final value = widget.controller.text;

    if (value.isEmpty) {
      return PasswordStrengthLevel.none;
    }

    var score = 0;

    if (value.length >= widget.minLength) {
      score += 1;
    }
    if (value.length >= widget.minLength + 4) {
      score += 1;
    }
    if (_uppercaseRegex.hasMatch(value) && _lowercaseRegex.hasMatch(value)) {
      score += 1;
    }
    if (_numberRegex.hasMatch(value)) {
      score += 1;
    }
    if (_specialCharacterRegex.hasMatch(value)) {
      score += 1;
    }

    if (score <= 1) {
      return PasswordStrengthLevel.weak;
    }
    if (score == 2) {
      return PasswordStrengthLevel.fair;
    }
    if (score == 3) {
      return PasswordStrengthLevel.good;
    }
    return PasswordStrengthLevel.strong;
  }

  String _strengthLabel(PasswordStrengthLevel level) {
    switch (level) {
      case PasswordStrengthLevel.none:
        return 'Start typing to see password strength';
      case PasswordStrengthLevel.weak:
        return 'Weak';
      case PasswordStrengthLevel.fair:
        return 'Fair';
      case PasswordStrengthLevel.good:
        return 'Good';
      case PasswordStrengthLevel.strong:
        return 'Strong';
    }
  }

  Color _strengthColor(ThemeData theme, PasswordStrengthLevel level) {
    switch (level) {
      case PasswordStrengthLevel.none:
        return theme.colorScheme.outlineVariant;
      case PasswordStrengthLevel.weak:
        return theme.colorScheme.error;
      case PasswordStrengthLevel.fair:
        return Colors.orange.shade700;
      case PasswordStrengthLevel.good:
        return Colors.lightGreen.shade700;
      case PasswordStrengthLevel.strong:
        return theme.colorScheme.primary;
    }
  }

  double _strengthProgress(PasswordStrengthLevel level) {
    switch (level) {
      case PasswordStrengthLevel.none:
        return 0;
      case PasswordStrengthLevel.weak:
        return 0.25;
      case PasswordStrengthLevel.fair:
        return 0.5;
      case PasswordStrengthLevel.good:
        return 0.75;
      case PasswordStrengthLevel.strong:
        return 1;
    }
  }

  bool _matchesPassword() {
    final matchController = widget.matchController;
    if (matchController == null) {
      return true;
    }
    return widget.controller.text == matchController.text;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final requirements = _requirements();
    final strengthLevel = _strengthLevel();
    final strengthColor = _strengthColor(theme, strengthLevel);
    final matchesPassword = _matchesPassword();
    final effectiveDecoration = (widget.decoration ?? const InputDecoration())
        .copyWith(
          labelText: widget.decoration?.labelText ?? widget.labelText,
          hintText: widget.decoration?.hintText ?? widget.hintText,
          border: widget.decoration?.border ?? const OutlineInputBorder(),
          suffixIcon: IconButton(
            tooltip: _obscureText ? 'Show password' : 'Hide password',
            onPressed: widget.enabled ? _toggleObscureText : null,
            icon: Icon(
              _obscureText
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
            ),
          ),
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          enabled: widget.enabled,
          obscureText: _obscureText,
          textInputAction: widget.textInputAction,
          autovalidateMode: widget.autovalidateMode,
          validator: _buildValidator(),
          onChanged: widget.onChanged,
          decoration: effectiveDecoration,
        ),
        if (widget.showCapsLockWarning && _capsLockOn) ...[
          const SizedBox(height: 10),
          _StatusBanner(
            icon: Icons.keyboard_capslock,
            backgroundColor: Colors.orange.shade50,
            foregroundColor: Colors.orange.shade900,
            text: 'Caps Lock is on',
          ),
        ],
        if (widget.showStrengthIndicator) ...[
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    minHeight: 8,
                    value: _strengthProgress(strengthLevel),
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                    valueColor: AlwaysStoppedAnimation<Color>(strengthColor),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                _strengthLabel(strengthLevel),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: strengthColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
        if (widget.showValidationHints &&
            (requirements.isNotEmpty || widget.matchController != null)) ...[
          const SizedBox(height: 12),
          Wrap(
            runSpacing: 8,
            spacing: 8,
            children: [
              for (final requirement in requirements)
                _RequirementChip(requirement: requirement),
              if (widget.matchController != null)
                _RequirementChip(
                  requirement: _PasswordRequirement(
                    label: 'Matches original password',
                    isMet: matchesPassword,
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }
}

class _PasswordRequirement {
  const _PasswordRequirement({required this.label, required this.isMet});

  final String label;
  final bool isMet;
}

class _RequirementChip extends StatelessWidget {
  const _RequirementChip({required this.requirement});

  final _PasswordRequirement requirement;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMet = requirement.isMet;
    final backgroundColor = isMet
        ? theme.colorScheme.primaryContainer
        : theme.colorScheme.surfaceContainerHighest;
    final foregroundColor = isMet
        ? theme.colorScheme.onPrimaryContainer
        : theme.colorScheme.onSurfaceVariant;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: isMet
              ? theme.colorScheme.primary
              : theme.colorScheme.outlineVariant,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 16,
            color: foregroundColor,
          ),
          const SizedBox(width: 8),
          Text(
            requirement.label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: foregroundColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBanner extends StatelessWidget {
  const _StatusBanner({
    required this.icon,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.text,
  });

  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: foregroundColor.withValues(alpha: 0.18)),
      ),
      child: Row(
        children: [
          Icon(icon, color: foregroundColor, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodySmall?.copyWith(
                color: foregroundColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
