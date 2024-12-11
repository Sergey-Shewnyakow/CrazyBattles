import psycopg2
import os
from dotenv import load_dotenv

load_dotenv()
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_HOST = os.getenv("DB_HOST")

import psycopg2

def get_card_id_by_name(card_name):
    try:
        # Подключение к базе данных
        connection = psycopg2.connect(
            dbname= DB_NAME,
            user=DB_USER,
            password=DB_PASSWORD,
            host=DB_HOST,
            port="5432"
        )

        cursor = connection.cursor()

        # SQL-запрос
        query = "SELECT id FROM charactercards WHERE name = %s;"
        cursor.execute(query, (card_name,))  # Подставляем имя карты

        # Извлекаем результат
        result = cursor.fetchone()

        if result:
            return result[0]  # Возвращаем ID карты
        else:
            print(f"Карта с именем '{card_name}' не найдена.")
            return None

    except Exception as e:
        print(f"Ошибка при работе с базой данных: {e}")
    finally:
        # Закрываем соединение
        if connection:
            cursor.close()
            connection.close()


class CharacterCard:
    def __init__(self, id, name, asset, infopage, cardclass, skill, ultimate, passiveskill):
        self.id = id
        self.name = name
        self.asset = asset
        self.infopage = infopage
        self.cardclass = cardclass
        self.skill = skill
        self.ultimate = ultimate
        self.passiveskill = passiveskill
        self.hp = 8

    def __str__(self):
        return (f"CharacterCard(id={self.id}, name='{self.name}', asset='{self.asset}', "
                f"infopage={self.infopage}, cardclass='{self.cardclass}', skill='{self.skill}', "
                f"ultimate='{self.ultimate}', passiveskill='{self.passiveskill}', hp={self.hp})")


def fetch_cards_from_db():
    try:
        conn = psycopg2.connect(
            dbname= DB_NAME,
            user=DB_USER,
            password=DB_PASSWORD,
            host=DB_HOST,
            port="5432"
        )
        cursor = conn.cursor()


        cursor.execute("""
            SELECT id, name, asset, infopage, cardclass, skill, ultimate, passiveskill
            FROM public.charactercards;
        """)


        rows = cursor.fetchall()


        cards = [
            CharacterCard(
                id=row[0],
                name=row[1],
                asset=row[2],
                infopage=row[3],
                cardclass=row[4],
                skill=row[5],
                ultimate=row[6],
                passiveskill=row[7]
            )
            for row in rows
        ]


        cursor.close()
        conn.close()

        return cards

    except Exception as e:
        print("Ошибка при работе с базой данных:", e)
        return []


cards = fetch_cards_from_db()

#
# for card in cards:
#     print(card)
