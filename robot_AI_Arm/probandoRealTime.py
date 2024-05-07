# pip install pyaudio
# pip install keyboard
# pip install SpeechRecognition

import speech_recognition as sr
import keyboard

def listen(timeout=None):
    # Initialize the recognizer
    recognizer = sr.Recognizer()

    # Open the microphone and start recording
    with sr.Microphone() as source:
        print("Listening... Press Space to stop recording.")
        try:
            # Adjust for ambient noise
            recognizer.adjust_for_ambient_noise(source)

            # Define a function to stop recording when the space key is pressed
            stop_recording = False
            def stop_on_space(e):
                nonlocal stop_recording
                if e.name == 'space':
                    stop_recording = True

            # Start listening for the space key press
            keyboard.on_press(stop_on_space)

            # Capture audio input until the space key is pressed or the timeout is reached
            while not stop_recording:
                audio = recognizer.listen(source, timeout=timeout)

                print("Processing...")

                # Use the recognizer to convert audio to text
                recognized_speech = recognizer.recognize_google(audio)
                print("Recognized speech:", recognized_speech)
                return recognized_speech

        except sr.WaitTimeoutError:
            print("No speech detected.")
        except sr.UnknownValueError:
            print("Could not understand audio.")
        except sr.RequestError as e:
            print("Error fetching results: {0}".format(e))
        finally:
            # Stop listening for the space key press
            keyboard.unhook_all()

# Example usage:   

conversion_text = listen()
punctuation = ".,;:!?()[]{}"

# Remove punctuation marks from the original string
for char in punctuation:
    conversion_text = conversion_text.replace(char, '')

# Split the string into a list of words
words_array = conversion_text.split()

#print(words_array)



def find_draw_phrases(words_array):
    result = []
    i = 0
    while i < len(words_array) - 1:  # Iterate through the words array
        word = words_array[i].lower()
        if word in ['draw','raw','naw']:
            # Check if the word after 'draw' exists
            if i + 1 < len(words_array):
                result.append(words_array[i + 2])
            else:
                result.append('')  # Append an empty string if no word after 'draw'
            
            # Move to the next word after the word 'draw'
            i += 1  
        else:
            i += 1

    return result

# Test the function with the provided words array
# words_array = ["can", "you", "draw", "luis","in", "plane", "two"]
result = find_draw_phrases(words_array)
print(result)  



# Write the result to a file
with open("result.txt", "w") as f:
    for pair in result:
        f.write(pair[0] + "\n")