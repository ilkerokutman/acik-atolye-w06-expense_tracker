# Week 6 - Expense Tracker App

This is the **Week 6 Expense Tracker App** in the Flutter course.  
The app demonstrates advanced UI design, custom theming, dynamic theme switching, and follows best practices for Flutter application architecture with Provider state management and SQLite local storage.

---

## Features

- **Expense Tracking**:
  - Users can input expenses with details such as amount, category, and date.
  - Display a summary of expenses in a clean UI.
  - Edit and delete existing expenses.
  - Filter expenses by category and date range.

- **Light/Dark Themes**:
  - Supports dynamic switching between light and dark themes.
  - Persistent theme preference across app restarts.

- **Data Visualization**:
  - Weekly expense trends displayed as bar charts.
  - Category distribution shown as interactive pie charts.
  - Summary statistics for total spending.

- **Local Storage**:
  - All expense data is stored locally using SQLite.
  - Data persists between app sessions.

---

## Concepts Covered

- **Architecture Pattern**:
  - Provider pattern for state management.
  - Separation of UI, business logic, and data layers.

- **Custom Theming**:
  - Define light and dark themes using `theme` and `darkTheme` properties in `MaterialApp`.
  - Toggle themes dynamically with `themeMode`.

- **Reusable Widgets**:
  - Build modular, reusable components for consistent UI design.
  - Component-based architecture for better maintainability.

- **Advanced UI Design**:
  - Use widgets like `Card`, `ListView`, and custom charts to create a polished application.
  - Responsive layouts that adapt to different screen sizes.

- **Local Data Persistence**:
  - SQLite database integration for storing expense data.
  - CRUD operations for expense management.

- **Data Visualization**:
  - Implementation of charts using the `fl_chart` package.
  - Dynamic data representation based on user expenses.

---

## Project Structure & Architecture

The application follows a clean architecture pattern with separation of concerns:

- **Main Code**: Located in `lib/main.dart`.

- **Screens**:
  - `home_screen.dart`: Main dashboard with expense summary and charts.
  - `expense_list_screen.dart`: Displays a list of expenses.
  - `expense_form_screen.dart`: Form for adding/editing expenses.
  - `settings_screen.dart`: App settings and theme configuration.
  - `main_screen.dart`: Container screen with bottom navigation.

- **Models**:
  - `expense.dart`: Data model for expenses with category enum.

- **Providers** (State Management):
  - `expense_provider.dart`: Manages expense data and operations.
  - `theme_provider.dart`: Handles theme switching functionality.

- **Database**:
  - `db_provider.dart`: SQLite database implementation for local storage.

- **Widgets**:
  - `expense_card.dart`: Reusable card for displaying expense items.
  - `weekly_chart.dart`: Bar chart for weekly expense visualization.
  - `category_chart.dart`: Pie chart for category-based expense breakdown.
  - Other reusable UI components.

- **Theme**:
  - `app_theme.dart`: Centralized theme definitions for light and dark modes.

---

## Development Steps

This repository contains multiple commits, each representing a milestone in the app's development.  
You can roll back to any state to follow along with the class:

1. **Initial Template**: Empty Flutter app.
2. **Basic Expense List**: Create a list screen for displaying expenses.
3. **Light/Dark Theme Toggle**: Add theme definitions and a toggle button.
4. **Expense Summary Screen**: Display a visual summary of expenses using a chart.
5. **Reusable Components**: Refactor UI elements into reusable widgets.
6. **Final App**: Completed Expense Tracker App with theming and charts.

Use the following command to check out a specific commit:
```bash
git checkout <commit-hash>
```

---

## Getting Started

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/ilkerokutman/acik-atolye-w06-expense_tracker.git
   ```
2. **Navigate to the Project Directory**:
   ```bash
   cd acik-atolye-w06-expense_tracker
   ```
3. **Run the App**:
   - Ensure you have Flutter installed.
   - Use the command:
     ```bash
     flutter run
     ```

---

## Contribution

Please refer to the [CONTRIBUTION.md](CONTRIBUTION.md) file for guidelines on contributing to this repository.

---

## License

This project is licensed under the [MIT License](LICENSE).
