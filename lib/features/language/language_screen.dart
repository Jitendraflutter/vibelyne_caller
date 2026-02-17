import 'package:flutter/material.dart';
import 'package:core/core.dart';


class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  final List<Map<String, String>> languages = [
    {'name': 'English', 'code': 'en', 'flag': '🇺🇸'},
    {'name': 'Hindi', 'code': 'hi', 'flag': '🇮🇳'},
  ];

  String selectedLanguageCode = 'en';

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      visibleAppBar: true,
      title: 'Select Language',
      child: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: languages.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final lang = languages[index];
                final isSelected = selectedLanguageCode == lang['code'];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedLanguageCode = lang['code']!;
                    });
                  },
                  child: GlassContainer(
                    borderColor: isSelected
                        ? AppColors.primaryPeach
                        : Colors.transparent,
                    blur: 20,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        // color: AppColors.surface,
                        // borderRadius: BorderRadius.circular(16),
                        // border: Border.all(
                        //   color: isSelected
                        //       ? AppColors.primaryPeach
                        //       : Colors.transparent,
                        //   width: 2,
                        // ),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black.withOpacity(0.05),
                        //     blurRadius: 10,
                        //     offset: const Offset(0, 4),
                        //   ),
                        // ],
                      ),
                      child: Row(
                        children: [
                          Text(
                            lang['flag']!,
                            style: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            lang['name']!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: AppColors.onBackground,
                            ),
                          ),
                          const Spacer(),
                          if (isSelected)
                            const Icon(
                              Icons.check_circle,
                              color: AppColors.primaryPeach,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Bottom Action Button
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            child: AppButton(text: 'Confirm', onPressed: () {}),
          ),
        ],
      ),
    );
  }
}
