import 'package:flutter/material.dart';
import 'package:read_cache_ui/src/core/config/nav_items.dart';
import 'package:read_cache_ui/src/features/cache/presentation/presentation.dart';
import 'package:read_cache_ui/src/features/profile/profile_page.dart';
import 'package:read_cache_ui/src/features/public_cache/presentation/presentation.dart';

List<NavItem> destinations = [
  NavItem(
    route: CachesPage.name,
    label: 'Caches',
    icon: const Icon(Icons.list_alt_outlined),
  ),
  NavItem(
    route: PublicCachesPage.name,
    label: 'Public Caches',
    icon: const Icon(Icons.public_outlined),
  ),
  NavItem(
    route: ProfilePage.name,
    label: 'Profile',
    icon: const Icon(Icons.person_outline),
  ),
];
