import os
from aiogram import Bot, Dispatcher, types
from aiogram.types import InlineKeyboardMarkup, InlineKeyboardButton
from aiogram.utils import executor
import database
from dotenv import load_dotenv

load_dotenv()

TOKEN = os.getenv("TOKEN")
bot = Bot(token=TOKEN)
dp = Dispatcher(bot)

keyboard = InlineKeyboardMarkup().add(
    InlineKeyboardButton("Открыть веб-приложение", url="https://t.me/CBattleTestBot/ytubik")
)

@dp.message_handler(commands=["start"])
async def start_handler(message: types.Message):
    user_id = message.from_user.id
    username = message.from_user.username

    if not database.user_exists(user_id):
        database.add_user(user_id, username)
        await message.reply("Добро пожаловать!")
    else:
        await message.reply("С возвращением!")

    await message.answer("Нажмите на кнопку, чтобы открыть веб-приложение:", reply_markup=keyboard)

if __name__ == "__main__":
    executor.start_polling(dp, skip_updates=True)