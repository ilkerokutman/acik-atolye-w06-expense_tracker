# Week 6 - Expense Tracker App

This is the starter project for the **Week 6 Expense Tracker App** in the Flutter course.  
The app demonstrates advanced UI design, custom theming, and dynamic theme switching.

---

## Features

- **Expense Tracking**:
  - Users can input expenses with details such as amount, category, and date.
  - Display a summary of expenses in a clean UI.
- **Light/Dark Themes**:
  - Supports dynamic switching between light and dark themes.
- **Data Visualization**:
  - Shows expenses in a visual format, such as bar or pie charts.

---

## Concepts Covered

- **Custom Theming**:
  - Define light and dark themes using `theme` and `darkTheme` properties in `GetMaterialApp`.
  - Toggle themes dynamically with `themeMode`.
- **Reusable Widgets**:
  - Build modular, reusable components for consistent UI design.
- **Advanced UI Design**:
  - Use widgets like `Card`, `ListView`, and custom charts to create a polished application.

---

## Project Structure

- **Main Code**: Located in `lib/main.dart`.
- **Screens**:
  - `expense_list_screen.dart`: Displays a list of expenses.
  - `expense_summary_screen.dart`: Provides a visual representation of expenses.
- **Widgets**:
  - Reusable components such as expense cards and custom charts.
- **Theme**:
  - Centralized theme definitions in a `theme.dart` file.

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
   cd w06-expense-tracker-app
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
