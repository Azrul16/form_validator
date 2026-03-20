import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const FormValidatorExampleApp(),
    ),
  );
}

class FormValidatorExampleApp extends StatelessWidget {
  const FormValidatorExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'form_validator example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0F766E)),
        useMaterial3: true,
      ),
      home: const ExampleFormPage(),
    );
  }
}

class ExampleFormPage extends StatefulWidget {
  const ExampleFormPage({super.key});

  @override
  State<ExampleFormPage> createState() => _ExampleFormPageState();
}

class _ExampleFormPageState extends State<ExampleFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _usernameController = TextEditingController();
  final _websiteController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _usernameController.dispose();
    _websiteController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isValid
              ? 'All fields look good.'
              : 'Please fix the highlighted fields.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('form_validator example')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _LabeledField(
                  label: 'Name',
                  controller: _nameController,
                  validator: FormValidator.required(),
                ),
                _LabeledField(
                  label: 'Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: FormValidator.combine([
                    FormValidator.required(message: 'Email is required.'),
                    FormValidator.email(),
                  ]),
                ),
                _LabeledField(
                  label: 'Phone',
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  validator: FormValidator.phone(),
                ),
                _LabeledField(
                  label: 'Username',
                  controller: _usernameController,
                  validator: FormValidator.username(
                    minLength: 4,
                    maxLength: 16,
                  ),
                ),
                _LabeledField(
                  label: 'Password',
                  controller: _passwordController,
                  obscureText: true,
                  validator: FormValidator.password(
                    minLength: 8,
                    requireUppercase: true,
                    requireLowercase: true,
                    requireNumber: true,
                    requireSpecialChar: true,
                  ),
                ),
                _LabeledField(
                  label: 'Confirm Password',
                  controller: _confirmPasswordController,
                  obscureText: true,
                  validator: (value) => FormValidator.confirmPassword(
                    _passwordController.text,
                  )(value),
                ),
                _LabeledField(
                  label: 'Website',
                  controller: _websiteController,
                  keyboardType: TextInputType.url,
                  validator: FormValidator.url(allowEmpty: true),
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: _submit,
                  child: const Text('Validate Form'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({
    required this.label,
    required this.controller,
    required this.validator,
    this.keyboardType,
    this.obscureText = false,
  });

  final String label;
  final TextEditingController controller;
  final ValidatorFunction validator;
  final TextInputType? keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
