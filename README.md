Főtáv
======
FŐTÁV pályázatára készített Corona Labs keretrendszeren fejlesztett promóciós játék

### Bevezetés
A játék a Corona Labs által fejlesztett Corona Cross-Platfrom Engine használatával készült.
Ez az eszköz lényegesen leegyszerűsíti a mobil játékok fejlesztését, mivel egy előre erre felkészített platformot ad, és mellé a szükséges eszközöket.
Így egy magasabb absztrakciós szinten történik a fejlesztés, elfedésre kerülnek az alacsonyabb rétegek.
Maga a kód csupán egy Lua szkript, ami magán a Corona platformon tud interpretálódni.

### A projekt környezet beállítása
A projekt teszteléséhez és Desktop környezetben való futtatásához, továbbá a Build-hez a Corona Game Engine szükséges, amit a következő weboldalról érhetünk el:
https://coronalabs.com/product/

Egy leírás a telepítésről (összefoglalva alább is szerepel):
https://docs.coronalabs.com/guide/start/installWin/index.html

A letöltéshez regisztráció szükséges, ami ingyenes, akárcsak maga a Corona Engine.
Miután regisztráltunk és beléptünk, töltsük le a Corona SDK-t, ami magában foglalja mindazt, amire szükségünk lesz, majd telepítsük a szoftvert. A Corona-n kívül csupán egy helyesen feltelepített JDK-ra lesz szükség (http://www.oracle.com/technetwork/java/javase/downloads/index.html).
A telepítés után a Corona Simulator-t kell elindítanunk. A programot a webes felületen készített felhasználónkkal tudjuk használni. Az eszköz a következőket tudja:
* Kezeli a Corona SDK-s projektjeinket.
* Egy szimulátort biztosít, ahol Desktop környezetben tudjuk tesztelni a megírt kódunkat akár különböző eszközökön is.
* Egy konzolablakot is megnyit, ahol a játékunk log-jait láthatjuk

Töltsük le a Főtáv projektet a GitHub-ról, ha még nem tettük, és csomagoljuk ki egy mappába.
A Corona Simulator-ban az Open Project-re kattintva tallózzuk ki a projekt főkönyvtárában lévő main.lua állományt. Ezzel a projekt meg is jegyződik a Corona számára.
Ezzel a játék be is töltődött és elindult.

### Build
* A játékot a Corona Simulator-ból tudjuk build-elni. Mivel ez egy integrált megoldás és a Corona saját szerverén fut, magát a build folyamatot nem lehetséges a Corona SDK-n kívül elvégezni.
* Nyissuk meg a projektet az előző részben leírtak alapján.
* A Corona Simulator-ban kattintsunk a File menüben lévő Build gombra, ahol válasszuk az Android-ot. (A Corona képes több rendszerre is build-elni, de nekünk az Android volt a célpont.)
* A megjelenő felületen igazából az alapértelmezett értékeket meghagyhatjuk, nem befolyásolják érdemben a játék működését. A Save to Folder lehet érdekes, ez a készítendő apk fájl helyét jelöli. Kattintsunk alul a Build gombra és várjuk meg, amíg lezajlik a Build a Corona szerverein és visszaküldik a kész alkalmazást.
* Ha megvan az apk, akkor azt valamilyen módon másoljuk át egy Androidos készülékre és telepítsük ott fel. A játéknak ugyanúgy kell ott is futnia, feltéve, hogy az eszköz hardverkapacitása elégséges.

---
### Tervezett funkciók, fejlesztések
* Mindegyik pályát be lehessen tölteni és az alkalmazáslogika helyesen működjön mindenhol.
* A pályák végén megjelenjen egy felület, ahol látjuk a teljesítményünket és visszatérhetünk a térképre.
* A térkép jelenlegi hibáinak javítása, a kezelés fejlesztése.

* Tesztesetek írása az alkalmazás minden részéhez (maga a Unit tesztek alapjai már megvannak).
* LDoc használata a source dokumentáció elkészítéséhez.

---

TODO list:
 * Vissza gomb implementációja
 * Pinch zoom (kétujjas zoom)
 * show/hide/destroy functionök logikája
<<<<<<< HEAD
 * logic: isEnd, endCheck()
          isWithinError() tesztelése
          rating() tesztelése
 * @Martin level.lua 32. 33. sor
 * A random felhős mókát bele lehet rakni a master-be, ha már jól megy
 * @Szabi a maps screen-t kéne még fixálni (drag/click, zoom, minden kerületre lehessen kattolni)
=======
 * homescreen felhők randomizálása
>>>>>>> scene-implementation
