# Database & ERD Design Prompt

**Project Stage:** Database Design & Data Modeling  
**Goal:** Design the relational database schema for Firebase Data Connect (PostgreSQL) using GraphQL syntax.

---

## Refined Prompt (Final Version)

**Role:** You are a Database Engineer expert in Firebase Data Connect and PostgreSQL.

**Task:** Design a GraphQL schema (`schema.gql`) for Firebase Data Connect.

**Required Data Structure:**
1. **Users:** Store basic profile info and identify if they are a Client or Provider.
2. **Services:** A catalog of base services (e.g., "Deep Clean") with default prices.
3. **Provider Profiles:** Links to a User. Contains business info (ratings, experience) and their specific version of a Service (custom price/duration).
4. **Bookings:** Links a Client to a Provider's Service. Needs date, time, status, and cost.
5. **Reviews:** Ratings and comments linked to completed bookings.

**Requirements:**
- Use `@table` directives.
- Use PostgreSQL-compatible types (UUID/String for IDs, Timestamp for dates).
- Ensure foreign key relationships are clear.

**Output:**
- The complete `schema.gql` file content.

---

## Prompt Techniques Used

- **Role Playing:** Sets the AI as a "Database Engineer" to ensure technical accuracy in schema design.
- **Constraint-Based Prompting:** Enforces specific field types (Timestamp, Float) and relationship models (One-to-One).
- **Domain-Specific Language (DSL) Targeting:** Explicitly requests GraphQL syntax with Firebase Data Connect directives (`@table`).
- **Structured Input:** Provides a clear list of entities and fields to be mapped to code.
