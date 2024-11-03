from flask import Flask, request, jsonify
from flask_cors import CORS
import tensorflow as tf
import numpy as np
import pickle
from tensorflow.keras.preprocessing.sequence import pad_sequences

app = Flask(__name__)
CORS(app)

# Load the saved model and tokenizer
model = tf.keras.models.load_model('phishing_model.h5')
print("Model loaded.")
with open('tokenizer.pickle', 'rb') as handle:
    tokenizer = pickle.load(handle)
print("Tokenizer loaded.")

max_length = 200  # Must match the length used during training

@app.route('/health', methods=['GET'])
def health():
    print('Health check')
    return jsonify({'status': 'ok'}), 200

@app.route('/check_url', methods=['POST'])
def check_url():
    data = request.get_json()
    url = data.get('url')

    if not url:
        return jsonify({'error': 'No URL provided.'}), 400

    print(f"Received URL: {url}")

    # Preprocess the URL
    sequence = tokenizer.texts_to_sequences([url])
    padded_sequence = pad_sequences(sequence, maxlen=max_length, padding='post', truncating='post')

    # Make prediction
    prediction = model.predict(padded_sequence)
    probability = prediction[0][0]
    print(f"Prediction probability: {probability}")

    is_malicious = probability >= 0.5

    response = {
        'is_malicious': bool(is_malicious),
        'probability': float(probability),
        'message': 'The URL is malicious.' if is_malicious else 'The URL is legitimate.'
    }

    return jsonify(response), 200

if __name__ == '__main__':
    app.run(debug=True)