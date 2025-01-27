# Affini - An App for Couples

Affini is a dedicated platform designed to strengthen and celebrate relationships. Built for couples, this app fosters connection, collaboration, and shared experiences, helping partners stay in sync effortlessly.

---

## Features (under development)
- **Shared Calendar**: Manage important dates, anniversaries, and plans together.
- **Private Chat**: A secure space for communication.
- **Activity Tracker**: Set and achieve goals as a couple.
- **Photo Memories**: Share and save special moments.
- **Reminders**: Never miss significant events or daily check-ins.

---

## Getting Started
Note: Backend code is hidden and the api URLs are not real. The real ones may vary.

### Prerequisites
- Flutter 3.10 or above
- Dart 3.0 or above
- A working internet connection

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/username/affini.git
   ```
2. Navigate to the project directory:
   ```bash
   cd affini
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

---

## Architecture
Affini follows the **Bloc Architecture** for clean and scalable code. The project structure includes:

- **Data Layer**: Handles API integration and data manipulation.
- **Domain Layer**: Contains core business logic.
- **Presentation Layer**: Manages UI and user interaction.

---

## API Integration
The app uses **Dio** for HTTP requests. 

---

## Local Storage
**Hive** and **Shared Preferences** are used for local data storage. It supports:
- Storing user preferences
- Caching data for offline access

To enable auto-increment IDs for stored data, ensure the following:
1. Initialize Hive in the main file.
2. Define a custom adapter for each data model.

---

## License
This project is licensed under the [MIT License](LICENSE).

---

## Contact
For questions or support, contact me at: [neupaneabhishek13@gmail.com](mailto:neupaneabhishek13@gmail.com)

