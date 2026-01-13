# NubankMobileTest

This project was developed as a **technical assessment**, with the goal of demonstrating code organization, architectural decision-making, and best practices in modern iOS development.

In addition to meeting the proposed functional requirements, the project was treated as an **architecture demo app**, prioritizing clarity, simplicity, and maintainability.

---

## 🚀 How to Run

To run this project locally:
1. **Clone the repository**
```bash```
```git clone https://github.com/jeancarlosaps/NubankMobileTest.git```

2.	Open the project in Xcode
	•	Navigate to the cloned folder
	•	Double-click NubankMobileTest.xcodeproj to open in Xcode

3.	Select target device
	•	Choose a simulator or a real device

4.	Build & Run
	•	Press Cmd + R

This project targets iOS 16+ and was developed with the latest stable Xcode available at the time of commit.
---

## 🛠 Technologies Used

- **Swift**
- **SwiftUI**
- **Xcode**
- **Apple native APIs**

No external dependencies were used.

---

## 🎨 UI – SwiftUI

The user interface was built using **SwiftUI**, chosen as the primary framework for being Apple’s modern approach to declarative UI development.

### Reasons for choosing SwiftUI:
- Declarative and more readable syntax
- Less boilerplate compared to UIKit
- Strong alignment with MVVM
- Simpler state management
- Easier previews and visual testing

> Although this project uses SwiftUI, I also have solid experience with **UIKit**, allowing me to work comfortably with legacy or hybrid projects when needed.

---

## 🧱 Architecture – MVVM

The project follows the **MVVM (Model–View–ViewModel)** architectural pattern.

### Reasons for this choice:
- Clear separation of responsibilities
- Views focused solely on presentation
- ViewModels handling business logic and state
- Improved testability
- Natural compatibility with SwiftUI

### Responsibility breakdown:
- **View**: responsible only for rendering and user interaction
- **ViewModel**: contains business logic, state, and service communication
- **Model**: represents the app’s entities and data structures

> A **Coordinator** pattern was not applied, as the project scope did not require complex navigation. The decision favored simplicity without compromising organization.

---

## 📦 Dependency Management

No dependency manager was used.

### Rationale:
- Simple project scope
- Exclusive use of native APIs
- Reduced coupling
- Faster build times
- Lower maintenance cost

> External dependencies are only introduced when they provide clear value. If needed, the natural choice would be **Swift Package Manager (SPM)**.

---

## 📁 Project Structure (Overview)

The project organization follows a clear separation by responsibility, improving readability and maintainability:

├── Models
├── Views
├── ViewModels
├── Services
└── Resources

This structure aligns with the MVVM pattern and helps avoid unnecessary coupling.

---

## ✅ Applied Best Practices

- Clear separation of responsibilities
- Clean and readable code
- Conscious architectural decisions
- Avoidance of unnecessary dependencies
- Project prepared for future evolution

---

## 🚀 Final Considerations

This project was developed not only to fulfill requirements, but to demonstrate **technical maturity**, architectural clarity, and best practices expected in professional environments.

It reflects my day-to-day approach: balancing simplicity, code quality, and scalability.