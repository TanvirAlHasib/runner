import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:runner/constraints/firebase_constants.dart';
import 'package:runner/models/user_model.dart';
import 'package:runner/utils/toast.dart';
import '../../constraints/color_constraints.dart';
import '../../widgets/registration/runner_logo.dart';
import '../../widgets/registration/registration_header.dart';
import '../../widgets/registration/registration_text_field.dart';
import '../../widgets/registration/terms_checkbox.dart';
import '../../widgets/registration/registration_button.dart';
import '../../widgets/registration/login_redirect.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptedTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> register() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_acceptedTerms) {
      Toast.showMessage(body: 'Please accept Terms & Conditions', context: context);
      return;
    }
    //Firebase integration
    try{
      final user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      if(user.user != null){
        if(!mounted){
          return;
        }
        Toast.showMessage(body: "Registration successful!!", context: context);
        context.goNamed("login");
        final userModel = UserModel(
          uid: user.user!.uid,
          username: _nameController.text,
          email: _emailController.text,
          createdAt: DateTime.now()
        );
        _firebaseFirestore.collection(FirebaseConstants.collectionName)
        .doc(user.user!.uid).collection(FirebaseConstants.user)
            .doc(FirebaseConstants.userID)
            .set(userModel.toMap(), SetOptions(merge: true));
        await _firebaseAuth.signOut();
      }

    } on FirebaseAuthException catch(e){
      if(!mounted){
        return;
      }
      Toast.showMessage(body: e.message!, context: context);
    } on FirebaseException catch(e){
      if(!mounted){
        return;
      }
      Toast.showMessage(body: e.message!, context: context);
    } catch (e){
      if(!mounted){
        return;
      }
      Toast.showMessage(body: "Something went wrong!!", context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(ColorConstraints.splashBackground_0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 25,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const RunnerLogo(),

                const SizedBox(height: 40),

                const RegistrationHeader(),

                const SizedBox(height: 32),

                RegistrationTextField(
                  label: 'Full Name',
                  hint: 'Enter your full name',
                  icon: Icons.person_outline,
                  controller: _nameController,
                  validator: (value) =>
                  value == null || value.trim().isEmpty
                      ? 'Name is required'
                      : null,
                ),

                const SizedBox(height: 20),

                RegistrationTextField(
                  label: 'Email Address',
                  hint: 'example@email.com',
                  icon: Icons.email_outlined,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$')
                        .hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                RegistrationTextField(
                  label: 'Password',
                  hint: 'Create a password',
                  icon: Icons.lock_outline,
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Color(ColorConstraints.bodyFontColor),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                RegistrationTextField(
                  label: 'Confirm Password',
                  hint: 'Re-enter your password',
                  icon: Icons.lock_outline,
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword =
                        !_obscureConfirmPassword;
                      });
                    },
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Color(ColorConstraints.bodyFontColor),
                    ),
                  ),
                  validator: (value) =>
                  value != _passwordController.text
                      ? 'Passwords do not match'
                      : null,
                ),

                const SizedBox(height: 18),

                TermsCheckbox(
                  value: _acceptedTerms,
                  onChanged: (value) {
                    setState(() {
                      _acceptedTerms = value ?? false;
                    });
                  },
                ),

                const SizedBox(height: 22),

                RegistrationButton(
                  onPressed: register,
                ),

                const SizedBox(height: 25),

                LoginRedirect(
                  onPressed: () {
                    // Navigate to LoginScreen
                    context.goNamed("login");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}