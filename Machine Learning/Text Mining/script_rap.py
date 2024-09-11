import pandas as pd
import nltk
from nltk.corpus import stopwords
from nltk.stem import WordNetLemmatizer, PorterStemmer
from collections import Counter
from wordcloud import WordCloud
import matplotlib.pyplot as plt
import seaborn as sns
import sys
import os

# Télécharger les ressources nécessaires
nltk.download('punkt')
nltk.download('stopwords')
nltk.download('wordnet')

# Initialiser les outils de traitement de texte
stop_words = set(stopwords.words('english'))
lemmatizer = WordNetLemmatizer()
stemmer = PorterStemmer()

# Fonction de prétraitement du texte
def preprocess_text(text):
    tokens = nltk.word_tokenize(text.lower())
    tokens = [token for token in tokens if token.isalpha() and token not in stop_words]
    lemmas = [lemmatizer.lemmatize(token) for token in tokens]
    stems = [stemmer.stem(token) for token in tokens]
    return stems

# Fonction pour traiter un fichier texte
def process_file(file_path):
    with open(file_path, 'r', encoding='utf-8') as file:
        lyrics = file.read()

    # Diviser le texte en lignes (chaque ligne est une phrase ou un vers)
    lines = lyrics.split('\n')

    # Appliquer la prétraitement aux lignes
    cleaned_lines = [preprocess_text(line) for line in lines]

    # Compter les mots dans toutes les lignes
    word_counts = Counter()
    for line in cleaned_lines:
        word_counts.update(line)

    print(f"Mots les plus fréquents dans le fichier {file_path}:")
    print(word_counts.most_common(50))

    # Convertir les listes de tokens en texte
    text = ' '.join([' '.join(line) for line in cleaned_lines])

    # Afficher le nuage de mots
    plot_word_cloud(text, f'Nuage de mots des paroles du fichier {os.path.basename(file_path)}')

    # Créer un DataFrame à partir des comptes de mots
    word_freq_df = pd.DataFrame(word_counts.most_common(20), columns=['Word', 'Frequency'])

    # Afficher un histogramme des mots les plus fréquents
    plt.figure(figsize=(12, 8))
    sns.barplot(x='Frequency', y='Word', data=word_freq_df)
    plt.title(f'20 mots les plus fréquents dans le fichier {os.path.basename(file_path)}')
    plt.show()

    # Calculer la longueur des phrases
    line_lengths = [len(line.split()) for line in lines]

    # Afficher un histogramme de la distribution de la longueur des phrases
    plt.figure(figsize=(12, 8))
    sns.histplot(line_lengths, kde=True)
    plt.title(f'Distribution de la longueur des phrases dans le fichier {os.path.basename(file_path)}')
    plt.xlabel('Longueur des phrases')
    plt.ylabel('Fréquence')
    plt.show()

# Fonction pour afficher le nuage de mots
def plot_word_cloud(text, title):
    wc = WordCloud(width=600, height=600, background_color='white', max_words=200, stopwords=stop_words, max_font_size=90, collocations=False, random_state=42)
    wc.generate(text)

    plt.figure(figsize=(10, 7))
    plt.imshow(wc, interpolation='bilinear')
    plt.axis('off')
    plt.title(title, fontsize=10, pad=10)
    plt.show()

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script_rap.py <file_path>")
        sys.exit(1)

    file_path = sys.argv[1]
    process_file(file_path)
