# Adding OAuth to Media Ranker

## Learning Goals
- Practice using OAuth in a web application
- Practice using Session Variables to track a user across multiple HTTP requests

## Exercise Description
Our Media Ranker web app was a wonderful website with one major flaw: the way we implemented user login is extremely insecure.  In this assignment you will modify Media Ranker so that it can securely **authenticate** multiple users via OAuth and **authorize** them to view, manage and vote on works.

Build your project using _branches_, with at least _one branch_ per wave.  As you finish a wave merge the changes into the main branch. You shall submit one pull request at the end once you are complete.

## Wave 1: Authentication via OAuth

Following the steps in the Textbook curriculum, add OAuth to your Media Ranker Application and enable a user to log in.

**Requirements:**
- Add all necessary gems and configuration
- Repurpose the existing login functionality to now be a single log in button (on home page or nav bar)
- The log in button shall turn in to a log out button when the user is logged in
- All other requirements from in-class notes apply:
  - Managed via `session`
  - `SessionsController`
  - `User` model


## Wave 2: Basic Authorization (Page Access)

In this wave we will create authorization logic to enforce rules that govern what pages on the site users and guests (unauthenticated browsers) can view. The rule we'll use is that guests can only access the main page, and all logged-in users can access the show and index pages for all categories of work.

**Requirements:**
-  Ensure that users who are not logged in can see *only* the main page with the spotlight and top 10 items. No other pages should be viewable by the guest user.
-  Ensure that users who are logged in can see the rest of the pages.


## Wave 3: Advanced Authorization (Ownership)

In this wave we'll create advanced authorization logic to enforce rules that govern what _changes_ users can make to the site's data. The rules here are more complex than for accessing pages:
- Guests cannot change any data on the site
- All logged-in users can add new works to the site
  - Those works are owned by the user that created them
- The user who owns a given work can:
  - Edit that work
  - Delete that work

**Requirements:**
- Modify the edit and delete functionality to ensure that users can only change works they are associated with.
  - Optional: Consider how this could be implemented at the model layer.

## Wave 4: Optional
Do some research into how to use Google or another OAuth provider for authentication and use that provider.   

## Resources
-  [Ada Textbook Curriculum: Session](https://github.com/Ada-Developers-Academy/textbook-curriculum/blob/master/09-intermediate-rails/session.md)
- [Ada Textbook Curriculum: OAuth](https://github.com/Ada-Developers-Academy/textbook-curriculum/blob/master/09-intermediate-rails/oauth.md)
-  [OmniAuth Gem](https://github.com/omniauth/omniauth)
