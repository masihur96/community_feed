# **Community Feed App**

A Flutter application built with the MVVM architecture, designed to display community feeds dynamically. The app includes features like user authentication, creating posts with gradient backgrounds, reacting to posts, commenting, replying, and fetching feeds with real-time updates.

---

## **Features**

### **Authentication**
- Login and Logout functionality with session management.
- Authentication integrated with token-based API.

### **Community Feed**
- Fetches community feeds dynamically from the API.
- Displays feeds with details such as:
  - User information.
  - Feed content (text and images).
  - Reactions, comments, and share counts.

### **Create Post**
- Allows users to:
  - Create posts with plain text.
  - Add optional gradient backgrounds to their posts.
- Posts are dynamically added to the feed upon creation.

### **Interactions**
- React to posts with predefined reactions (e.g., Like, Love).
- Add comments and replies to posts.
- Dynamic updates for reactions and comment counts.

### **Offline Mode**
- Caches previously fetched feeds locally for offline access.

---

## **Architecture**

The app uses the **MVVM (Model-View-ViewModel)** pattern:
- **Model**: Represents the data layer (e.g., `CommunityModel`).
- **View**: Manages the UI layer (`CreatePostScreen`, `FeedScreen`).
- **ViewModel**: Handles business logic and acts as a bridge between the View and Model.

---

## **Tech Stack**
- **Flutter**: Frontend framework for building cross-platform applications.
- **Provider**: State management for maintaining clean separation between UI and business logic.
- **HTTP**: For making API requests.
- **Local Storage**: Used for caching offline data with options like Hive or SharedPreferences.

---

## **Setup Instructions**

1. **Clone the Repository**
   ```bash
   git clone https://github.com/your-username/community-feed-app.git
   cd community-feed-app
