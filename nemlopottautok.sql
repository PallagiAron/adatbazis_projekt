-- ========================
-- Ügyfelek tábla
-- ========================
CREATE TABLE ugyfelek (
    id INT AUTO_INCREMENT PRIMARY KEY,                      -- Egyedi azonosító (automatikusan növekvő szám)
    nev VARCHAR(100) NOT NULL,                              -- Ügyfél teljes neve (max. 100 karakter)
    email VARCHAR(100) UNIQUE NOT NULL,                     -- E-mail cím (egyedi, max. 100 karakter)
    telefon VARCHAR(20),                                    -- Telefonszám (max. 20 karakter)
    jogositvany_szam VARCHAR(50) UNIQUE NOT NULL,           -- Jogosítvány száma (egyedi, max. 50 karakter)
    regisztracio_datum TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- Regisztráció dátuma (automatikus időbélyeg)
);

-- ========================
-- Telephelyek tábla
-- ========================
CREATE TABLE telephelyek (
    id INT AUTO_INCREMENT PRIMARY KEY,          -- Egyedi azonosító
    nev VARCHAR(100) NOT NULL,                  -- Telephely neve (pl. "Budapest - Központ")
    cim VARCHAR(200) NOT NULL                   -- Telephely címe
);

-- ========================
-- Járművek tábla
-- ========================
CREATE TABLE jarmuvek (
    id INT AUTO_INCREMENT PRIMARY KEY,                                      -- Egyedi azonosító
    marka VARCHAR(50) NOT NULL,                                             -- Autó márkája (pl. Toyota)
    modell VARCHAR(50) NOT NULL,                                            -- Autó modellje (pl. Corolla)
    evjarat INT NOT NULL,                                                  -- Gyártási év (pl. 2021)
    rendszam VARCHAR(20) UNIQUE NOT NULL,                                  -- Rendszám (egyedi, max. 20 karakter)
    alvazszam VARCHAR(50) UNIQUE NOT NULL,                                 -- Alvázszám (VIN, egyedi)
    allapot ENUM('elerheto', 'berbeadva', 'szerviz') NOT NULL,            -- Jármű állapota
    napi_berleti_dij DECIMAL(10, 2) NOT NULL,                              -- Napi bérleti díj (pl. 15990.00)
    telephely_id INT NOT NULL,                                             -- Hivatkozás, melyik telephelyhez tartozik
    FOREIGN KEY (telephely_id) REFERENCES telephelyek(id)                 -- Külső kulcs a telephelyek táblára
);

-- ========================
-- Foglalások tábla
-- ========================
CREATE TABLE foglalasok (
    id INT AUTO_INCREMENT PRIMARY KEY,                                       -- Egyedi azonosító
    ugyfel_id INT NOT NULL,                                                  -- Hivatkozás az ügyfélre
    jarmu_id INT NOT NULL,                                                   -- Hivatkozás a járműre
    kezdet_datum DATE NOT NULL,                                              -- Foglalás kezdete
    veg_datum DATE NOT NULL,                                                 -- Foglalás vége
    statusz ENUM('fuggoben', 'megerositve', 'lemondva') NOT NULL,           -- Foglalás állapota
    FOREIGN KEY (ugyfel_id) REFERENCES ugyfelek(id),                         -- Kapcsolat az ügyfelek táblával
    FOREIGN KEY (jarmu_id) REFERENCES jarmuvek(id)                           -- Kapcsolat a járművek táblával
);

-- ========================
-- Kölcsönzések tábla
-- ========================
CREATE TABLE kolcsonzesek (
    id INT AUTO_INCREMENT PRIMARY KEY,                                         -- Egyedi azonosító
    foglalas_id INT NOT NULL,                                                 -- Kapcsolat egy foglaláshoz
    atvetel_idopont TIMESTAMP,                                                -- Jármű átvételének időpontja
    visszahozatal_idopont TIMESTAMP,                                          -- Jármű visszahozatalának időpontja
    vegosszeg DECIMAL(10,2),                                                  -- Végösszeg (Ft)
    statusz ENUM('aktiv', 'befejezve', 'keses') NOT NULL DEFAULT 'aktiv',     -- Kölcsönzés státusza
    FOREIGN KEY (foglalas_id) REFERENCES foglalasok(id)                       -- Külső kulcs a foglalások táblához
);

-- ========================
-- Fizetések tábla
-- ========================
CREATE TABLE fizetesek (
    id INT AUTO_INCREMENT PRIMARY KEY,                                       -- Egyedi azonosító
    kolcsonzes_id INT NOT NULL,                                              -- Hivatkozás egy kölcsönzésre
    fizetes_idopont TIMESTAMP DEFAULT CURRENT_TIMESTAMP,                     -- Fizetés időpontja
    osszeg DECIMAL(10,2) NOT NULL,                                           -- Kifizetett összeg
    fizetesmod ENUM('kartya', 'keszpenz', 'online') NOT NULL,                -- Fizetés módja
    statusz ENUM('fizetve', 'folyamatban', 'sikertelen') NOT NULL,          -- Fizetés állapota
    FOREIGN KEY (kolcsonzes_id) REFERENCES kolcsonzesek(id)                 -- Külső kulcs a kölcsönzések táblához
);

-- ========================
-- Károk tábla
-- ========================
CREATE TABLE karok (
    id INT AUTO_INCREMENT PRIMARY KEY,                                       -- Egyedi azonosító
    jarmu_id INT NOT NULL,                                                   -- Érintett jármű
    kolcsonzes_id INT NOT NULL,                                              -- Érintett kölcsönzés
    leiras TEXT,                                                             -- Káresemény leírása
    javitasi_koltseg DECIMAL(10,2),                                         -- Becsült javítási költség
    jelentve TIMESTAMP DEFAULT CURRENT_TIMESTAMP,                           -- Jelentés időpontja
    FOREIGN KEY (jarmu_id) REFERENCES jarmuvek(id),                         -- Kapcsolat járművek táblához
    FOREIGN KEY (kolcsonzes_id) REFERENCES kolcsonzesek(id)                -- Kapcsolat kölcsönzések táblához
);
