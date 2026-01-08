# GUI Development Prompt

**Project Stage:** Frontend Development (Flutter)  
**Goal:** Implement the user interface screens and connect them to the functionality.

---

## Refined Prompt (Final Version)

**Role:** You are a Senior Flutter Developer.

**Task:** Create the main Flutter screens using Material 3 design and Provider for state.

**Screens Needed:**
1. **Home:** Welcome message and a grid of service categories that navigates to provider lists.
2. **Booking:** A form to select Date and Time for a specific service, then confirm.
3. **History:** A list view of past and upcoming bookings with their status.
4. **Profile:** User details, theme toggle, and logout.

**Design Goals:**
- Clean, professional UI (Blue/White theme).
- Handle loading and error states for all async actions.

**Output:**
- Dart code for the requested screen widgets.

---

## Prompt Techniques Used

- **Role Prompting:** Adopts the persona of a "Senior Flutter Developer" to ensure best practices (Provider, Material 3).
- **Component Breaking:** Decomposes the large task into individual screen requirements.
- **Visual/Style Constraints:** Specifies specific widgets (`CalendarDatePicker`, `CircularProgressIndicator`) and design systems to guide the UI generation.
- **State Management Context:** Explicitly requests the use of `provider` to maintain consistency with the app architecture.
