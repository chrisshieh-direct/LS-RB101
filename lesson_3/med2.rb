require 'yaml'
MESSAGES = YAML.load_file('med2.yml')

arr = MESSAGES['gettysburg'].split(".")

p arr.sort