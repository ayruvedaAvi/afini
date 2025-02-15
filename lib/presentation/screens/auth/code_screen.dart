import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../themes/colors.dart';

class CodeScreen extends StatefulWidget {
  final bool isCopyCode;
  const CodeScreen({super.key, required this.isCopyCode});

  @override
  CodeScreenState createState() => CodeScreenState();
}

class CodeScreenState extends State<CodeScreen> {
  bool isCopyCode = false;
  final TextEditingController _codeController = TextEditingController();
  String _currentCode = "";
  bool _isValidCode = false;
  bool _showInputField = false;
  String _generatedCode =
      ""; // To store the generated code when isCopyCode is true

  @override
  void dispose() {
    _codeController.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    isCopyCode = widget.isCopyCode;

    // Generate a random 6-character code if isCopyCode is true
    if (isCopyCode) {
      // This is a simplified example - in a real app, you might want to generate this more securely
      const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
      _generatedCode = List.generate(
          6,
          (index) => chars[
              DateTime.now().millisecondsSinceEpoch % chars.length +
                  index % chars.length]).join();
    }
  }

  void _validateCode(String code) {
    // Check if the code is exactly 6 characters and contains only uppercase letters and numbers
    final RegExp regExp = RegExp(r'^[A-Z0-9]{6}$');
    setState(() {
      _isValidCode = regExp.hasMatch(code);
    });
  }

  void _copyCodeToClipboard() {
    Clipboard.setData(ClipboardData(text: _generatedCode));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Code copied to clipboard'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _buildCodeCopyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Share this code with your partner',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _generatedCode,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(width: 15),
                IconButton(
                  icon: const Icon(Icons.copy, color: cPrimaryDark),
                  onPressed: _copyCodeToClipboard,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: cButtonDark,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _showInputField = true;
              });
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Text(
                'Enter Code Instead',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeInputView() {
    return Column(
      children: [
        const Text(
          'Enter 6-digit connection code sent to your partner',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Code contains uppercase letters and numbers',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 30),
        PinCodeTextField(
          appContext: context,
          length: 6,
          controller: _codeController,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.characters,
          animationType: AnimationType.fade,
          textStyle: const TextStyle(color: Colors.white),
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(8),
            fieldHeight: 50,
            fieldWidth: 45,
            activeFillColor: Colors.grey[800],
            inactiveFillColor: Colors.grey[800],
            selectedFillColor: Colors.grey[700],
            activeColor: cPrimaryDark,
            inactiveColor: Colors.grey[600],
            selectedColor: cPrimaryDark,
          ),
          enableActiveFill: true,
          onChanged: (value) {
            setState(() {
              _currentCode = value;
            });
            _validateCode(value);
          },
          beforeTextPaste: (text) {
            // Only allow uppercase letters and numbers
            if (text != null) {
              final cleanedText =
                  text.toUpperCase().replaceAll(RegExp(r'[^A-Z0-9]'), '');
              return cleanedText.length <= 6 ? true : false;
            }
            return false;
          },
          inputFormatters: [
            // Transform lowercase to uppercase and filter out non-alphanumeric characters
            UpperCaseTextFormatter(),
            FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
          ],
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: cButtonDark,
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.grey[800],
            disabledForegroundColor: Colors.grey[600],
          ),
          onPressed: _isValidCode
              ? () {
                  // Handle the verification process
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Verifying code: $_currentCode'),
                      backgroundColor: Colors.blueAccent,
                    ),
                  );
                }
              : null,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            child: Text(
              'Verify',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: const Text('Connection Code'),
        backgroundColor: cButtonDark,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isCopyCode && !_showInputField)
              _buildCodeCopyView()
            else
              _buildCodeInputView(),
          ],
        ),
      ),
    );
  }
}

// Custom formatter to convert input to uppercase
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
