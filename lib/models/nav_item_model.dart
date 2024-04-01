import 'rive_model.dart';

class NavItemModel {
  final String title;
  final RiveModel rive;

  NavItemModel({required this.title, required this.rive});
}

List<NavItemModel> bottomNavItems = [
  NavItemModel(
    title: "Home", 
    rive: RiveModel(
      src: "assets/animated-icons.riv",
      artboard: "HOME",
      stateMachineName: "HOME_interactivity"),
    ),
    NavItemModel(
    title: "Favo", 
    rive: RiveModel(
      src: "assets/animated-icons.riv",
      artboard: "LIKE/STAR",
      stateMachineName: "STAR_Interactivity"),
    ),
    NavItemModel(
    title: "Search", 
    rive: RiveModel(
      src: "assets/animated-icons.riv",
      artboard: "SEARCH",
      stateMachineName: "SEARCH_Interactivity"),
    ),
  NavItemModel(
    title: "User", 
    rive: RiveModel(
      src: "assets/animated-icons.riv",
      artboard: "USER",
      stateMachineName: "USER_Interactivity"),
    ),
    NavItemModel(
    title: "Settings", 
    rive: RiveModel(
      src: "assets/animated-icons.riv",
      artboard: "SETTINGS",
      stateMachineName: "SETTINGS_Interactivity"),
    ),
];