import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:marco/core/constants/app_colors.dart';
import 'package:marco/core/constants/app_text_styles.dart';
import 'package:marco/core/services/mock_api_service.dart';
import 'package:marco/core/utils/scaffold_message.dart';
import 'package:marco/features/ai_suggestion/data/suggestion_repository.dart';
import 'package:marco/shared/widgets/custom_buttons.dart';

class AiSuggestionScreen extends ConsumerStatefulWidget {
  final String routeId;
  const AiSuggestionScreen({super.key, required this.routeId});

  @override
  ConsumerState<AiSuggestionScreen> createState() => _AiSuggestionScreenState();
}

class _AiSuggestionScreenState extends ConsumerState<AiSuggestionScreen> {
  int _rating = 0;
  bool _isUseful = false, _isNotUseful = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('MARCO Assistant', style: AppTextStyles.title),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 5,
                  height: 5,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColorsLight.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Text('Online', style: AppTextStyles.body),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withAlpha(30),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'I noticed today\'s route has high pollution. Here\'s a healthier alternative:',
                    style: AppTextStyles.body,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: BoxBorder.all(width: 1, color: Colors.grey),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColorsLight.primary.withAlpha(50),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            child: Text('+3 min', style: AppTextStyles.body),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColorsLight.secondary.withAlpha(50),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            child: Text(
                              '-40% pollution',
                              style: AppTextStyles.body,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 150,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),

                          child: FlutterMap(
                            options: MapOptions(
                              initialCenter: LatLng(40.6115, 22.9738),
                              initialZoom: 14,
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName: 'com.example.marco',
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Through Pavlou Mela Park',
                        style: AppTextStyles.body,
                      ),

                      const Text(
                        'Quieter, with trees and 2 fewer crossings on busy streets.',
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Was this suggestion helpful?',
                  style: AppTextStyles.body,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _isUseful = true;
                            _isNotUseful = false;
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: _isUseful
                              ? AppColorsLight.primary.withAlpha(30)
                              : Colors.transparent,
                          foregroundColor: _isUseful
                              ? AppColorsLight.primary
                              : Colors.grey,
                          side: BorderSide(
                            color: _isUseful
                                ? AppColorsLight.primary
                                : Colors.grey,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Useful'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _isUseful = false;
                            _isNotUseful = true;
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: _isNotUseful
                              ? AppColorsLight.primary.withAlpha(30)
                              : Colors.transparent,
                          foregroundColor: _isNotUseful
                              ? AppColorsLight.primary
                              : Colors.grey,
                          side: BorderSide(
                            color: _isNotUseful
                                ? AppColorsLight.primary
                                : Colors.grey,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Not for me'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    final starIndex = index + 1;
                    final isSelected = starIndex <= _rating;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _rating = starIndex;
                          });
                        },
                        icon: Icon(
                          isSelected ? Icons.star : Icons.star_border,
                          color: Colors.yellow[700],
                          size: 28,
                        ),
                        splashRadius: 22,
                        tooltip:
                            'Rate $starIndex star${starIndex == 1 ? '' : 's'}',
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    onPressed: () => _submitFeedback(),
                    text: 'Continue',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitFeedback() {
    if (_isUseful == false && _isNotUseful == false) {
      showScaffoldMessage(
        context,
        'Please indicate whether the suggestion was useful or not before submitting your feedback.',
      );
      return;
    }
    if (_rating == 0) {
      showScaffoldMessage(
        context,
        'Please select at least one star rating before submitting your feedback.',
      );
      return;
    }

    final repo = FeedbackRepository(ref.read(mockApiServiceProvider));
    repo.submitFeedback(rating: _rating, isUseful: _isUseful);

    showScaffoldMessage(context, 'Thank you for your feedback!');

    context.pushNamed('tripLog');
  }
}
