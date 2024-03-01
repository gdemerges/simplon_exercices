def verifier_parite():
    while True:
        try:
            nombre = int(input("Veuillez saisir un nombre entier positif : "))
            if nombre < 0:
                print("Le nombre doit être positif. Veuillez réessayer.")
            else:
                if nombre % 2 == 0:
                    print(f"Le nombre {nombre} est pair.")
                else:
                    print(f"Le nombre {nombre} est impair.")
                break
        except ValueError:
            print("Ce n'est pas un nombre entier. Veuillez saisir un nombre entier.")

verifier_parite()
