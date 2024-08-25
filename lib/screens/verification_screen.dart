import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uniapp/resources/auth_methods.dart';
import 'package:url_launcher/url_launcher.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _auth = AuthMethods();
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    _auth.sendEmailVerificationLink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 140,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                ),
                alignment: const AlignmentDirectional(-1, 1),
                child: const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  child: Text(
                    'UniApp',
                    style: TextStyle(
                      fontSize: 36,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
                child: Text(
                  'Thanks! Now check your email ',
                  style: TextStyle(
                    fontSize: 30,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Text(
                'We send an email to your student email to verify',
                textAlign: TextAlign.left,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(22, 0, 0, 0),
                child: Row(
                  children: [
                    const Text(
                      'If you did\'t receive email just click',
                      textAlign: TextAlign.left,
                    ),
                    GestureDetector(
                      onTap: _auth.sendEmailVerificationLink,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          ' here',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                  onPressed: () async {
                    var url = Uri.https(
                      'login.microsoftonline.com',
                    );
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  },
                  child: const Text('Go to Email')),
            ],
          ),
        ),
      ),
    );
  }
}
