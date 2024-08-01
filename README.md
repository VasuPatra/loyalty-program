# Loyalty Program Application

## Current Status

This Rails application implements a basic loyalty program with functionality for tracking user transactions, accumulating points, and issuing rewards. Below is a summary of the current state of the project:

## Current Status

### Completed

1. **Point Earning Rules:**
   - Users earn 10 points for every $100 spent.
   - Foreign spending earns double the standard points.

2. **Issuing Rewards:**
   - **Free Coffee:** Issued for 100 points in a calendar month.
   - **Birthday Reward:** Free Coffee is given during the user's birthday month.
   - **5% Cash Rebate:** Given to users with 10+ transactions over $100.
   - **Free Movie Tickets:** Awarded to new users who spend over $1000 within 60 days of their first transaction.

3. **Loyalty Tiers:**
   - **Standard Tier:** 0 points.
   - **Gold Tier:** 1000 points.
   - **Platinum Tier:** 5000 points.
   - Tiers are calculated based on the highest points in the last two cycles.

4. **Points Expiry and Bonuses:**
   - Points expire annually.
   - 4x Airport Lounge Access Reward given upon reaching Gold tier.
   - 100 bonus points awarded every calendar quarter for spending over $2000.

5. **Background Jobs:**
   - Integrated Sidekiq and Sidekiq-Cron for:
     - Updating loyalty tiers.
     - Issuing quarterly bonus points.
     - Free Rewards

6. **Frontend Interfaces:**
   - **Home Page:** Created with Bootstrap, includes signup and login buttons.
   - **User Dashboard:** Displays transactions, rewards, current points, and user tier.

7. **Database Schema:**
   - Created tables: `users`, `payouts`, `points`, `rewards`, `user_rewards`.
   - Added necessary fields for tier and points tracking.

8. **Seed Data:**
   - Added sample data for users, payouts, points, rewards, and user rewards.

### Pending

1. Loyalty tiers are calculated on the highest points in the last 2 cycles
### How to Run the Application

1. **Setup:**
   - Clone the repository: `git clone [repository-url]`
   - Navigate to the project directory: `cd [project-directory]`
   - Install gems: `bundle install`
   - Setup the database: `rails db:setup`
   - Seed the database: `rails db:seed`

2. **Running the Server:**
   - Start the Rails server: `rails server`
   - Access the application at `http://localhost:3000`

3. **Running Sidekiq:**
   - Start Sidekiq: `bundle exec sidekiq`


