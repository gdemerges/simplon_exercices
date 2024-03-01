import random

def guess_the_number():
    number = random.randint(1, 100)
    guesses = []

    while True:
        guess = int(input("Votre choix : "))

        if guess < 1 or guess > 100:
            print("OUT OF BOUNDS")
            continue

        guesses.append(guess)

        if guess == number:
            print(f"Félicitation tu l'as déviné en {len(guesses)} tentatives!")
            break

        if len(guesses) == 1:
            if abs(number - guess) <= 10:
                print("WARM!")
            else:
                print("COLD!")
        else:
            if abs(number - guess) < abs(number - guesses[-2]):
                print("WARMER!")
            else:
                print("COLDER!")

guess_the_number()
