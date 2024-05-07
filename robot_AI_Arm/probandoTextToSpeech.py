# `pip3 install assemblyai` (macOS)
# `pip install assemblyai` (Windows)

import assemblyai as aai
import string

aai.settings.api_key = "1a280045b34c40c68a80ed48d73dbf17"
transcriber = aai.Transcriber()

transcript = transcriber.transcribe("textoprueba2.mp4")
# transcript = transcriber.transcribe("./my-local-audio-file.wav")

print(transcript.text)

conversion_text = transcript.text
punctuation = ".,;:!?()[]{}"

# Remove punctuation marks from the original string
for char in punctuation:
    conversion_text = conversion_text.replace(char, '')

# Split the string into a list of words
words_array = conversion_text.split()

print(words_array)



def find_write_phrases(words_array):
    result = []
    for i in range(len(words_array) - 2):  # Iterate up to the third-to-last word
        first_word = words_array[i].lower()
        third_word = words_array[i + 2].lower()
        if first_word in ['write', 'right', 'wright', 'ride'] and third_word in ['plane', 'plain']:
            result.append([words_array[i + 1], words_array[i + 3]])
    return result


# Example usage:
words_array = ["write", "Louise", "plane", "two"]
result = find_write_phrases(words_array)
print(result)

for pair in result:
    # Check if the second word is 'one', 'two', 'three', or 'four'
    if pair[1] == 'one':
        pair[1] = '1'
    elif pair[1] == 'two':
        pair[1] = '2'
    elif pair[1] == 'three':
        pair[1] = '3'
    elif pair[1] == 'four':
        pair[1] = '4'

# Write the result to a file
with open("result.txt", "w") as f:
    for pair in result:
        f.write(pair[0] + " " + pair[1] + "\n")
