import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voicly/controller/home_controller.dart';
import 'package:voicly/core/constants/app_assets.dart';
import 'package:voicly/core/constants/app_strings.dart';
import 'package:voicly/core/route/routes.dart';
import 'package:voicly/features/home/widget/animate_pulse_widget.dart';
import 'package:voicly/features/home/widget/match_dialog.dart';
import 'package:voicly/model/caller_model.dart';
import 'package:voicly/networks/auth_services.dart';
import 'package:voicly/widget/glass_container.dart';
import 'package:voicly/widget/screen_wrapper.dart';

import '../../controller/banner_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../crud/crud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _controller = Get.put(HomeController());
  final BannerController _bannerController = Get.put(BannerController());

  @override
  Widget build(BuildContext context) {
    final authService = Get.find<AuthService>();
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
                  // background: Container(
                  //   color: AppColors.background.withOpacity(0.4),
                  // ),
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

          _buildSectionHeader("Recent History"),

          Obx(
            () => _controller.isGridView.value
                ? _buildGridView()
                : _buildListView(),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildAppBarContent(AuthService auth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(AppAssets.v, height: 28, fit: BoxFit.fitHeight),

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
            const SizedBox(width: 4),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => Get.toNamed(AppRoutes.PROFILE),
              child: Obx(() {
                final user = auth.currentUser.value;

                return Hero(
                  tag: "profile_pic",
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: user?.profilePic ?? "",
                      height: 25,
                      width: 25,
                      fit: BoxFit.fill,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                value: downloadProgress.progress,
                              ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGridView() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 0.85,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) =>
              _buildGridCard(_controller.callers[index]), // Pass data
          childCount: _controller.callers.length, // Dynamic count
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

              /// avatar area flexible
              Expanded(
                flex: 4,
                child: Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                          caller.profilePic.isNotEmpty
                              ? caller.profilePic
                              : AppAssets.userUrl,
                        ),
                      ),
                      // CircleAvatar(
                      //   radius: constraints.maxWidth * 0.18,
                      //   backgroundImage: NetworkImage(
                      //     caller.profilePic.isNotEmpty
                      //         ? caller.profilePic
                      //         : AppAssets.userUrl,
                      //   ),
                      // ),
                      Positioned(
                        right: 2,
                        bottom: 2,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: caller.isOnline == true
                                ? AppColors.success
                                : Colors.grey,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    ],
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
                    _iconAction(
                      CupertinoIcons.phone_fill,
                      AppColors.onPrimary,
                      () {
                        _controller.startCall(caller);
                      },
                    ),
                    const SizedBox(width: 8),
                    _iconAction(
                      CupertinoIcons.videocam_fill,
                      AppColors.onPrimary,
                      () {},
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

  Widget _buildListView() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final caller = _controller.callers[index];
        return _buildUserGlassCard(caller);
      }, childCount: _controller.callers.length),
    );
  }

  Widget _buildUserGlassCard(CallerModel caller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: GlassContainer(
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                    caller.profilePic.isNotEmpty
                        ? caller.profilePic
                        : AppAssets.userUrl,
                  ),
                ),
                Positioned(
                  right: 2,
                  bottom: 2,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      // Dynamic status color
                      color: caller.isOnline == true
                          ? AppColors.success
                          : Colors.grey,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    caller.fullName, // Dynamic Name
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.onBackground,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    caller.isOnline == true
                        ? "Active"
                        : "Offline", // Dynamic Status
                    style: TextStyle(color: AppColors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 4),
            Row(
              children: [
                _iconAction(
                  CupertinoIcons.phone_fill,
                  AppColors.onPrimary,
                  () {
                    _controller.startCall(caller);
                  }, // Trigger Cloud Function
                ),
                const SizedBox(width: 8),
                _iconAction(
                  CupertinoIcons.videocam_fill,
                  AppColors.onPrimary,
                  () {}, // Trigger Agora Video
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
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
              onPressed: () => _controller.toggleView(),

              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: Icon(
                  _controller.isGridView.isTrue
                      ? CupertinoIcons.list_bullet
                      : CupertinoIcons.square_grid_2x2,
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

  Widget _iconAction(IconData icon, Color color, VoidCallback onTap) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.3),
          shape: BoxShape.circle,

          border: Border.all(color: color.withOpacity(0.2), width: 0.5),
        ),
        child: Icon(icon, color: color, size: 22),
      ),
    );
  }
}
