Im Rahmen unserer IT-Ausbildung wurde eine containerisierte Kniffel-Plattform auf einem Raspberry Pi 4 realisiert. Mittels Docker und DDEV betreiben wir eine modulare Umgebung, in der ein nginx‑Reverse‑Proxy (ddev-web) alle Anfragen routet. Eine MariaDB-Datenbank (ddev-db) versorgt die Python‑Flask‑Anwendung (knuffel) mit Spiel‑Daten. Terminalzugriff erfolgt sicher über wetty, Monitoring über glances, das Dashboard über einen eigenen Dienst (dashboard-server.yaml).

Vorteile dieser Architektur sind:

Isolation: Jeder Dienst läuft in seinem eigenen Container, was die Sicherheit erhöht.
Portabilität: Komplettes Setup lässt sich auf anderen Systemen identisch reproduzieren.
Wartbarkeit: Updates und Neustarts einzelner Komponenten sind schnell und ohne Ausfall des Gesamtsystems möglich.

Das Dateisystem ist klar strukturiert:
kniffel/
├ .ddev/                # zentrale Konfiguration, Compose-Dateien, Entrypoints
├ public/               # statisches Dashboard
└ local_kniffel/        # Quellcode und Dockerfile für Flask-App

Mit dieser Lösung steht das Kniffel-Spiel über http://192.168.245.110 bereit – sicher, flexibel und wartungsfreundlich.


---

As part of our IT training, we implemented a containerized Kniffel platform on a Raspberry Pi 4. Using Docker and DDEV, we set up a modular architecture where an nginx reverse proxy (ddev-web) routes all traffic. A MariaDB database (ddev-db) provides game data to the Python-Flask application (knuffel). Terminal access is handled securely via wetty, monitoring via glances, and the dashboard runs as its own service (dashboard-server.yaml).

Key benefits include:

Isolation: Each service runs in its own container, enhancing security.
Portability: The entire stack can be reproduced identically on other systems.
Maintainability: Updates and restarts of individual components occur quickly without system-wide downtime.

The file structure is concise:
kniffel/
├ .ddev/                # central config, Compose files, entrypoints
├ public/               # static dashboard
└ local_kniffel/        # source and Dockerfile for Flask app

With this setup, the Kniffel game is accessible at http://192.168.245.110 – secure, flexible, and easy to maintain.

----

Python-Code: https://github.com/TheRandomWeirdo/knuffel
