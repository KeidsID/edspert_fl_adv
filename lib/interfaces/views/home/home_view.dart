import 'package:edspert_fl_adv/common/assets_paths.dart';
import 'package:edspert_fl_adv/interfaces/widgets/others/course_card.dart';
import 'package:edspert_fl_adv/interfaces/widgets/others/home_view_headline_card.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return SafeArea(
      child: SizedBox.expand(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: kToolbarHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hai, Altop',
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text('Selamat Datang'),
                      ],
                    ),
                    const Flexible(
                      child: CircleAvatar(
                        backgroundImage: AssetImage(AssetsPaths.dummyAvatar),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              const HomeViewHeadlineCard(),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Pilih Pelajaran', style: textTheme.headlineSmall),
                  TextButton(
                      onPressed: () {}, child: const Text('Lihat Semua')),
                ],
              ),
              const SizedBox(height: 8.0),
              Column(
                children: List.generate(
                  3,
                  (index) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: CourseCard(),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Text('Terbaru', style: textTheme.headlineSmall),
              const SizedBox(height: 16.0),
              SizedBox(
                height: 200.0,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (_, __) => const SizedBox(width: 16.0),
                  itemCount: 3,
                  itemBuilder: (_, __) {
                    return SizedBox(
                      width: 200.0 * 1.7,
                      child: Card(
                        child: Image.asset(
                          AssetsPaths.loginPageHeadline,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
