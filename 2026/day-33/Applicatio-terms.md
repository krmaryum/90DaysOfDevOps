## Application:
An application is a software system that allows users to perform tasks by combining a user interface, backend logic, and data storage.

## Frontend (UI)
Frontend (UI) is the visual and interactive part of an application that users see and use in a browser or app.

## Backend API
Backend API is the server-side system that processes requests, interacts with databases, and sends data to the frontend.

## Database
A database stores persistent data so applications can keep information safely even after restarts or crashes.

Applications rely on databases to keep important information such as:
- user accounts
- orders
- products
- messages

### Common Databases
Popular databases jo applications mein use hoti hain:
- MySQL
- PostgreSQL
- MongoDB
- Redis

### What is Persistent Data?
Persistent data means data that remains stored even after the application or server restarts or Crashes.

For example:

If a server crashes or restarts:
- User accounts should still exist
- Orders should still be saved
- Messages should remain stored

This long-term stored information is called persistent data.

## Role in Application Architecture
```id="Onhfa3"
User
 ↓
Frontend
 ↓
Backend API
 ↓
Database
```
