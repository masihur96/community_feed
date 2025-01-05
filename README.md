# **Community Feed App**

A Flutter application built with the MVVM architecture, designed to display community feeds dynamically. The app includes features like user authentication, creating posts with gradient backgrounds, reacting to posts, commenting, replying, and fetching feeds with real-time updates.

## **Screenshots**

<div style="display: flex; flex-wrap: wrap; gap: 10px;">

  <div style="flex-shrink: 0; width: 120px; text-align: center;">
    <img src="https://github.com/user-attachments/assets/b84b40f5-ca6c-4bd5-b1c6-7fc2d9854bed" alt="login" style="width: 100%; border-radius: 8px;" />
    <p>Login</p>
  </div>

  <div style="flex-shrink: 0; width: 120px; text-align: center;">
    <img src="https://github.com/user-attachments/assets/a126c32b-30f1-4e01-9c65-a2b0eae18f1f" alt="feed" style="width: 100%; border-radius: 8px;" />
    <p>Feed</p>
  </div>

  <div style="flex-shrink: 0; width: 120px; text-align: center;">
    <img src="https://github.com/user-attachments/assets/6aec5b5e-bbb5-4031-bc4c-ee312a71d183" alt="reaction" style="width: 100%; border-radius: 8px;" />
    <p>Reaction</p>
  </div>

  <div style="flex-shrink: 0; width: 120px; text-align: center;">
    <img src="https://github.com/user-attachments/assets/0a5df1c9-bbeb-4ab4-ba2e-43f3dd8fcc90" alt="comments" style="width: 100%; border-radius: 8px;" />
    <p>Comments</p>
  </div>

  <div style="flex-shrink: 0; width: 120px; text-align: center;">
    <img src="https://github.com/user-attachments/assets/9b7eda74-6123-490f-bff3-29ab52c5f10c" alt="create_post" style="width: 100%; border-radius: 8px;" />
    <p>Create Post</p>
  </div>

  <div style="flex-shrink: 0; width: 120px; text-align: center;">
    <img src="https://github.com/user-attachments/assets/f2c974d0-bd7c-42dc-b9d0-64f040d3078d" alt="logout" style="width: 100%; border-radius: 8px;" />
    <p>Logout</p>
  </div>

</div>



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
  - Reactions, comments, and counts.

### **Create Post**
- Allows users to:
  - Create posts with plain text.
  - Add optional gradient backgrounds to their posts.
- Posts are dynamically added to the feed upon creation.

### **Interactions**
- React to posts with predefined reactions (e.g., Like, Love).
- Add comments and replies to posts.
- Dynamic updates for reactions and comment counts.



## **Architecture**

The app uses the **MVVM (Model-View-ViewModel)** pattern:
- **Model**: Represents the data layer (e.g., `CommunityModel`).
- **View**: Manages the UI layer (`CreatePostScreen`, `FeedScreen`).
- **ViewModel**: Handles business logic and acts as a bridge between the View and Model.

---

## **Tech Stack**
- **Flutter**: Frontend framework for building cross-platform applications.
- **Provider**: State management for maintaining clean separation between UI and business logic.
- **Dio**: For making API requests.
- **Local Storage**: Used for caching offline data with SharedPreferences.

---

## **Setup Instructions**

1. **Clone the Repository**
   ```bash
   git clone https://github.com/your-username/community-feed-app.git](https://github.com/masihur96/community_feed.git
   cd community-feed-app
   flutter pub get
   flutter run
