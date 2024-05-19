import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mismatchh/constants/images.dart';

List<BottomNavigationBarItem> bottomBarItems = [
  BottomNavigationBarItem(
      label: '',
      icon: Padding(
        padding: const EdgeInsets.all(3.0),
        child: SvgPicture.asset(
          hamburger,
          fit: BoxFit.scaleDown,
          height: 20,
          width: 20,
          // colorFilter: const ColorFilter.mode(kBlack, BlendMode.srcIn),
        ),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.all(3.0),
        child: SvgPicture.asset(
          hamburger,
          fit: BoxFit.scaleDown,
          height: 20,
          // colorFilter: const ColorFilter.mode(kWhite, BlendMode.srcIn),
          width: 20,
        ),
      )),
  BottomNavigationBarItem(
    label: '',
    activeIcon: Padding(
      padding: const EdgeInsets.all(3.0),
      child: SvgPicture.asset(
        heartFilled,
        fit: BoxFit.scaleDown,
        height: 20,
        width: 20,
        // colorFilter: const ColorFilter.mode(kWhite, BlendMode.srcIn),
      ),
    ),
    icon: Padding(
      padding: const EdgeInsets.all(3.0),
      child: SvgPicture.asset(
        heartOutline,
        fit: BoxFit.scaleDown,
        height: 18,
        // colorFilter: const ColorFilter.mode(kBlack, BlendMode.srcIn),
      ),
    ),
  ),
  BottomNavigationBarItem(
      label: '',
      icon: Padding(
        padding: const EdgeInsets.all(3.0),
        child: SvgPicture.asset(
          chatOutline, height: 20,
          // color: kPrimaryColor,
          // colorFilter: const ColorFilter.mode(kBlack, BlendMode.srcIn),
        ),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.all(3.0),
        child: SvgPicture.asset(
          chatFilled, fit: BoxFit.scaleDown, height: 20,
          // color: kPrimaryColor,
          // colorFilter: const ColorFilter.mode(kWhite, BlendMode.srcIn),
        ),
      )),
  BottomNavigationBarItem(
    label: '',
    icon: Padding(
      padding: const EdgeInsets.all(3.0),
      child: SvgPicture.asset(
        profileOutline,
        height: 20,
        // colorFilter: const ColorFilter.mode(kBlack, BlendMode.srcIn),
      ),
    ),
    activeIcon: Padding(
      padding: const EdgeInsets.all(3.0),
      child: SvgPicture.asset(
        profileFilled,
        // colorFilter: const ColorFilter.mode(kWhite, BlendMode.srcIn),
        height: 20,
      ),
    ),
  ),
];
