-- Retrieve the value stored in Redis associated with the key specified by KEYS[1]
local value = redis.call("get", KEYS[1])

-- Multiply the retrieved value by the provided number (ARGV[1])
local result = value * ARGV[1]

-- Return the result
return result

