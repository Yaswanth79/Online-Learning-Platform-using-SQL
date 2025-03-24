#Example Queries
#Get all courses along with their instructors:

SELECT c.Title AS CourseTitle, CONCAT(u.FirstName, ' ', u.LastName) AS Instructor
FROM Courses c
JOIN Users u ON c.InstructorID = u.UserID;

#List students enrolled in a specific course:

SELECT u.Username, u.Email
FROM Enrollments e
JOIN Users u ON e.UserID = u.UserID
WHERE e.CourseID = 1;

#Retrieve all discussions for a specific course:

SELECT u.Username, d.Content, d.PostDate
FROM Discussions d
JOIN Users u ON d.UserID = u.UserID
WHERE d.CourseID = 1;

#Find all lessons in a specific module:

SELECT l.Title, l.Content
FROM Lessons l
JOIN Modules m ON l.ModuleID = m.ModuleID
WHERE m.CourseID = 1;

#Get the list of quizzes and their questions:

SELECT q.Title AS QuizTitle, qs.QuestionText, qs.AnswerOptions
FROM Quizzes q
JOIN Questions qs ON q.QuizID = qs.QuizID
WHERE q.CourseID = 1;


