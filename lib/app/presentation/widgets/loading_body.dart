import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class LoadingBody extends StatelessWidget {
  const LoadingBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: AppTheme.grey500,
                  borderRadius: BorderRadius.circular(24)),
            ),
            SizedBox(height: 12),
            Container(
              height: 20,
              width: 250,
              decoration: BoxDecoration(
                color: AppTheme.grey500,
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: 20,
              width: 350,
              decoration: BoxDecoration(
                color: AppTheme.grey500,
              ),
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: AppTheme.grey500,
                    borderRadius: BorderRadius.circular(12)
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 15,
                      width: 220,
                      decoration: BoxDecoration(
                        color: AppTheme.grey500,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 15,
                      width: 250,
                      decoration: BoxDecoration(
                        color: AppTheme.grey500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      color: AppTheme.grey500,
                      borderRadius: BorderRadius.circular(12)
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 15,
                      width: 220,
                      decoration: BoxDecoration(
                        color: AppTheme.grey500,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 15,
                      width: 250,
                      decoration: BoxDecoration(
                        color: AppTheme.grey500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      color: AppTheme.grey500,
                      borderRadius: BorderRadius.circular(12)
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 15,
                      width: 220,
                      decoration: BoxDecoration(
                        color: AppTheme.grey500,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 15,
                      width: 250,
                      decoration: BoxDecoration(
                        color: AppTheme.grey500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      color: AppTheme.grey500,
                      borderRadius: BorderRadius.circular(12)
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 15,
                      width: 220,
                      decoration: BoxDecoration(
                        color: AppTheme.grey500,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 15,
                      width: 250,
                      decoration: BoxDecoration(
                        color: AppTheme.grey500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      color: AppTheme.grey500,
                      borderRadius: BorderRadius.circular(12)
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 15,
                      width: 220,
                      decoration: BoxDecoration(
                        color: AppTheme.grey500,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 15,
                      width: 250,
                      decoration: BoxDecoration(
                        color: AppTheme.grey500,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
