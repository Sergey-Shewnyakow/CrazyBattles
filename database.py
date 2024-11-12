import psycopg2
import os
from dotenv import load_dotenv


load_dotenv()
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_HOST = os.getenv("DB_HOST")

# Подключение к базе данных
connection = psycopg2.connect(
    dbname=DB_NAME,
    user=DB_USER,
    password=DB_PASSWORD,
    host=DB_HOST
)
cursor = connection.cursor()

# Создание таблицы users, если она не существует
cursor.execute('''
    CREATE TABLE IF NOT EXISTS users (
        id SERIAL PRIMARY KEY,
        user_id BIGINT UNIQUE NOT NULL,
        username TEXT
    );
''')
connection.commit()

# Функция проверки, есть ли пользователь в базе данных
def user_exists(user_id):
    cursor.execute("SELECT * FROM users WHERE user_id = %s;", (user_id,))
    return cursor.fetchone() is not None

# Функция добавления нового пользователя в базу данных
def add_user(user_id, username):
    cursor.execute("INSERT INTO users (user_id, username) VALUES (%s, %s);", (user_id, username))
    connection.commit()
