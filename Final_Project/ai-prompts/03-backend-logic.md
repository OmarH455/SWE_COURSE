# Backend Logic Prompt (Data Connect)

**Project Stage:** Backend API Development  
**Goal:** Generate the GraphQL queries and mutations required for the application's business logic, including security rules.

---

## Refined Prompt (Final Version)

**Role:** You are a Backend Developer specializing in Secure API design.

**Task:** Write the necessary GraphQL `queries` and `mutations` for the app.

**Required Functionality:**
1. **Public Data:** Fetch all services and filter providers by category.
2. **User Data:** Fetch own profile and booking history.
3. **Actions:**
   - Create a new user after signup.
   - Create a booking (linking user, provider, and service).
   - Update profile details.

**Security:**
- Apply `@auth(level: USER)` for private data and `@auth(level: PUBLIC)` for catalogs.
- Include reasons for insecurity exceptions where needed.

**Output:**
- Full content for `queries.gql` and `mutations.gql`.

---

## Prompt Techniques Used

- **Role Prompting:** Assigns the persona of a "Secure API Design" specialist.
- **Contextual Constraints:** Mandates the use of `@auth` directives for security, reinforcing best practices.
- **Task Decomposition:** Splits the request into distinct categories (Queries vs. Mutations) with specific parameters for each.
- **Instructional Prompting:** Provides rationale for security rules (e.g., "insecureReason") to ensure the generated code is self-documenting.
