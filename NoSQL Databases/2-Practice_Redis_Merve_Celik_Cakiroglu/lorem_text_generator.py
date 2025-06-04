from lorem_text import lorem
import os
os.chdir(os.path.dirname(__file__))

# Get the number of paragraphs
length = 30

# Generate paragraphs by considering the length
paragraph = lorem.paragraphs(length)

# Save the paragraphs to a file with extension .txt
with open('lorem_text.txt', 'w') as file:
    file.write(paragraph)
