import 'package:flutter/material.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/categories_widget.dart';
import '../widgets/recommended_jobs_widget.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/text_styles.dart';
import '../widgets/custom_bottom_nav.dart';
import 'package:easy_localization/easy_localization.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _onTap(int index) {
    if (index == 1) {
      Navigator.pushNamed(context, '/saved_jobs');
    } else if (index == 3) {
      Navigator.pushNamed(context, '/job_status');
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 1000;
        bool isDesktop = constraints.maxWidth >= 1000;
        double horizontalPadding = isDesktop
            ? 80
            : isTablet
            ? 40
            : AppValues.horizontalPadding;
        double maxContentWidth = isDesktop ? 1000 : double.infinity;

        return Scaffold(
          backgroundColor: Colorss.whiteColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxContentWidth),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: 16.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppValues.smallVerticalSpace),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "hello".tr(),
                                  style: TextStyle(
                                    fontSize: AppValues.mainTitleFontSize,
                                    fontWeight: FontWeight.bold,
                                    color: Colorss.primaryTextColor,
                                  ),
                                ),
                                Text(
                                  "welcome".tr(),
                                  style: TextStyle(
                                    fontSize: AppValues.secondaryTextFontSize,
                                    color: Colorss.secondaryTextColor,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Locale currentLocale = context.locale;
                                Locale newLocale = currentLocale.languageCode == 'en'
                                    ? const Locale('ar')
                                    : const Locale('en');
                                context.setLocale(newLocale);
                              },
                              child: CircleAvatar(
                                radius: AppValues.profileAvatarRadius,
                                backgroundColor: Colorss.primaryColor.withOpacity(0.1),
                                child: Icon(
                                  Icons.language,
                                  color: Colorss.primaryColor,
                                  size: AppValues.profileAvatarRadius,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppValues.smallVerticalSpace),
                        const SearchBarWidget(),
                        const SizedBox(height: AppValues.largeVerticalSpace),
                        Text(
                          "categories".tr(),
                          style: TextStyle(
                            fontSize: AppValues.sectionTitleFontSize,
                            color: Colorss.primaryTextColor,
                          ),
                        ),
                        const SizedBox(height: AppValues.smallVerticalSpace),
                        const CategoriesWidget(),
                        const SizedBox(height: AppValues.largeVerticalSpace),
                        Text(
                          "recommended_jobs".tr(),
                          style: TextStyle(
                            fontSize: AppValues.sectionTitleFontSize,
                            color: Colorss.primaryTextColor,
                          ),
                        ),
                        const SizedBox(height: AppValues.smallVerticalSpace),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: RecommendedJobsWidget(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: _currentIndex,
            onTap: _onTap,
          ),
        );
      },
    );
  }
}
