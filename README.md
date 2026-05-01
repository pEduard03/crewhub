<<<<<<< HEAD
# CrewHub Full-Stack V8 English + Romanian Toggle
=======
# CrewHub Full-Stack V7 English + Romanian Toggle
>>>>>>> fc7dbce31452fcc05e5a2c33d11d97fc0d710a1d

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


<<<<<<< HEAD
## V8 language update
=======
## V7 language update
>>>>>>> fc7dbce31452fcc05e5a2c33d11d97fc0d710a1d

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
<<<<<<< HEAD


## V9 Auth Start

Prima pagină a aplicației are acum:
- Continue with Google (demo local)
- Login cu email și parolă
- Register cu nume, email și parolă
- RO/EN toggle pe ecranul de autentificare
- Backend endpoints:
  - POST `/api/auth/register`
  - POST `/api/auth/login`
  - POST `/api/auth/google-demo`

Cont demo:
```text
Email: cosmin@example.com
Password: password123
```

Pentru Google real în Play Store/App Store, următorul pas este integrarea cu Firebase Auth / Google OAuth.


## V10 City Onboarding

După login/register/Google demo apare obligatoriu un pop-up pentru alegerea orașelor din România.

Funcționalități:
- căutare orașe din România;
- dacă scrii `b`, apar orașe care încep cu B: București, Brașov, Bacău etc.;
- trebuie ales cel puțin un oraș ca să continui;
- orașele alese sunt salvate în user;
- în profil apare lista de orașe selectate.

Endpoint-uri noi:
```text
GET  /api/locations/romania/cities?search=b
POST /api/users/me/cities
```

Dacă testezi peste date vechi, șterge baza locală:
```powershell
taskkill /F /IM node.exe
Remove-Item .\backend\data\database.json -Force
```


## V10 Fixed

Includes mandatory Romania city onboarding after login and fixed backend city search route.


## V11 All Romania Cities

- City onboarding now uses a larger list of Romania cities/towns.
- Search works for every letter from the alphabet.
- Examples:
  - `b` -> București, Brașov, Bacău, Bistrița, Buzău...
  - `c` -> Constanța, Cluj-Napoca, Craiova, Călărași...
  - `i` -> Iași, Ineu, Iernut, Isaccea...
- The backend returns up to 200 matches, so letters with many cities are not cut after 30 results.
- City list count in backend: 317.


## V12 Profile Plus

Profile now includes:
- profile photo selection from gallery/file picker;
- sex/gender dropdown;
- biography field;
- personal profile links:
  - Instagram
  - Facebook
  - TikTok
  - LinkedIn
  - Website

Backend endpoint:
```text
PATCH /api/users/me/profile
```

For this local demo, the avatar is saved as Base64 in `backend/data/database.json`.
For production, this should be moved to storage such as Supabase Storage / Firebase Storage / S3.


## V13 Chat Avatars

Group chat now shows a profile icon next to each message:
- if the user has a profile photo, the photo is shown;
- if not, the avatar shows initials;
- current user messages are aligned right with avatar on the right;
- other members' messages are aligned left with avatar before the message;
- backend updates group member profile data when a user changes their profile photo.


## V14 Chat Avatar Sync

Fix:
- old groups now receive updated profile avatar data from the backend;
- when the current user changes their profile photo, the app updates that user's member snapshot inside all existing groups;
- chat bubbles for your own messages always use the current live user avatar, even in old conversations.

This fixes the issue where new groups showed the new profile photo, but older conversations still showed the old photo.


## V15 Logout

Profile now includes a Log out button:
- added at the bottom of Profile;
- shows a confirmation dialog;
- returns to the Login screen;
- clears the navigation stack, so Back does not reopen the app;
- backend includes `POST /api/auth/logout` for local demo completeness.


## V16 Chat Reactions & Replies

