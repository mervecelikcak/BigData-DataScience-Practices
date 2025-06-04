import redis

# Connect to Redis
r = redis.Redis(host='localhost', port=6379, db=0)

def get_greeting(key, name):
    # Retrieve the value associated with the key from Redis
    value = r.get(key)

    print("{} {}".format(value.decode('ascii'), name))

if __name__ == "__main__":
    import sys
    # Get the key and name from the command-line arguments
    key = sys.argv[1]
    name = sys.argv[2]

    # Call the function to retrieve the greeting and print it
    get_greeting(key, name)

