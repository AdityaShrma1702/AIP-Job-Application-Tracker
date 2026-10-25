[README.md](https://github.com/user-attachments/files/33932355/README.md)
# AIP Job Application Tracker

A Java web application developed as an MCA AIP mini-project to help users manage and monitor job applications in one place.

## Features

- Add job applications
- View applications on a dashboard
- Edit application details
- Delete applications
- Track application statuses
- View dashboard statistics

## Technologies

- Java
- JSP (JavaServer Pages)
- Java Servlets
- JDBC / DAO-based data access
- Maven
- Apache Tomcat
- HTML and CSS

> The database technology and exact versions are intentionally not specified here. Add them after confirming the project's actual configuration.

## Project Structure

```text
AIP Job Application Tracker/
├── pom.xml
├── src/
│   └── main/
│       ├── java/       # Java source code
│       └── webapp/    # JSP, HTML, CSS, and web resources
├── README.md
└── .gitignore
```

The tree above is illustrative. Keep the package names and file locations that already exist in your project.

## Running the Project

1. Install a compatible JDK, Apache Tomcat, and NetBeans (or another Java IDE).
2. Open the project in your IDE using the existing `pom.xml`.
3. Configure the database connection using your local setup.
4. Make sure credentials are stored locally and are not committed to Git.
5. Clean and build the Maven project.
6. Run or deploy the web application to Tomcat.
7. Open the application URL shown by your IDE or server.

Exact setup steps depend on the database and configuration used in your local project.

## Security Notes

- Do not commit database passwords, API keys, `.env` files containing secrets, or private configuration.
- Do not commit real personal data from a database.
- Keep machine-specific IDE settings out of the repository.

## Academic Project

**Project:** AIP Job Application Tracker  
**Purpose:** MCA AIP mini-project

## Future Improvements

- Add input validation and clearer error messages
- Add user authentication if required
- Improve automated testing and documentation