Chat now supports Instagram-style interactions:
- long press on any message;
- quick reactions: ❤️ 😂 🔥 👍 😮 👏;
- tapping the same reaction again removes it;
- choosing a different reaction replaces your previous one;
- Reply option;
- replied messages show a preview of the original message above your message;
- reactions and replies are saved in the backend.

New backend endpoint:
```text
PATCH /api/messages/:messageId/reaction
```

Message model now includes:
```text
replyToMessageId
reactions[]
```


## V17 Message Popup + Delete For Me

Chat actions changed from bottom sheet to a small popup next to the message.

Long press / right click on a message:
- Add reaction
- Delete for you
- Reply

Delete for you:
- hides the message only for the current user;
- other users still see the message;
- backend stores this in `hiddenForUserIds`.

New backend endpoint:
```text
PATCH /api/messages/:messageId/delete-for-me
```

Messages are loaded with:
```text
GET /api/groups/:groupId/messages?userId=<currentUserId>
```


## V18 City Groups

Create Group now includes a new category:
- City / Oraș

When City/Oraș is selected, a new Location section appears:
- search Romanian city;
- select the city;
- add exact location/neighborhood/place.

Backend groups now store:
```text
country
city
location
```

This allows groups such as:
```text
Iași Community
Category: City
City: Iași
Location: Copou / Centru / Palas
```


## V19 Social City Location

Fix based on feedback:
- City/Oraș is no longer hidden as a main category.
- In Create Group, choose main category Social.
- Under Social, a new subcategory dropdown appears:
  - General
  - City/Oraș
- When City/Oraș is selected, the Location section appears:
  - Romanian city search
  - exact location/neighborhood/place

Backend groups store:
```text
category: social
socialSubtype: city
country
city
location
```


## V20 City Category

Fix based on feedback:
- City / Oraș is now an independent main category, separate from Social.
- There is no Social subcategory anymore.
- When category City/Oraș is selected, the Location section appears.
- When any other category is selected, the Location section disappears.

Create Group flow:
```text
Category: City / Oraș
City: Iași
Location: Copou
```

Backend group fields:
```text
category: city
country: Romania
city
location
```


## V21 Category Lines

Create Group category selector changed:
- categories are no longer hidden inside a dropdown;
- Social and City/Oraș are visible as separate lines;
- City/Oraș appears directly under Social;
- selecting City/Oraș opens the City / Location section;
- selecting any other category hides the location section.

Visible order:
```text
Sport
Social
City / Oraș
Travel
Gaming
Study
Work
Family
Custom
```


## V22 Simple Group Form

Create Group form is now exactly:
- Group name / Numele grupului
- Description / Descrierea
- Category / Categoria
- City / Orașul

City is not a category anymore. Location was removed from the create-group form.
The backend still stores `city`; `location` remains empty for compatibility.


## V23 City Location Field

Create Group form now has:
- Group name / Numele grupului
- Description / Descrierea
- Category / Categoria
- City / Orașul
  - Location / Locație

Location is optional and can be used for:
```text
strada
școala
terenul
sala
cartierul
parcul
```

Backend already stores this in the group `location` field.


## V24 Email Validation

Login and Register now validate email format on both sides:

Frontend Flutter:
```text
name@gmail.com -> accepted
alex@yahoo.ro -> accepted
alexya@yy -> rejected
alex@domain -> rejected
alex domain.com -> rejected
```

Backend:
- `POST /api/auth/register` rejects invalid emails
- `POST /api/auth/login` rejects invalid emails

Validation rule:
```text
must contain @
must contain a domain
must contain a dot extension of at least 2 characters
```


## V25 Login Error Text

Login/Register UX update:
- wrong login email/password now shows a red inline error under the password field;
- invalid email format also shows inline red error;
- editing email/password clears the error;
- error text supports RO/EN:
  - RO: `Emailul sau parola sunt greșite.`
  - EN: `Wrong email or password.`
=======
>>>>>>> fc7dbce31452fcc05e5a2c33d11d97fc0d710a1d
