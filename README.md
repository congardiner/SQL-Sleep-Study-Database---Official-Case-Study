# Overview

Sleep. We are all familiar with nights where we don't get enough of it. Whether it's due to work, stress, or just the demands of busy lives, a natural byproduct of this is sleep deprivation. If proper sleep hygiene isn't maintained, well, it can have serious effects on our health and overall well-being especially when measured as a 'small' habit over a long-term span of time. It is estimated that in a lifetime of 78 years of age, we will spend about 26 years sleeping if its 7-8 hours a night, which is about one-third of our lives according to a study conducted by the National Sleep Foundation in 2011. This is why it is important to track our sleep patterns and habits, so we can make informed decisions about how we can improve our sleep quality and overall health through data-driven insights.

This personal project is a sleep insights application that houses a relational database in MySQL to store, track, and analyze user sleep data with some other health metrics which when queried correctly has provided valuable insights into viable concerns for general sleep hygiene and implications for improving health overtime. This in no way is a substitute for medical advice, but rather a tool to help users understand their sleep patterns and make informed decisions about their health; this dataset was provided and sourced by a public dataset from Kaggle with the link provided here: https://www.kaggle.com/datasets/uom190346a/sleep-health-and-lifestyle-dataset information pertaining to demographics for users from the sleep study was excluded in order to abide by GDPR compliance and privacy concerns.

The dataset itself was used as a frame of reference to buildout a relational database, which as seen in this picture is the schema/ERD that I built out to form and compile relevant relationships as a baseline for creating the database. This practice was built-out in conjunction with then building out a script, with proper reference to establishing safeguards for data integrity practices, with the creation of each table written with proper sql syntax, and the insertion phase of the data itself for each respective column. 

Overall, this script has several key components that seek to answer a few guided questions about sleep hygiene and health metrics, such as:

1. What are general health metrics that influence or that could contribute to sleep altercations?
2. Are there sleep hygiene practices that if recorded and measured that might influence the database dataset? Night Routines?
3. What occupation as recorded contributes to the most sleep disorders by count? Is there an occupation that represents diversity in reported sleep disorders, or are they uniformly spread without any linear relationships?
4. What is the average sleep duration for users in the dataset, and how does it vary by age group?
  
These are just a few of the questions that I had concerning this dataset used for this personal project, there are a few others included therein and some disparity between the viability of the questions and the data-points themselves, which is expressed directly within the script.

The MySQL Database is somewhat limited on the rows/entries for each feature, I'd love to see or introduce more user data to diversify the dataset as a whole. With that being said, there were a few encountered roadblocks, one of which I am still puzzled about to this day concerning the data entry process and uploading of the dataset itself. This was one area that caused major grief from a performance standpoint as at first due to a 'in-line' error from the MySQL Bench Environment that restricted the uploading of local files. I tried several different methods that I was familiar with as I am fairly comfortable with MySQL and the syntax that surrounds it. With that being said, despite using the terminal to branch, and locally itemize commands, this didn't eradicate the issue. This led me to even the creating a separate python script to index and upload the csv file directly into the table(s) themselves using the sqlite library, along with the specific interelated dependencies, with a login directly into the database within MySQL. Unfortunately despite my best efforts, this script is currently not natively compiling correctly, so an old-school rudimentary system was used of individually assigning each insertion statement; needless to say this was tedious, but I am open to feedback/suggestions pertinent to this approach to either (1) eliminate the need for the script or (2) identify the issue with the 'in-line' error that contributed to file(s) not being recognized by the MySQL environment.


[Software Demo Video](http://youtube.link.goes.here)

# Relational Database

The relational database that I created is a MySQL database that houses sleep health and lifestyle data. It is designed to store user sleep data, health metrics, and other relevant information that can be queried to gain insights into sleep hygiene and health over time. Intently, I've tried to design and create the database so that it is incredibly easy to use and query, here is a brief overview of the database and its structure:

- The database is named `healthmetrics`.
- It is interconnected with (4) tables that are composed between one to many relationships.
- The tables are designed to store user data, sleep data, health metrics, and lifestyle data.

Here is a screenshot of the database schema that I created in MySQL Workbench:

![Health Metrics Database Schema](C:\Users\18cga\Documents\GitHub\SQL Sleep Study Database\test-csv-import-script.py)


# Development Environment

I used the MySQL Workbench to create the relational database and the tables within it. The database was built using SQL syntax, and the data was inserted into the tables using SQL INSERT statements. On the other hand, I also used Python within visual code studio to create a script intended on uploading the csv file or file(s) directly into the MySQL database that I created; as mentioned, this script is not currently functioning as intended due to an 'in-line' error that I have yet to resolve.


# Useful Websites

- [Kaggle Dataset](https://www.kaggle.com/datasets/uom190346a/sleep-health-and-lifestyle-dataset)
- [W3 Schools](https://www.w3schools.com/MySQL/mysql_join_cross.asp)
- [MySQL Official Documentation](https://dev.mysql.com/doc/)
- [Google Cloud](https://cloud.google.com/learn/what-is-a-relational-database?hl=en)
- [MySQL Connector Github](https://github.com/mysql/mysql-connector-python)

# Future Work

- I would love to fix the simple script that I created to upload the csv file directly into the MySQL database and/or fix my workbench environment to allow for the csv file to be uploaded directly from the local directory without the 'in-line' error.
- A dashboard that visualizes the data in a more user-friendly manner, perhaps using a library like Dash or Streamlit; this would be the next 'big' step in this project that would make the project way more customizable.
- Another item that I would like to improve is the ability to add more user data to the database, as this would allow for a more diverse dataset and better insights into sleep hygiene and health metrics.