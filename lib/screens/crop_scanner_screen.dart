import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../assets/models/crop_disease_model.dart';
import '../models/disease_info.dart';
import '../services/diseases_classifier.dart';

class CropScannerScreen extends StatefulWidget {
  const CropScannerScreen({super.key});

  @override
  State<CropScannerScreen> createState() => _CropScannerScreenState();
}

class _CropScannerScreenState extends State<CropScannerScreen> {
  final ImagePicker _picker = ImagePicker();
  final DiseaseClassifier _classifier = DiseaseClassifier();

  File? _selectedImage;

  PredictionResult? _prediction;
  DiseaseInfo? _disease;

  bool _loadingModel = true;
  bool _analyzing = false;

  @override
  void initState() {
    super.initState();
    _initializeModel();
  }

  Future<void> _initializeModel() async {
    try {
      await _classifier.loadModel();

      if (mounted) {
        setState(() {
          _loadingModel = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _loadingModel = false;
        });

        _showMessage(
          "Model loading failed: $e",
          isError: true,
        );
      }
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    if (_loadingModel) {
      _showMessage("AI model is still loading...");
      return;
    }

    try {
      final XFile? picked = await _picker.pickImage(
        source: source,
        imageQuality: 90,
      );

      if (picked == null) return;

      final file = File(picked.path);

      setState(() {
        _selectedImage = file;
        _prediction = null;
        _disease = null;
        _analyzing = true;
      });

      final bytes = await file.readAsBytes();

      await Future.delayed(
        const Duration(milliseconds: 500),
      );

      final result = _classifier.predict(bytes);

      final disease = diseaseDatabase[result.label];

      if (mounted) {
        setState(() {
          _prediction = result;
          _disease = disease;
          _analyzing = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _analyzing = false;
        });

        _showMessage(
          "Prediction failed: $e",
          isError: true,
        );
      }
    }
  }

  void _resetScan() {
    setState(() {
      _selectedImage = null;
      _prediction = null;
      _disease = null;
      _analyzing = false;
    });
  }

  void _showMessage(
      String message, {
        bool isError = false,
      }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
        isError ? Colors.red.shade700 : const Color(0xFF1B5E20),
      ),
    );
  }

  @override
  void dispose() {
    _classifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FAF7),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildHeader(),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                20,
                10,
                20,
                30,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildScannerCard(),

                  const SizedBox(height: 24),

                  if (_analyzing)
                    _buildAnalyzingCard(),

                  if (_prediction != null &&
                      _disease != null &&
                      !_analyzing)
                    _buildResultSection(),

                  if (_selectedImage == null &&
                      !_analyzing &&
                      _prediction == null)
                    _buildTips(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SliverAppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      pinned: true,
      expandedHeight: 120,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.eco_rounded,
                  color: Color(0xFF1B5E20),
                  size: 30,
                ),
              ),

              const SizedBox(width: 14),

              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "AI Crop Doctor",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF17351D),
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      "Detect crop diseases instantly",
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6B7C70),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.auto_awesome,
                      size: 15,
                      color: Color(0xFF2E7D32),
                    ),
                    SizedBox(width: 4),
                    Text(
                      "AI",
                      style: TextStyle(
                        color: Color(0xFF2E7D32),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScannerCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildImagePreview(),

          const SizedBox(height: 18),

          const Text(
            "Scan your crop",
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w800,
              color: Color(0xFF17351D),
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            "Take a clear photo of a leaf, fruit or plant\nfor an AI-powered disease analysis.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              height: 1.5,
              color: Color(0xFF718078),
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: _actionButton(
                  icon: Icons.camera_alt_rounded,
                  label: "Camera",
                  onTap: () => _pickImage(
                    ImageSource.camera,
                  ),
                  filled: true,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _actionButton(
                  icon: Icons.photo_library_rounded,
                  label: "Gallery",
                  onTap: () => _pickImage(
                    ImageSource.gallery,
                  ),
                  filled: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImagePreview() {
    if (_selectedImage == null) {
      return Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFF1F7F2),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: const Color(0xFFD8E8DB),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add_a_photo_rounded,
                size: 34,
                color: Color(0xFF388E3C),
              ),
            ),

            const SizedBox(height: 14),

            const Text(
              "Add a crop image",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF36513D),
              ),
            ),

            const SizedBox(height: 4),

            const Text(
              "JPEG or PNG",
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF8A9A90),
              ),
            ),
          ],
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: SizedBox(
        height: 280,
        width: double.infinity,
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required bool filled,
  }) {
    return SizedBox(
      height: 54,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(
          icon,
          size: 20,
        ),
        label: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: filled
              ? const Color(0xFF2E7D32)
              : const Color(0xFFE8F5E9),
          foregroundColor: filled
              ? Colors.white
              : const Color(0xFF246B2A),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  Widget _buildAnalyzingCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1B5E20),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Column(
        children: [
          SizedBox(
            width: 38,
            height: 38,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 16),

          Text(
            "Analyzing your crop...",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),

          SizedBox(height: 6),

          Text(
            "Our AI is checking the image for\npossible disease symptoms.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFD9F0DC),
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultSection() {
    final confidence = _prediction!.confidence;
    final percentage = confidence * 100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Analysis Result",
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w800,
            color: Color(0xFF17351D),
          ),
        ),

        const SizedBox(height: 12),

        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.05),
                blurRadius: 18,
                offset: const Offset(0, 7),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: _disease!.healthy
                          ? const Color(0xFFE8F5E9)
                          : const Color(0xFFFFF3E0),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(
                      _disease!.healthy
                          ? Icons.check_circle_rounded
                          : Icons.warning_rounded,
                      color: _disease!.healthy
                          ? const Color(0xFF2E7D32)
                          : const Color(0xFFEF6C00),
                      size: 31,
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          _disease!.crop,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF7B8A80),
                          ),
                        ),

                        const SizedBox(height: 3),

                        Text(
                          _disease!.name,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF17351D),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "AI Confidence",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF53665A),
                    ),
                  ),

                  Text(
                    "${percentage.toStringAsFixed(1)}%",
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 9),

              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  value: confidence,
                  minHeight: 10,
                  backgroundColor: const Color(0xFFE7EEE9),
                  valueColor:
                  const AlwaysStoppedAnimation<Color>(
                    Color(0xFF43A047),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 18),

        _infoCard(
          icon: Icons.visibility_rounded,
          title: "Symptoms",
          content: _disease!.symptoms,
        ),

        _infoCard(
          icon: Icons.biotech_rounded,
          title: "Possible Cause",
          content: _disease!.cause,
        ),

        _infoCard(
          icon: Icons.medical_services_rounded,
          title: "Recommended Treatment",
          content: _disease!.treatment,
        ),

        _infoCard(
          icon: Icons.shield_rounded,
          title: "Prevention",
          content: _disease!.prevention,
        ),

        const SizedBox(height: 10),

        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton.icon(
            onPressed: _resetScan,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text(
              "Scan Another Crop",
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1B5E20),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE3ECE5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF2E7D32),
              size: 21,
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF23452B),
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.55,
                    color: Color(0xFF68786E),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Tips for better results",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Color(0xFF17351D),
          ),
        ),

        const SizedBox(height: 12),

        _tip(
          Icons.wb_sunny_rounded,
          "Use good lighting",
          "Take the photo in natural or bright light.",
        ),

        _tip(
          Icons.center_focus_strong_rounded,
          "Focus on the crop",
          "Keep the affected leaf or fruit clearly visible.",
        ),

        _tip(
          Icons.crop_free_rounded,
          "Avoid blurry photos",
          "Hold the camera steady while capturing the image.",
        ),
      ],
    );
  }

  Widget _tip(
      IconData icon,
      String title,
      String description,
      ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF43A047),
            size: 25,
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF294930),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF7A887F),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}