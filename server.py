from flask import Flask, request, jsonify
from flask_cors import CORS
from baseclass import get_card_id_by_name

app = Flask(__name__)
CORS(app)
data = []
round_cards_id = []
active_card = []
enemy_cards_id = []

@app.route('/submit_cards', methods=['POST'])
def submit_cards():
    global round_cards_id
    round_cards_id = []
    data = request.json
    print(f"Полученные данные: {data}")
    for i in data['selected_character_cards']:
        card_id = get_card_id_by_name(i)
        print(card_id)
        round_cards_id.append(card_id)
    print(round_cards_id)
    active_card.append(round_cards_id[0])
    return jsonify({"message": "Карты успешно получены"}), 200

@app.route('/update_active_card', methods=['POST'])
def update_active_card():
    global round_cards_id  # Явно указываем, что работаем с глобальной переменной
    global active_card

    otvet = request.get_json()
    print(f"Полученные данные: {otvet}")  # {"active_card_number": индекс}

    k = otvet['active_card_number']

    # Проверка на корректность индекса
    if not (0 <= k < len(round_cards_id)):
        return jsonify({"error": "Некорректный индекс карты"}), 400

    # Меняем местами активную карту и карту с индексом k
    round_cards_id[0], round_cards_id[k] = round_cards_id[k], round_cards_id[0]

    # Обновляем активную карту
    active_card.clear()
    active_card.append(round_cards_id[0])

    print(f"Текущая активная карта: {active_card}")
    print(f"Обновленный порядок карт: {round_cards_id}")

    return jsonify({"message": "Активная карта обновлена", "active_card": active_card[0]}), 200


# Фиктивная база данных
players_data = []

@app.route('/save_player_data', methods=['POST'])
def save_player_data():
        data = request.get_json()
        print(data)
        print(f"Полученные данные: {data}")
        for i in data['card_names']:
            card_id = get_card_id_by_name(i)
            print(card_id)
            enemy_cards_id.append(card_id)
        print(enemy_cards_id)
        return jsonify({"message": "Карты успешно получены"}), 200



if __name__ == '__main__':
    app.run(debug=True)
