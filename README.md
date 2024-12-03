# Birthday Reminder App 🎂  

A simple Flutter application for managing and reminding birthdays. This app is designed with a user-friendly interface, ensuring ease of use and providing a great user experience.  

---

## 📱 Features  
- **Home Page:**  
  - Displays categorized birthdays under "Today", "This Week", and "Upcoming".  
  - Shows remaining days for each birthday with visually appealing card designs.  
  - Randomized card colors to enhance the user experience.  

- **Add Birthdays:**  
  - Add a new birthday using a **floating action button**.  
  - Includes a **date picker** for selecting the birthday date.  
  - Validates input fields to prevent empty entries.  

- **Delete Birthdays:**  
  - Long press on a birthday card to open a **confirmation dialog** for deletion.  

- **No Data Message:**  
  - If no birthdays are added, displays a message encouraging the user to add one.  

---

## 🛠️ Technologies Used  
- **Framework:** Flutter  
- **Languages:** Dart  
- **State Management:** Stateful widgets  
- **UI/UX Design:** Material Design principles  
- **Data Storage:** In-memory list (no persistent database)  

---

## 🎨 Design Highlights  
- **Dynamic Card Colors:** Each birthday card has a unique, randomly assigned background color for an engaging look.  
- **Minimalist Layout:** Clean and intuitive interface with easy navigation.  
- **Floating Effect:** Cards have shadows, making them appear as if floating on the screen.  

---

## 🎥 Demo  

### App Workflow:  
1. **Home Page:** Displays the list of birthdays (if any) or a default "no data" message.  
2. **Add Page:** Users can enter the name and date of a birthday. A date picker simplifies the selection process.  
3. **Back to Home:** After saving, the added birthday is shown in the appropriate section.  
4. **Delete Option:** Long press a card to delete a birthday after confirming.  

---

## 📦 Future Enhancements  
- Implement a **database** for persistent storage (e.g., SQLite or Firebase).  
- Add notification reminders for upcoming birthdays.  
- Include user profile pictures for better personalization.  
- Support exporting/importing birthday data.  

---

## 🛠️ Setup & Installation  

1. Clone the repository:  
   ```bash  
   git clone https://github.com/your-username/birthday-reminder-app.git  
   cd birthday-reminder-app  
2. Install dependencies:
  ```bash
  flutter pub get.

3. Run the app:
  ```bash
