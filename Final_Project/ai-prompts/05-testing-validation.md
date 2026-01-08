# Testing & Validation Prompt

**Project Stage:** Quality Assurance (QA) & Testing  
**Goal:** Ensure the stability of the application through unit and widget tests.

---

## Refined Prompt (Final Version)

**Role:** You are a QA Automation Engineer.

**Task:** Write Unit and Widget tests using `flutter_test` and `mockito`.

**Scope:**
1. **Unit Tests:**
   - Verify `AuthService` handles sign-in success and failure correctly (mocking Firebase).
   - Verify `Booking` model serialization.
2. **Widget Tests:**
   - **Login Screen:** concise test to check input entry and button tap.
   - **Home Screen:** verify categories render correctly.

**Goal:** Ensure critical paths are stable without relying on a real backend.

**Output:**
- Dart code for `auth_test.dart` and `login_widget_test.dart`.

---

## Prompt Techniques Used

- **Role Prompting:** Sets the persona of a "QA Automation Engineer".
- **Scenario Testing:** Defines specific test cases (success vs. failure) for the AI to implement.
- **Library Constraints:** Mandates specific testing libraries (`mockito`, `flutter_test`) to ensure compatibility.
- **Condition-Based Prompting:** Requires tests to pass "independent of a real network connection," forcing the use of mocks.
