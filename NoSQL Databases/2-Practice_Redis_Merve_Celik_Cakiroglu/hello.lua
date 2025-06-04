-- Retrieve the content stored in Redis associated with the key 'greetkey'
local greet = redis.call("get", KEYS[1])

-- Concatenate the retrieved content with the provided argument "Carlos"
local result = greet .. " " .. ARGV[1]

-- Return the concatenated result
return result

