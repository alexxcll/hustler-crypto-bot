# Contributing to Hustler Bot

Wir begrüßen Beiträge zum Hustler Bot Projekt! Dieser Leitfaden hilft dir beim Einstieg.

## Verhaltenskodex

Durch die Teilnahme an diesem Projekt stimmst du zu, unseren Verhaltenskodex einzuhalten.

## Wie du beitragen kannst

### Fehler melden

Bevor du Fehlerberichte erstellst, überprüfe bitte die Issue-Liste, um Duplikate zu vermeiden. 

### Funktionen vorschlagen

Funktionsanfragen sind willkommen! Bitte:

- Überprüfe, ob die Funktion bereits existiert oder geplant ist
- Beschreibe die Funktion und ihren Anwendungsfall klar
- Erkläre, warum sie vorteilhaft wäre

### Pull Requests

1. **Repository forken**
2. **Feature-Branch erstellen** (`git checkout -b feature/amazing-feature`)
3. **Änderungen vornehmen**
   - Befolge den vorhandenen Code-Stil
   - Füge Tests für neue Funktionalität hinzu
   - Aktualisiere Dokumentation nach Bedarf
4. **Änderungen committen** (`git commit -m 'Add amazing feature'`)
5. **Push und PR erstellen**

## Entwicklungssetup

### Backend
```bash
cd backend
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

### Frontend
```bash
cd frontend
npm install
npm start
```

### Mobile
```bash
cd mobile
flutter pub get
flutter run
```

## Code-Stil

- **Python**: PEP 8, Black-Formatierung, Type-Hints
- **JavaScript/TypeScript**: Prettier, ESLint
- **Dart**: Dart Style Guide, `dart format`

## Testing

- Schreibe Tests für alle neuen Funktionen
- Erhalte oder verbessere die Testabdeckung
- Teste sowohl Happy-Path als auch Fehler-Fälle

Danke fürs Beitragen! 🚀
