# CrewHub Full-Stack V7 English + Romanian Toggle

Versiune orientată pe business logic:
- grupuri pentru sport / ieșiri / travel / gaming / study / work
- activități cu status calculat automat
- RSVP: Vin / Poate / Nu vin
- rezerve automate când activitatea este plină
- promovare automată din rezerve când cineva renunță
- cost împărțit automat
- chat pe fiecare grup, stil messenger simplificat
- inbox cu ultimele mesaje
- date demo salvate în backend/data/database.json

## 1. Pornește backendul

Terminal 1:

```powershell
cd backend
npm install
npm run dev
```

Verificare:

```text
http://localhost:3000/api/health
```

## 2. Pornește Flutter

Terminal 2:

```powershell
cd mobile
flutter clean
flutter create . --platforms=windows
flutter pub get
flutter run -d windows
```

Pentru Chrome:

```powershell
cd mobile
flutter clean
flutter create .
flutter pub get
flutter run -d chrome
```

## Android emulator

```powershell
flutter run --dart-define=API_URL=http://10.0.2.2:3000/api
```

## Important

Folosește folder nou. Nu copia peste proiectele vechi.


## Fix-uri în V5

- Chat-ul folosește ruta `/api/groups/:groupId/messages`.
- Backendul răspunde cu `CrewHub API V5` în `/api/health`.
- Crearea unei activități nu se mai dublează în UI.
- Selectorul de oră permite doar valori din 30 în 30 minute: 18:00, 18:30, 19:00 etc.
- Dacă ai backend vechi pornit pe portul 3000, oprește-l înainte:

```powershell
taskkill /F /IM node.exe
```

Apoi pornește backendul V5.


## Fix V6

V6 rezolvă eroarea:

```text
TypeError: Cannot read properties of undefined (reading 'length')
```

Cauza era un `backend/data/database.json` vechi, care nu avea câmpul `messages`.
Backendul V6 migrează automat structura veche.

Dacă ai încă erori, oprește Node și șterge baza locală:

```powershell
taskkill /F /IM node.exe
Remove-Item .\backend\data\database.json -Force
```

Apoi pornește backendul din nou.


## V7 language update

- Default language is English.
- There is a `RO` button in the login AppBar and main AppBar.
- Press `RO` to switch to Romanian.
- Press `EN` to switch back to English.
- Backend demo seed data is in English by default.

If you still see old Romanian demo data, delete the old local JSON database:

```powershell
taskkill /F /IM node.exe
Remove-Item .\backend\data\database.json -Force
npm run dev
```
