def trouver_solutions_des(valeur_cible):
    solutions = set()
    for de1 in range(1, 7):
        for de2 in range(1, 7):
            for de3 in range(1, 7):
                if de1 + de2 + de3 == valeur_cible:
                    solution = tuple(sorted([de1, de2, de3]))
                    solutions.add(solution)
    return solutions

def afficher_toutes_solutions():
    for valeur_cible in range(3, 19):
        solutions = trouver_solutions_des(valeur_cible)
        print(f"Solutions pour {valeur_cible}: {solutions}")

afficher_toutes_solutions()
