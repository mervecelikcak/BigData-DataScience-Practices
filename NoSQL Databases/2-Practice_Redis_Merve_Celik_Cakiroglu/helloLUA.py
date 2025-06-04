import redis

# Connect to Redis
r = redis.Redis(host='localhost', port=6379, db=0)

def execute_lua_script(redis_key, name):
    # Read Lua script from hello.lua file
    with open('hello.lua', 'r') as file:
        lua_script = file.read()

    # Upload Lua script to Redis cache and get the registered script
    script = r.register_script(lua_script)

    # Call the uploaded script using Redis key and ARGV as parameters
    result_bytes = script(keys=[redis_key], args=[name])

    # Decode byte string to regular string using ascii encoding
    result_string = result_bytes.decode('ascii')

    return result_string

if __name__ == "__main__":
    import sys

    redis_key = sys.argv[1]
    name = sys.argv[2]

    # Call the function to execute the Lua script and print the result
    result = execute_lua_script(redis_key, name)
    print(result)
