import 'package:flutter_personal_portfolio/core/constants/image_constants.dart';
import 'package:flutter_personal_portfolio/model/carousel_model.dart';
import 'package:flutter_personal_portfolio/model/project_model.dart';

List<ProjectModel> projectList = [
  // #1 project
  ProjectModel(
    title: 'Grocery Store (E-Commerce)',
    subtitle: 'subtitle',
    summary: 'summary',
    images: [
      CarouselModel(
        title: 'Home Page',
        subtitle: 'User Application',
        image: ImageConstants.groceryStoreHome,
      ),
      CarouselModel(
        title: 'Categories Page',
        subtitle: 'User Application',
        image: ImageConstants.groceryStoreCategories,
      ),
      CarouselModel(
        title: 'Favourites Page',
        subtitle: 'User Application',
        image: ImageConstants.groceryStoreFavourites,
      ),
      CarouselModel(
        title: 'Cart Page',
        subtitle: 'User Application',
        image: ImageConstants.groceryStoreCart,
      ),
      CarouselModel(
        title: 'Checkout Page',
        subtitle: 'User Application',
        image: ImageConstants.groceryStoreCheckout,
      ),
    ],
    skills: [
      'Flutter',
      'Dart',
      'Firebase Auth',
      'FireStore',
      'Google Maps',
    ],
  ),

  // #2 project
  ProjectModel(
    title: 'News App using REST API',
    subtitle: 'subtitle',
    summary: 'summary',
    images: [
      CarouselModel(
        title: 'Home Page',
        subtitle: '',
        image: ImageConstants.newsAppHome,
      ),
      CarouselModel(
        title: 'Filter by Category',
        subtitle: '',
        image: ImageConstants.newsAppCategory,
      ),
      CarouselModel(
        title: 'Article Details',
        subtitle: '',
        image: ImageConstants.newsAppDetails,
      ),
      CarouselModel(
        title: 'Search For News',
        subtitle: '',
        image: ImageConstants.newsAppSearch,
      ),
      CarouselModel(
        title: 'Drawer',
        subtitle: '',
        image: ImageConstants.newsAppDrawer,
      ),
      CarouselModel(
        title: 'Saved Articles',
        subtitle: '',
        image: ImageConstants.newsAppSaved,
      ),
    ],
    skills: [
      'Flutter',
      'Dart',
      'REST API',
      'Provider',
      'Hive',
    ],
  ),

  // #3 project
  ProjectModel(
    title: 'Zomato UI Clone',
    subtitle: 'subtitle',
    summary: 'summary',
    images: [
      CarouselModel(
        title: 'Login Page',
        subtitle: '',
        image: ImageConstants.zomatoLogin,
      ),
      CarouselModel(
        title: 'Delivery Page',
        subtitle: '',
        image: ImageConstants.zomatoDeliveryPage,
      ),
      CarouselModel(
        title: 'Dining Page',
        subtitle: '',
        image: ImageConstants.zomatoDiningPage,
      ),
      CarouselModel(
        title: 'Dishes Page',
        subtitle: '',
        image: ImageConstants.zomatoDishesPage,
      ),
      CarouselModel(
        title: 'Dish Item',
        subtitle: '',
        image: ImageConstants.zomatoDishDetails,
      ),
      CarouselModel(
        title: 'Filter Dishes',
        subtitle: '',
        image: ImageConstants.zomatoFilterDishes,
      ),
      CarouselModel(
        title: 'Dish Menu',
        subtitle: '',
        image: ImageConstants.zomatoMenu,
      ),
      CarouselModel(
        title: 'Restaurant Details',
        subtitle: '',
        image: ImageConstants.zomatoRestaurantPage,
      ),
      CarouselModel(
        title: 'Profile Page',
        subtitle: '',
        image: ImageConstants.zomatoProfile,
      ),
    ],
    skills: [
      'Flutter',
      'Dart',
      'Shared Preferences',
      'Google Fonts',
    ],
  ),
];
