# Proof of Concept

## Setup 

1. Installare Flutter seguendo la **guida ufficiale**

https://docs.flutter.dev/install/quick

3. Eseguire il **setup del development environment** per poter compilare, eseguire, testare e deployare l'app su Android

https://docs.flutter.dev/platform-integration/android/setup

4. **Verificare** l'ambiente
```sh
flutter doctor
```
4. Installare le **dipendenze necessarie** da dentro la directory del progetto
```sh
flutter pub get
```
5. Creare un **nuovo emulatore con Android Studio**

https://developer.android.com/studio/run/managing-avds?hl=it

6. **Verificare** la presenza degli **emulatori**
```sh
flutter emulators && flutter devices
```
Il nome da usare nello step seguente è quello che si ha dato all'emulatore in Android Studio, che dovrebbe comparire dopo aver eseguito il comando.
7. **Eseguire** l'app sull'emulatore
```sh
flutter emulators --launch <Nome emulatore completo>
```
```sh
flutter run
```
### Risoluzione errori e problemi vari
- **In caso di errore Lint `Windows file separators (\) and drive letter separators (':') must be escaped`**: fare l'escape dei `:` nel path sdk.dir in `android/local.properties`. Il path dovrebbe essere qualcosa del tipo `C:\\Users\\mario\\AppData\\Local\\Android\\sdk`. Verificarne la risoluzione tramite `gradlew lintDebug`; eventualmente chiudere e riaprire VS Code.
- **In caso di app bloccata allo step `Running Gradle task 'assembleDebug'...`**: fare `cd android`, poi `./gradlew clean build`. Questo comando può richiedere una decina di minuti per terminare.
- **In caso di emulatore che non carica (schermata nera)**: Provare a premere il pulsante di avvio a fianco del simulatore (quello a forma di cerchio con la linea dentro). In alternativa, provare anche ad andare sul dispositivo in Android Studio (dalla schermata principale: tre puntini > virtual device manager), premere i 3 puntini sul dispositivo d'interesse > Wipe Data.

### Miglioramento prestazioni emulatore
- Da Android Studio, recarsi sulla lista dei dispositivi (dalla schermata principale: tre puntini > virtual device manager), premere i 3 puntini sul dispositivo d'interesse > Edit > Advanced Settings > Abilitare Quick Boot e aumentare RAM
- Se non si può cambiare la RAM: premere i 3 puntini sul dispositivo d'interesse > Show On Disk. Aprire `config.ini` e impostare `hw.ramSize` a piacimento
- Con emulatore avviato, premere i 3 puntini sul menu affianco all'emulatore in esecuzione > Settings > Advanced > Impostare OpenGL ES Renderer a `Desktop Native OpenGL`
