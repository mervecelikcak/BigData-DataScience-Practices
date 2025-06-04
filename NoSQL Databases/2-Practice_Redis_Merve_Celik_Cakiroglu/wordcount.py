import sys
import re
import redis
from collections import Counter

# Function to clean text and extract words
def extract_words(file_path):
    with open(file_path, 'r') as file:
        text = file.read().lower()
        # Remove punctuation and special characters
        cleaned_text = re.sub(r'[^a-zA-Z\s]', '', text)
        # Split text into words
        words = cleaned_text.split()
    return words

# Function to connect to Redis and generate word ranking
def generate_word_ranking(words):
    # Connect to Redis
    r = redis.Redis(host='localhost', port=6379, db=0)
    # Create a sorted set in Redis
    sorted_set_key = 'word_ranking'
    for word, count in Counter(words).items():
        # Insert words into the sorted set with their count as score
        r.zadd(sorted_set_key, {word: count})

    # Retrieve the ranking of the 10 words with more occurrences
    ranking = r.zrevrange(sorted_set_key, 0, 9, withscores=True)
    return ranking

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 wordcount.py <file_path>")
        sys.exit(1)

    file_path = sys.argv[1]
    words = extract_words(file_path)
    ranking = generate_word_ranking(words)

    # Print the ranking on the screen
    print("Word Ranking:")
    for rank, (word, count) in enumerate(ranking, start=1):
        print(f"{rank}. {word.decode('utf-8')}: {int(count)}")

