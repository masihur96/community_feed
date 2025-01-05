Community Feed App
A Flutter application built with the MVVM architecture, designed to display community feeds dynamically. The app includes features like user authentication, creating posts with gradient backgrounds, reacting to posts, commenting, replying, and fetching feeds with real-time updates.

Features
Authentication
Login and Logout functionality with session management.
Authentication integrated with token-based API.
Community Feed
Fetches community feeds dynamically from the API.
Displays feeds with details such as:
User information
Feed content (text and images)
Reactions, comments, and share counts.
Create Post
Allows users to:
Create posts with plain text.
Add optional gradient backgrounds to their posts.
Posts are dynamically added to the feed upon creation.
Interactions
React to posts with predefined reactions (e.g., Like, Love).
Add comments and replies to posts.
Dynamic updates for reactions and comment counts.
Offline Mode
Caches previously fetched feeds locally for offline access.
Architecture
The app uses the MVVM (Model-View-ViewModel) pattern:

Model: Represents the data layer (e.g., CommunityModel).
View: Manages the UI layer (CreatePostScreen, FeedScreen).
ViewModel: Handles business logic and acts as a bridge between the View and Model.
Tech Stack
Flutter: Frontend framework for building cross-platform applications.
Provider: State management for maintaining clean separation between UI and business logic.
HTTP: For making API requests.
Local Storage: Used for caching offline data with options like Hive or SharedPreferences.
Setup Instructions
Clone the Repository

bash
Copy code
git clone https://github.com/your-username/community-feed-app.git
cd community-feed-app
Install Dependencies

bash
Copy code
flutter pub get
Run the App

Connect a device or start an emulator.
Run the app using:
bash
Copy code
flutter run
Configure API Keys

Update the APIs.getCommunityFeed and related endpoints with your actual API endpoints in the project.
Screenshots
Include screenshots of your app for visual demonstration:

Login Screen
Community Feed Screen
Create Post Screen
Comments and Replies
Testing
Unit Tests: Business logic tested for post creation, feed fetching, and error handling.
Integration Tests: UI flow tested for smooth interaction and API integration.
API Details
Authentication
Endpoint: /app/student/auth/login
Method: POST
Parameters:
email: User email.
password: User password.
Get Feeds
Endpoint: /getCommunityFeed
Method: POST
Parameters:
community_id
space_id
Create Post
Endpoint: /createPost
Method: POST
Parameters:
content: Post content (text).
bg_color: Gradient background (optional).
Folder Structure
graphql
Copy code
lib/
├── models/               # Data models
├── services/             # API and data handling
├── viewmodels/           # State management with business logic
├── views/                # Screens and UI components
│   ├── screens/          # Main app screens
│   ├── components/       # Reusable widgets
├── utils/                # Utility functions and constants
├── main.dart             # App entry point
Future Improvements
Add advanced reaction types with emojis.
Optimize local storage with better caching strategies.
Implement push notifications for real-time updates.
Improve UI with animations for interactions.
Contributors
Your Name - LinkedIn | GitHub
