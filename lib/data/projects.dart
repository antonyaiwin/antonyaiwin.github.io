import 'package:flutter_personal_portfolio/core/constants/image_constants.dart';
import 'package:flutter_personal_portfolio/model/carousel_model.dart';
import 'package:flutter_personal_portfolio/model/project_model.dart';

List<ProjectModel> projectList = [
  // #1 project
  ProjectModel(
    title: 'Grocery Store (E-Commerce)',
    subtitle: 'subtitle',
    summary: 'summary',
    gitLink: 'https://github.com/antonyaiwin/flutter_grocery_store_app',
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
    gitLink: 'https://github.com/antonyaiwin/flutter_news_app_using_news_api/',
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
    title: 'TODO Application',
    subtitle: 'subtitle',
    summary: 'summary',
    gitLink:
        'https://github.com/antonyaiwin/flutter_todo_app_with_hive_storage',
    images: [
      CarouselModel(
        title: 'TODO List',
        subtitle: '',
        image: ImageConstants.todoAppHome,
      ),
      CarouselModel(
        title: 'Add TODO',
        subtitle: '',
        image: ImageConstants.todoAppAddItem,
      ),
    ],
    skills: [
      'Flutter',
      'Dart',
      'Hive',
      'Type Adapter',
    ],
  ),

  // #4 project
  ProjectModel(
    title: 'Expense Tracker',
    subtitle: 'subtitle',
    summary: 'summary',
    gitLink: 'https://github.com/antonyaiwin/flutter_expense_tracker',
    images: [
      CarouselModel(
        title: 'Expense Summary',
        subtitle: '',
        image: ImageConstants.expenseTrackerSummary,
      ),
      CarouselModel(
        title: 'Add New Income/Expense',
        subtitle: '',
        image: ImageConstants.expenseTrackerAddRecord,
      ),
    ],
    skills: [
      'Flutter',
      'Dart',
      'Provider',
      'Sqflite',
    ],
  ),

  // #5 project
  ProjectModel(
    title: 'Notes Application',
    subtitle: 'subtitle',
    summary: 'summary',
    gitLink: 'https://github.com/antonyaiwin/flutter_notes_app',
    images: [
      CarouselModel(
        title: 'Home Page',
        subtitle: '',
        image: ImageConstants.notesAppHome,
      ),
      CarouselModel(
        title: 'Add New Note',
        subtitle: '',
        image: ImageConstants.notesAppAddNote,
      ),
    ],
    skills: [
      'Flutter',
      'Dart',
      'Hive',
      'Share Plus',
    ],
  ),

  // #6 project
  ProjectModel(
    title: 'Quiz Application',
    subtitle: 'subtitle',
    summary: 'summary',
    gitLink: 'https://github.com/antonyaiwin/flutter_quiz_app',
    images: [
      CarouselModel(
        title: 'Home Page',
        subtitle: '',
        image: ImageConstants.quizAppHome,
      ),
      CarouselModel(
        title: 'Questions',
        subtitle: '',
        image: ImageConstants.quizAppQuestion,
      ),
      CarouselModel(
        title: 'Correct Answer',
        subtitle: '',
        image: ImageConstants.quizAppQuestionCorrect,
      ),
      CarouselModel(
        title: 'Quiz Summary',
        subtitle: '',
        image: ImageConstants.quizAppSummary,
      ),
    ],
    skills: [
      'Flutter',
      'Dart',
    ],
  ),

  // #7 project
  ProjectModel(
    title: 'Zomato UI Clone',
    subtitle: 'subtitle',
    summary: 'summary',
    gitLink: 'https://github.com/antonyaiwin/flutter_zomato_clone/',
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

  // #8 project
  ProjectModel(
    title: 'Instagram UI Clone',
    subtitle: 'subtitle',
    summary: 'summary',
    gitLink: 'https://github.com/antonyaiwin/flutter_instagram_clone',
    liveLink: 'https://antonyaiwin.github.io/flutter_instagram_clone/',
    images: [
      CarouselModel(
        title: 'Login Page',
        subtitle: '',
        image: ImageConstants.instagramLogin,
      ),
      CarouselModel(
        title: 'Account Selection Page',
        subtitle: '',
        image: ImageConstants.instagramAccountSelect,
      ),
      CarouselModel(
        title: 'Home Page',
        subtitle: '',
        image: ImageConstants.instagramHome,
      ),
      CarouselModel(
        title: 'Search Page',
        subtitle: '',
        image: ImageConstants.instagramSearch,
      ),
    ],
    skills: [
      'Flutter',
      'Dart',
      'Staggered Grid',
      'Staggered Grid',
    ],
  ),
];
