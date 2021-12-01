## Installeer de nodige software voor Onderzoekstechnieken

## Installeer eerst de Chocolatey package manager
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

## Installeer software:

# Algemeen bruikbare applicaties, niet specifiek voor Onderzoekstechnieken
# De volgende applicaties zijn wellicht al geïnstalleerd. Verwijder het
# commentaarteken (#) als je ze toch wil laten installeren door het script

#choco install -y vscode     # Visual Studio Code (optioneel)
#choco install -y git        # Git client, Git Bash
#choco install -y gitkraken  # Git GUI (optioneel)
choco install -y firacode       # Lettertype met ligaturen voor code-editors
choco install -y activeperl     # Dependency voor de latexmk compiler

# Applicaties voor LaTeX
choco install -y miktex      # LaTeX distributie, compilers
choco install -y texstudio   # LaTeX IDE
choco install -y JabRef      # Bibliografische databank

# Applicaties voor R
#choco install -y r.project   # De R programmeertaal
#choco install -y r.studio    # IDE voor R


# Install fonts voor HoGent
#https://fonts.google.com/specimen/Montserrat
#https://www.dafontfree.net/code-pro-black-regular/f62435.htm


# Configure TexStudio
# Commands:
# Latexmk: latexmk -xelatex -shell-escape -synctex=1 -interaction=nonstopmode -file-line-error %
# XeLaTex: xelatex.exe -synctex=1 -interaction=nonstopmode -shell-escape %.tex

# Build >
# Build & view: compile & view
# Standard compiler: Latexmk
# bibliografie: Biber

# Editor >
# Change double quotes: English quotes
# Show line numbers

# VSC plugin: Latex Workshop van James Yu
# https://hogent.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=fb48c4c5-846b-49dc-9e14-acad008e1c22
# 20-24min