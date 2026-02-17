import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voicly/controller/auth/update_user_profile_controller.dart';
import 'package:voicly/networks/auth_services.dart';
import 'package:core/core.dart';

class ProfileUpdateScreen extends StatelessWidget {
  const ProfileUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateProfileController());
    final authService = Get.find<AuthService>();
    return ScreenWrapper(
      visibleAppBar: true,
      title: "Profile Update",
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30),

            // Read-Only Email
            _buildTextField("Full Name", controller.nameController),
            SizedBox(height: 25),
            _buildReadOnlyField(
              "Email Address",
              authService.currentUser.value?.email ?? "",
            ),
            SizedBox(height: 20),
            _buildGenderSelection(controller.selectedGender),
            SizedBox(height: 20),
            _buildDatePickerField(
              "Date of Birth",
              controller.selectedDob,
              context,
            ), //
            SizedBox(height: 20),

            // Bio
            _buildTextField("Bio", controller.bioController, maxLines: 3),

            SizedBox(height: 50),

            Obx(
              () => AppButton(
                text: 'Save Changes',
                onPressed: controller.isLoading.value
                    ? null
                    : () => controller.updateProfile(),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

Widget _buildDatePickerField(
  String label,
  Rxn<DateTime> selectedDate,
  BuildContext context,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: TextStyle(color: Colors.white54, fontSize: 14)),
      SizedBox(height: 10),
      InkWell(
        onTap: () async {
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: selectedDate.value ?? DateTime(2000),
            firstDate: DateTime(1950),
            lastDate: DateTime.now(),
            builder: (context, child) {
              return Theme(
                data: ThemeData.dark().copyWith(
                  colorScheme: const ColorScheme.dark(
                    primary: AppColors.primaryPeach, // Matches your theme
                    onPrimary: Colors.white,
                    surface: Color(0xFF1A1A1A), // Deep dark background
                  ),
                  dialogBackgroundColor: const Color(0xFF1A1A1A),
                ),
                child: child!,
              );
            },
          );
          if (picked != null) {
            selectedDate.value = picked; // Update reactive variable
          }
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Text(
                  selectedDate.value == null
                      ? "Select Date of Birth"
                      : "${selectedDate.value!.day}/${selectedDate.value!.month}/${selectedDate.value!.year}",
                  style: TextStyle(
                    color: selectedDate.value == null
                        ? Colors.white38
                        : Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              Icon(
                CupertinoIcons.calendar,
                size: 20,
                color: AppColors.primaryPeach,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

// Helper Widgets for the Modal
Widget _buildReadOnlyField(String label, String value) {
  return TextField(
    readOnly: true,
    controller: TextEditingController(text: value),
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white54),
      filled: true,
      fillColor: Colors.white.withOpacity(0.05),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
  );
}

Widget _buildGenderSelection(RxString selectedGender) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Gender", style: TextStyle(color: Colors.white54, fontSize: 14)),
      SizedBox(height: 10),
      Row(
        children: [
          // Male Option
          Expanded(
            child: Obx(
              () => _genderButton(
                label: "Male",
                icon: CupertinoIcons.person_fill, // Or your custom asset icon
                isSelected: selectedGender.value == "Male",
                onTap: () => selectedGender.value = "Male",
              ),
            ),
          ),
          SizedBox(width: 15),
          // Female Option
          Expanded(
            child: Obx(
              () => _genderButton(
                label: "Female",
                icon: CupertinoIcons.person_2_fill, // Or your custom asset icon
                isSelected: selectedGender.value == "Female",
                onTap: () => selectedGender.value = "Female",
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _genderButton({
  required String label,
  required IconData icon,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        // Background stays dark/glassy
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
        // Border changes color and width based on selection
        border: Border.all(
          color: isSelected ? AppColors.primaryPeach : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
            color: isSelected ? AppColors.primaryPeach : Colors.white60,
          ),
          SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? AppColors.primaryPeach : Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildTextField(
  String label,
  TextEditingController controller, {
  int maxLines = 1,
}) {
  return TextField(
    controller: controller,
    maxLines: maxLines,
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white54),
      filled: true,
      fillColor: Colors.white.withOpacity(0.05),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
