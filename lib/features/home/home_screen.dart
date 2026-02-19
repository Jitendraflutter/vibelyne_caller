import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voicly/controller/home_controller.dart';
import 'package:voicly/controller/popup_controller.dart';
import 'package:voicly/core/route/routes.dart';
import 'package:voicly/features/home/widget/animate_pulse_widget.dart';
import 'package:voicly/features/home/widget/match_dialog.dart';
import 'package:voicly/features/home/widget/profile_sheet.dart';
import 'package:voicly/model/caller_model.dart';
import 'package:voicly/networks/auth_services.dart';
import 'package:voicly/widget/screen_wrapper.dart';
import '../../controller/banner_controller.dart';
import 'package:core/core.dart';
import 'package:voicly/core/constant/app_assets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _controller = Get.put(HomeController());
  final BannerController _bannerController = Get.put(BannerController());
  final popupController = Get.find<PopupController>();
  final authService = Get.find<AuthService>();

  @override
  void initState() {
    popupController.checkBalanceAndCall(
      authService.currentUser.value?.points.toInt() ?? 0,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 80.0,
            floating: false,
            pinned: true,
            stretch: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  title: _buildAppBarContent(authService),
                ),
              ),
            ),
          ),

          Obx(() {
            if (_bannerController.isLoading.value ||
                _bannerController.currentBanner.value == null) {
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            }

            final banner = _bannerController.currentBanner.value!;

            return SliverToBoxAdapter(
              child: AnimatedPulseWidget(
                visible: banner.isActive,
                banner: banner,
                onTap: () {
                  if (banner.targetScreen == "/matching_screen") {
                    MatchDialog.show(_controller.callers);
                  } else {
                    Get.toNamed(AppRoutes.COIN);
                  }
                },
              ),
            );
          }),

          _buildHistoryButton("Your Companions"),

          Obx(() => _buildListView(_controller.callers)),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildAppBarContent(AuthService auth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(AppAssets.appName, height: 25, fit: BoxFit.fitHeight),

        Row(
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => Get.toNamed(AppRoutes.COIN),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amber.withOpacity(0.4),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        AppAssets.vp,
                        width: 20,
                        height: 20,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Obx(() {
                      final user = auth.currentUser.value;
                      return Text(
                        (auth.currentUser.value?.points ?? 0).toString(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.onBackground,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Obx(() {
              final user = auth.currentUser.value;

              return Hero(
                tag: "profile_pic",
                child: VoiclyAvatar(
                  radius: 14,
                  borderWidth: 1.0,
                  imageUrl: user?.profilePic ?? AppAssets.userUrl,
                  showStatus: false,
                  onTap: () => Get.toNamed(AppRoutes.PROFILE),
                ),
              );
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildListView(List<CallerModel> caller) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final caller = _controller.callers[index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: GlassContainer(
            child: Row(
              children: [
                VoiclyAvatar(
                  radius: 25,
                  imageUrl: caller.profilePic.isNotEmpty
                      ? caller.profilePic
                      : AppAssets.userUrl,
                  isOnline: caller.isOnline ?? false,
                  onTap: () => Get.bottomSheet(
                    FractionallySizedBox(
                      heightFactor: 3 / 4,
                      child: ProfileSheet(callerModel: caller),
                    ),
                  ),
                ),
                const SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        caller.fullName, // Dynamic Name
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: AppColors.onBackground,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        Helpers.ageFormatter(
                          caller.dob.toString(),
                        ), // Dynamic Age
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryPeach,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        caller.isOnline == true
                            ? "Online"
                            : "Offline", // Dynamic Status
                        style: TextStyle(color: AppColors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 4),
                Row(
                  children: [
                    CallButton(
                      icon: CupertinoIcons.phone_fill,
                      color: AppColors.onPrimary,
                      onTap: () {
                        _controller.startCall(caller);
                      }, // Trigger Cloud Function
                    ),
                    const SizedBox(width: 8),
                    CallButton(
                      icon: CupertinoIcons.videocam_fill,
                      color: AppColors.onPrimary,
                      onTap: () {}, // Trigger Agora Video
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }, childCount: _controller.callers.length),
    );
  }

  Widget _buildHistoryButton(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.onBackground.withOpacity(0.8),
              ),
            ),
            const Spacer(),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Get.toNamed(AppRoutes.HISTORY);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: Icon(
                  CupertinoIcons.clock,
                  color: AppColors.onBackground,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*
  Widget _buildTopIcons() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 220,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: _controller.callers.length,
          itemBuilder: (context, index) {
            final caller = _controller.callers[index];
            return Padding(
              padding: const EdgeInsets.only(right: 14),
              child: _buildGridCard(caller), // same card widget
            );
          },
        ),
      ),
    );
  }

  Widget _buildGridCard(CallerModel caller) {
    return GlassContainer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              const SizedBox(height: 10),
              Expanded(
                flex: 4,
                child: Center(
                  child: VoiclyAvatar(
                    imageUrl: caller.profilePic.isNotEmpty
                        ? caller.profilePic
                        : AppAssets.userUrl,
                    isOnline: caller.isOnline ?? false,
                    onTap: () =>
                        Get.bottomSheet(ProfileSheet(callerModel: caller)),
                  ),
                ),
              ),

              /// text area flexible
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      caller.fullName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.onBackground,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${caller.dob.toString()} Y",
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      caller.isOnline == true ? "Online" : "Offline",
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              /// buttons flexible
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CallButton(
                      icon: CupertinoIcons.phone_fill,
                      color: AppColors.onPrimary,
                      onTap: () {
                        _controller.startCall(caller);
                      },
                    ),
                    const SizedBox(width: 8),
                    CallButton(
                      icon: CupertinoIcons.videocam_fill,
                      color: AppColors.onPrimary,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
*/
}
