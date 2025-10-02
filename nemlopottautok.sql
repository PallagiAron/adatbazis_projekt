-- Ügyfelek hozzáadása
INSERT INTO ugyfelek (nev, email, telefon, jogositvany_szam)
VALUES
('Kovács Ádám', 'adam.kovacs@example.com', '+36123456789', 'AB123456'),   -- Első ügyfél adatai
('Nagy Eszter', 'eszter.nagy@example.com', '+36201234567', 'CD789012'),    -- Második ügyfél
('Tóth Gábor', 'gabor.toth@example.com', '+36301234567', 'EF345678');      -- Harmadik ügyfél

-- Telephelyek hozzáadása
INSERT INTO telephelyek (nev, cim)
VALUES
('Budapest Központ', '1051 Budapest, Kossuth Lajos utca 10.'),             -- Budapest telephely
('Debrecen Főút', '4024 Debrecen, Piac utca 7.');                          -- Debreceni telephely

-- Járművek hozzáadása
INSERT INTO jarmuvek (marka, modell, evjarat, rendszam, alvazszam, allapot, napi_berleti_dij, telephely_id)
VALUES
('Toyota', 'Corolla', 2021, 'ABC-123', 'JT1234567890123456', 'elerheto', 15000.00, 1),  -- Toyota a budapesti telephelyen, elérhető állapotban
('Ford', 'Focus', 2020, 'DEF-456', 'FT6543210987654321', 'berbeadva', 14000.00, 1),    -- Ford, bérelt állapotban, szintén Budapesten
('Volkswagen', 'Golf', 2019, 'GHI-789', 'VW9876543210123456', 'elerheto', 16000.00, 2);-- VW Debreceni telephelyen, elérhető

-- Foglalások létrehozása
INSERT INTO foglalasok (ugyfel_id, jarmu_id, kezdet_datum, veg_datum, statusz)
VALUES
(1, 1, '2025-10-05', '2025-10-10', 'megerositve'),    -- Kovács Ádám foglalása a Toyota-ra, megerősített státusz
(2, 3, '2025-11-01', '2025-11-05', 'fuggoben'),       -- Nagy Eszter foglalása a VW-re, függő státuszban
(3, 2, '2025-10-15', '2025-10-20', 'lemondva');       -- Tóth Gábor foglalása, de lemondva

-- Kölcsönzések adatai
INSERT INTO kolcsonzesek (foglalas_id, atvetel_idopont, visszahozatal_idopont, vegosszeg, statusz)
VALUES
(1, '2025-10-05 09:00:00', '2025-10-10 18:00:00', 75000.00, 'befejezve'),  -- Első foglalásból kölcsönzés, már visszahozva és fizetve
(2, NULL, NULL, NULL, 'aktiv');                                             -- Második foglalás aktív kölcsönzés, még folyamatban

-- Fizetések rögzítése
INSERT INTO fizetesek (kolcsonzes_id, fizetes_idopont, osszeg, mod, statusz)
VALUES
(1, '2025-10-05 09:30:00', 75000.00, 'kartya', 'fizetve');  -- Az első kölcsönzéshez tartozó fizetés, sikeres bankkártyás tranzakció

-- Káresemény rögzítése
INSERT INTO karok (jarmu_id, kolcsonzes_id, leiras, javitasi_koltseg)
VALUES
(2, 1, 'Karcolás a bal első ajtón.', 25000.00);             -- A Fordon keletkezett karcolás az első kölcsönzés során, javítási költség becsléssel