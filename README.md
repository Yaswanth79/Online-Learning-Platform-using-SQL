# Online-Learning-Platform-using-SQL
SQL
Here's the content for your **README.md** for the **Online Learning Platform** project:

---

# Online Learning Platform

## Description

The **Online Learning Platform** is a comprehensive web-based application designed to facilitate online education. This platform allows users to enroll in courses, interact with instructors and peers, track their learning progress, and manage course content. The system supports various user roles including students, instructors, and administrators, each with specific functionalities to enhance the learning experience.

## Features

- **User Management:**
  - **Students:** Enroll in courses, track progress, and participate in discussions.
  - **Instructors:** Create and manage courses, upload content, and assess student performance.
  - **Administrators:** Manage users, oversee course content, and configure platform settings.

- **Course Management:**
  - Create and organize courses with modules, lessons, and quizzes.
  - Upload and manage course materials such as videos, documents, and presentations.
  - Define course prerequisites and enrollment criteria.

- **Progress Tracking:**
  - Monitor student progress through course modules and assignments.
  - Generate performance reports and track completion rates.

- **Discussion Forums:**
  - Participate in or moderate course-related forums.
  - Facilitate peer interaction and support.

## Technologies Used

- **HTML5**: For structuring web pages.
- **CSS3**: For styling and responsive design.
- **JavaScript**: For client-side interactivity.
- **SQL**: For database management.
- **Server-Side Language (PHP/Python/Node.js)**: For server-side scripting.
- **Bootstrap**: For responsive design and UI components.

## Database Schema

### Tables

1. **Users**
   - `UserID` (INT, Primary Key)
   - `Username` (VARCHAR, Unique)
   - `PasswordHash` (VARCHAR)
   - `Role` (ENUM: 'Student', 'Instructor', 'Administrator')
   - `Email` (VARCHAR)
   - `CreatedAt` (DATETIME)

2. **Courses**
   - `CourseID` (INT, Primary Key)
   - `Title` (VARCHAR)
   - `Description` (TEXT)
   - `InstructorID` (INT, Foreign Key)
   - `CreatedAt` (DATETIME)
   - `UpdatedAt` (DATETIME)

3. **Modules**
   - `ModuleID` (INT, Primary Key)
   - `CourseID` (INT, Foreign Key)
   - `Title` (VARCHAR)
   - `Description` (TEXT)
   - `Order` (INT)
   - `CreatedAt` (DATETIME)

4. **Lessons**
   - `LessonID` (INT, Primary Key)
   - `ModuleID` (INT, Foreign Key)
   - `Title` (VARCHAR)
   - `Content` (TEXT)
   - `VideoURL` (VARCHAR, Nullable)
   - `CreatedAt` (DATETIME)

5. **Quizzes**
   - `QuizID` (INT, Primary Key)
   - `CourseID` (INT, Foreign Key)
   - `Title` (VARCHAR)
   - `CreatedAt` (DATETIME)

6. **Questions**
   - `QuestionID` (INT, Primary Key)
   - `QuizID` (INT, Foreign Key)
   - `QuestionText` (TEXT)
   - `AnswerOptions` (JSON)
   - `CorrectAnswer` (VARCHAR)

7. **Enrollments**
   - `EnrollmentID` (INT, Primary Key)
   - `UserID` (INT, Foreign Key)
   - `CourseID` (INT, Foreign Key)
   - `EnrolledAt` (DATETIME)

8. **Discussions**
   - `DiscussionID` (INT, Primary Key)
   - `CourseID` (INT, Foreign Key)
   - `UserID` (INT, Foreign Key)
   - `PostDate` (DATETIME)
   - `Content` (TEXT)

## SQL Commands

### Creating Tables

```sql
CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    Role ENUM('Student', 'Instructor', 'Administrator') NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Courses (
    CourseID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Description TEXT,
    InstructorID INT,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt DATETIME ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (InstructorID) REFERENCES Users(UserID)
);

CREATE TABLE Modules (
    ModuleID INT AUTO_INCREMENT PRIMARY KEY,
    CourseID INT,
    Title VARCHAR(255) NOT NULL,
    Description TEXT,
    `Order` INT,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

CREATE TABLE Lessons (
    LessonID INT AUTO_INCREMENT PRIMARY KEY,
    ModuleID INT,
    Title VARCHAR(255) NOT NULL,
    Content TEXT,
    VideoURL VARCHAR(255),
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ModuleID) REFERENCES Modules(ModuleID)
);

CREATE TABLE Quizzes (
    QuizID INT AUTO_INCREMENT PRIMARY KEY,
    CourseID INT,
    Title VARCHAR(255) NOT NULL,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

CREATE TABLE Questions (
    QuestionID INT AUTO_INCREMENT PRIMARY KEY,
    QuizID INT,
    QuestionText TEXT NOT NULL,
    AnswerOptions JSON,
    CorrectAnswer VARCHAR(255),
    FOREIGN KEY (QuizID) REFERENCES Quizzes(QuizID)
);

CREATE TABLE Enrollments (
    EnrollmentID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    CourseID INT,
    EnrolledAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

CREATE TABLE Discussions (
    DiscussionID INT AUTO_INCREMENT PRIMARY KEY,
    CourseID INT,
    UserID INT,
    PostDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Content TEXT,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
```

### Example Queries

1. **Get all courses along with their instructors:**

    ```sql
    SELECT c.Title AS CourseTitle, CONCAT(u.FirstName, ' ', u.LastName) AS Instructor
    FROM Courses c
    JOIN Users u ON c.InstructorID = u.UserID;
    ```

2. **List students enrolled in a specific course:**

    ```sql
    SELECT u.Username, u.Email
    FROM Enrollments e
    JOIN Users u ON e.UserID = u.UserID
    WHERE e.CourseID = 1;
    ```

3. **Retrieve all discussions for a specific course:**

    ```sql
    SELECT u.Username, d.Content, d.PostDate
    FROM Discussions d
    JOIN Users u ON d.UserID = u.UserID
    WHERE d.CourseID = 1;
    ```

4. **Find all lessons in a specific module:**

    ```sql
    SELECT l.Title, l.Content
    FROM Lessons l
    JOIN Modules m ON l.ModuleID = m.ModuleID
    WHERE m.CourseID = 1;
    ```

5. **Get the list of quizzes and their questions:**

    ```sql
    SELECT q.Title AS QuizTitle, qs.QuestionText, qs.AnswerOptions
    FROM Quizzes q
    JOIN Questions qs ON q.QuizID = qs.QuizID
    WHERE q.CourseID = 1;
    ```

## Deployment

To deploy this platform, set up a server environment with a supported server-side language (PHP, Python, or Node.js) and a SQL database. Import the provided schema into your database, and configure the server-side scripts to interact with the database. 

## Contributing

Feel free to fork the repository and enhance the platform. If you have suggestions or find issues, please open an issue or submit a pull request.

## Acknowledgments

- **Bootstrap** for providing responsive design components.
- **FontAwesome** for icons and UI elements.
- **SQL** documentation for reference.

---.
