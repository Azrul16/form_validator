import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:form_validator_kit/form_validator_kit.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const FormValidatorDemoApp(),
    ),
  );
}

class FormValidatorDemoApp extends StatelessWidget {
  const FormValidatorDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'form_validator demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0F766E)),
        useMaterial3: true,
      ),
      home: const DemoFormPage(),
    );
  }
}

class DemoFormPage extends StatefulWidget {
  const DemoFormPage({super.key});

  @override
  State<DemoFormPage> createState() => _DemoFormPageState();
}

class _DemoFormPageState extends State<DemoFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _websiteController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  void _validate() {
    final isValid = _formKey.currentState?.validate() ?? false;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isValid ? 'Form is valid.' : 'Please fix the highlighted fields.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('form_validator manual test')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _DemoField(
                  label: 'Name',
                  controller: _nameController,
                  validator: FormValidator.required(),
                ),
                _DemoField(
                  label: 'Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: FormValidator.combine([
                    FormValidator.required(message: 'Email is required.'),
                    FormValidator.email(),
                  ]),
                ),
                _DemoField(
                  label: 'Phone',
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  validator: FormValidator.phone(),
                ),
                _DemoField(
                  label: 'Username',
                  controller: _usernameController,
                  validator: FormValidator.username(
                    minLength: 4,
                    maxLength: 16,
                  ),
                ),
                _DemoField(
                  label: 'Password',
                  controller: _passwordController,
                  customField: PasswordInputField(
                    controller: _passwordController,
                    labelText: 'Password',
                    hintText: 'Use 8+ characters with mixed character types',
                    validator: FormValidator.required(),
                    minLength: 8,
                    requireUppercase: true,
                    requireLowercase: true,
                    requireNumber: true,
                    requireSpecialChar: true,
                  ),
                ),
                _DemoField(
                  label: 'Confirm Password',
                  controller: _confirmPasswordController,
                  customField: PasswordInputField(
                    controller: _confirmPasswordController,
                    labelText: 'Confirm Password',
                    validator: FormValidator.required(
                      message: 'Please confirm your password.',
                    ),
                    matchController: _passwordController,
                    mismatchMessage: 'Passwords do not match.',
                    validateAgainstPolicy: false,
                    showStrengthIndicator: false,
                  ),
                ),
                _DemoField(
                  label: 'Website',
                  controller: _websiteController,
                  keyboardType: TextInputType.url,
                  validator: FormValidator.url(allowEmpty: true),
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: _validate,
                  child: const Text('Test Validators'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DemoField extends StatelessWidget {
  const _DemoField({
    required this.label,
    required this.controller,
    this.validator,
    this.customField,
    this.keyboardType,
  });

  final String label;
  final TextEditingController controller;
  final ValidatorFunction? validator;
  final Widget? customField;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child:
          customField ??
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            validator: validator,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
            ),
          ),
    );
  }
}
