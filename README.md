[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/kk0uTvYN)
# Flutter Exam 1

Questo progetto contiene tre esercizi Flutter:

1. **Hotel** - Pagina per visualizzare le stanze di un hotel
2. **Ristorante** - Pagina per visualizzare il menu di un ristorante
3. **Negozio Surf** - Pagina per visualizzare le tavole da surf di un negozio online

## Riferimenti Visivi

Nella cartella `assets/plan` troverai le immagini che mostrano cosa devi sviluppare per ciascun esercizio.

## Immagini

Devi trovare immagini gratuite dal sito [Pexels](https://www.pexels.com/it-it/), scaricarle e inserirle nella cartella `assets/images` per utilizzarle nella tua applicazione.

## Struttura JSON

Di seguito trovi la struttura JSON per ciascun esercizio. Usa questi esempi per capire come creare le classi Dart.

### Boards (Tavole da Surf)

```json
{
  "id": 1,
  "modello": "Wave Master 3000",
  "marca": "Quiksilver",
  "prezzo": 549.99,
  "lunghezza": "6'2\"",
  "volume": "35L",
  "disponibile": true,
  "url_immagine": "https://picsum.photos/id/101/400/300"
}
```

### Menu (Ristorante)

```json
{
  "id": 51,
  "piatto": "Spaghetti alle Vongole",
  "categoria": "Primi",
  "prezzo": 18,
  "ingredienti": ["Spaghetti", "Vongole", "Prezzemolo"],
  "is_vegan": false,
  "disponibile": true,
  "url_immagine": "https://picsum.photos/id/301/400/300"
}
```

### Rooms (Hotel)

```json
{
  "id": 101,
  "nome_stanza": "Suite Vista Mare",
  "tipologia": "Deluxe",
  "prezzo_notte": 185,
  "posti_letto": 2,
  "servizi": ["Wi-Fi", "A/C", "Minibar"],
  "disponibile": true,
  "url_immagine": "https://picsum.photos/id/201/400/300"
}
```
