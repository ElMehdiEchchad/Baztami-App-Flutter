import 'package:baztami_app_flutter/config/config.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomLoadingWalletScreen extends StatelessWidget {
  const CustomLoadingWalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Shimmer.fromColors(
          baseColor: Palette.grey1Color,
          highlightColor: Palette.backgroundColor,
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Palette.grey1Color.withOpacity(0.5),
                ),
                height: 40,
                width: double.infinity,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Palette.grey1Color.withOpacity(0.5),
                ),
                height: 40,
                width: double.infinity,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Palette.grey1Color.withOpacity(0.5),
                ),
                height: 40,
                width: double.infinity,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Palette.grey1Color.withOpacity(0.4),
                ),
                height: 40,
                width: double.infinity,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Palette.grey1Color.withOpacity(0.2),
                ),
                height: 40,
                width: double.infinity,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Palette.grey1Color.withOpacity(0.1),
                ),
                height: 40,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
