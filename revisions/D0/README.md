# Legenden om Zelda: Links Opvågning

Lad os oversætte Link's Awakening til dansk!

Der findes allerede flere skandinaviske oversættelser vi kan lade os inspirere af.
Norsk version: [Legenden om Zelda: Links Oppvåkning](https://github.com/tobiasvl/zelda-links-awakening-NO/)
Svensk version: [Legenden om Zelda: Links Uppvaknande](https://www.romhacking.net/translations/1245/)

## Oplæg

Dette repo er oprindeligt baseret [denne rom afmontering](https://github.com/zladx/LADX-Disassembly), men er en fork af [Legenden om Zelda: Links Oppvåkning](https://github.com/tobiasvl/zelda-links-awakening-NO/).

## Diskuter

- Opret et [issue](https://github.com/aruneberg/zelda-links-awakening-DK/issues?q=is%3Aissue+is%3Aopen+sort%3Aupdated-desc) hvis der er noget som skal rettes til.

## Bidrag med oversættelser

- Tekst som skal oversettes: https://github.com/tobiasvl/zelda-links-awakening-NO/tree/main/src/text
- Font er allerede ordnet til at inkludere æ, ø og å fra den norske version: https://github.com/tobiasvl/zelda-links-awakening-NO/tree/main/src/gfx/fonts
- Grafikk, som titelskærmen, kan vi ordne efter behov

## Test spillet

For at kompilere selve ROM-en:

### Installer RGBDS og avhengigheter

RGBDS er Game Boy-assembleren vi bruger for bygge ROM af dette repo, så den skal installeres. For eksempel, på Ubuntu (inkluderet WSL på Windows):

```bash
cd /tmp
sudo apt-get install bison flex libpng-dev python3               # Installer avhengigheter
wget https://github.com/gbdev/rgbds/archive/refs/tags/v0.5.2.zip # Last ned RGBDS
unzip v0.5.2 && cd rgbds-0.5.2                                   # Pakk ut RGBDS
make && sudo make install                                        # Installer RGBDS
```

### Byg ROM

Lige nu har @tobiasvl bare hacket den engelske versionen til så den bruges som den norske. Så dette bør fungere (på Linux):

```
make
```

Eller, for at bygge med debug-funktionalitet:

```
make debug
```

Så bygges både ROM og debug-symboler som kan benyttes i [BGB](https://github.com/zladx/LADX-Disassembly/wiki/Tooling-for-reverse-engineering#bgb).

### Debug

Hvis man bygger ROM-en, vil første lagringsfil altid være en DEBUG-fil hvor alt er låst op, med følgende funktionalitet:

#### Tekst-debugger

Hvis du går til Marin foran hanestatuen i landsbyen, kan du teste alle dialoger i spillet.

- Brug D-paden for å velge et tal XX (venstre/højre vælger en'ere, op/ned ti'ere)
- Tryk A for at vise tekst nr. XX
- Tryk B for at vise tekst nr. 1XX
- Tryk SELECT for at vise tekst nr. 2XX

#### Noclip

Du kan aktivere «noclip»-modul på en af to måder:

- Hold D-paden nede og tryk SELECT for at fryse spillet, og tryk så SELECT igen for at aktivere noclip
- Tryk START (pauseskærm) og så SELECT

#### Warp

Tryk B + SELECT på kortet for at teleportere direkte til hvor du vil. Du kan ende midt inde i en væg, aktiver i dette tilfælde noclip.

#### Vind spillet

Tryk START på kortet for at teleportere direkte til Vindfisken og slutscenen.

## Ressourcer

I tilfælde at vi behøver at analysere ROM-en:

- [disassembling How-Tos](https://github.com/zladx/LADX-Disassembly/wiki)
- [Artemis251's Link's Awakening Cache](http://artemis251.fobby.net/zelda/index.php): ROM map, maps data format
- [Xkeeper's Link's Awakening depot](https://xkeeper.net/hacking/linksawakening/): maps tilesets and save format infos
- [LALE](https://github.com/anotak/LALE): level editor, notes on maps data format
- [The Legend of Zelda Link's Awakening /DX Speedrunning Wiki](http://spiraster.x10host.com/LADXWiki/index.php/) : infos on wrong warps and map data format
- [Zelda III Disassembly](http://www.zeldix.net/t143-disassembly-zelda-docs) ([archive](https://web.archive.org/web/20180315181518/http://www.zeldix.net/t143-disassembly-zelda-docs)): good source on Zelda SNES source code, which has many similarities to LADX
- [Disassembling Link's Awakening](https://kemenaran.winosx.com/posts/category-disassembling-links-awakening/): a series of blog posts and progress reports
- Discord: [LADX](https://discord.gg/sSHrwdB)
