import 'package:flutter/material.dart';
import 'package:form_validator_kit/form_validator_kit.dart';

void main() {
  runApp(const FormValidatorKitExampleApp());
}

class FormValidatorKitExampleApp extends StatelessWidget {
  const FormValidatorKitExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'form_validator_kit example',
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
      appBar: AppBar(title: const Text('form_validator_kit example')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _ExampleField(
                  label: 'Name',
                  controller: _nameController,
                  validator: FormValidator.required(),
                ),
                _ExampleField(
                  label: 'Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: FormValidator.combine([
                    FormValidator.required(message: 'Email is required.'),
                    FormValidator.email(),
                  ]),
                ),
                _ExampleField(
                  label: 'Phone',
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  validator: FormValidator.phone(),
                ),
                _ExampleField(
                  label: 'Username',
                  controller: _usernameController,
                  validator: FormValidator.username(
                    minLength: 4,
                    maxLength: 16,
                  ),
                ),
                _ExampleField(
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
                _ExampleField(
                  label: 'Confirm Password',
                  controller: _confirmPasswordController,
                  obscureText: true,
                  validator: (value) => FormValidator.confirmPassword(
                    _passwordController.text,
                  )(value),
                ),
                _ExampleField(
                  label: 'Website',
                  controller: _websiteController,
                  keyboardType: TextInputType.url,
                  validator: FormValidator.url(allowEmpty: true),
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: _validate,
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

class _ExampleField extends StatelessWidget {
  const _ExampleField({
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
