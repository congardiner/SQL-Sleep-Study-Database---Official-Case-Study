import pandas as pd
import mysql.connector

print("Script started")


# Database connection details
conn = mysql.connector.connect(
    host='localhost',
    user='root',
    password='',
    database='healthmetrics'
)

print("Connected to MySQL Server. Message to Start Sequence...")


cursor = conn.cursor()

df = pd.read_csv(r"")

print("CSV columns:", list(df.columns))  

print("CSV loaded into the MySQL Workbench.")


success = 0



for idx, row in df.iterrows():
    sql = """
    INSERT INTO temp_import
    (gender, age, occupation, sleep_duration, sleep_quality, activity_minutes, stress_level, bmi_category, blood_pressure, heart_rate, daily_steps, sleep_disorder)
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """
    values = (
        row.get('Gender', None),
        row.get('Age', None),
        row.get('Occupation', None),
        row.get('Sleep Duration', None),
        row.get('Quality of Sleep', None),
        row.get('Physical Activity Level', None),
        row.get('Stress Level', None),
        row.get('BMI Category', None),
        row.get('Blood Pressure', None),
        row.get('Heart Rate', None),
        row.get('Daily Steps', None),
        row.get('Sleep Disorder', None)
    )


    # Convert NaN to None for MySQL
    values = tuple(None if pd.isna(v) else v for v in values)
    cursor.execute(sql, values)
    success += 1


print("Work almost done...")

conn.commit()
cursor.close()
conn.close()
print(f"Inserted {success} rows into the database.")
(print("This is simply a confirmation message..."))