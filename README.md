# Library Management System (Java web app)

Mid-semester Web Technology exam, AUCA, October to November 2024. Nzigiye Iyaad Milan, ID 23866.

A library system built with Java servlets, JSP and Hibernate on PostgreSQL. It handles user registration and login, books, shelves, rooms and locations, borrowers, and membership plans. Each membership type sets how many books a member can borrow, and the system works out fines on late returns. A report page summarises the data.

Stack: Java EE (servlets, JSP, JSTL), Hibernate ORM with c3p0 pooling, PostgreSQL, Lombok, Maven.

Structure: `dao/` holds the data access classes, `servlets/` the request handlers, `util/` the input validation.

Run: create a PostgreSQL database, set its details in `src/hibernate.cfg.xml`, then build with `mvn package` and deploy the WAR to a Java EE server such as GlassFish or Tomcat.
