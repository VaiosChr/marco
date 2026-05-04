import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marco/core/constants/app_text_styles.dart';
import 'package:marco/features/child/domain/models/consent_model.dart';
import 'package:marco/shared/widgets/custom_container.dart';

class ParentalConsent extends ConsumerStatefulWidget {
  final ConsentModel consent;
  final ValueChanged<ConsentModel>? onConsentChanged;

  const ParentalConsent({
    super.key,
    required this.consent,
    this.onConsentChanged,
  });

  @override
  ConsumerState<ParentalConsent> createState() => _ParentalConsentState();
}

class _ParentalConsentState extends ConsumerState<ParentalConsent> {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('PARENTAL CONSENT', style: AppTextStyles.headline1),
          SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                side: BorderSide(width: 1),
                value: widget.consent.processingRoutes,
                onChanged: (value) {
                  setState(() {
                    widget.consent.processingRoutes = value ?? false;
                  });
                  widget.onConsentChanged?.call(widget.consent);
                },
              ),
              Expanded(
                child: Text(
                  "I consent to processing my child's anonymized route data.",
                  style: AppTextStyles.body,
                ),
              ),
              const Text(
                '*',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                side: BorderSide(width: 1),
                value: widget.consent.aiSuggestions,
                onChanged: (value) {
                  setState(() {
                    widget.consent.aiSuggestions = value ?? false;
                  });
                  widget.onConsentChanged?.call(widget.consent);
                },
              ),
              Expanded(
                child: Text(
                  'I consent to AI-powered route suggestions for my child.',
                  style: AppTextStyles.body,
                ),
              ),
              const Text(
                '*',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                side: BorderSide(width: 1),
                value: widget.consent.shareData,
                onChanged: (value) {
                  setState(() {
                    widget.consent.shareData = value ?? false;
                  });
                  widget.onConsentChanged?.call(widget.consent);
                },
              ),

              Expanded(
                child: Text(
                  'Share aggregated data with the municipality.',
                  style: AppTextStyles.body,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text('* Required', style: TextStyle(color: Colors.red, fontSize: 12)),
        ],
      ),
    );
  }
}
