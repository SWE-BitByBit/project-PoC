# Proof of Concept

## Setup 

1. Installare Flutter seguendo la **guida ufficile**
https://docs.flutter.dev/install/quick
2. Eseguire il **setup del development environment** per eseguire, compilazione e il deploy su Android
https://docs.flutter.dev/platform-integration/android/setup
3. **Verifica** dell'ambiente
```sh
flutter doctor
```
4. Installazione delle **dipendenze**
```sh
flutter pub get
```
5. Crea un **nuovo emulatore con Android Studio**
6. **Verifica** la presenza dei **dispositivi**
```sh
flutter emulators && flutter devices
```
7. **Esegui** l'app sull'emulatore
```sh
flutter emulators --launch <Id device>
```