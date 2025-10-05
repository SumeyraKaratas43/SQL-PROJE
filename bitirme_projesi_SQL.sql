IF DB_ID(N'bitirme_proje') IS NOT NULL
    DROP DATABASE bitirme_proje;
GO

CREATE DATABASE bitirme_proje;
GO

USE bitirme_proje;
GO

CREATE TABLE Musteri(
    id INT IDENTITY(1,1) PRIMARY KEY,
    ad NVARCHAR(50) NOT NULL,
    soyad NVARCHAR(50) NOT NULL,
    email NVARCHAR(150) NOT NULL UNIQUE,
    sehir NVARCHAR(50) NOT NULL,
    kayit_tarihi DATE NOT NULL DEFAULT GETDATE()
);
CREATE table Satici(
    id INT IDENTITY(1,1) PRIMARY KEY,
    ad NVARCHAR(150) NOT NULL UNIQUE,
    adres NVARCHAR(200) not null
);
CREATE TABLE Katagori(
    id INT IDENTITY(1,1) PRIMARY KEY,
    ad NVARCHAR(80) NOT NULL UNIQUE
);
CREATE TABLE urun(
    id int identity(1,1) primary key,
    ad NVARCHAR(150) NOT NULL,
    fiyat DECIMAL(15,5) NOT NULL,
    stok INT NOT NULL CHECK(stok>=0),
    katagori_id INT NOT NULL,
    satici_id INT NOT NULL,
    CONSTRAINT FK_urun_Katagori FOREIGN KEY(katagori_id) REFERENCES katagori(id),
    CONSTRAINT FK_urun_Satici FOREIGN KEY (satici_id) REFERENCES satici(id)
);
CREATE TABLE Siparis(
    id INT IDENTITY(1,1) PRIMARY KEY,
    musteri_id INT NOT NULL  , 
    tarih DATETIME NOT NULL DEFAULT SYSUTCDATETIME(),
    toplam_tutar DECIMAL(15,5) NOT NULL CHECK (toplam_tutar >= 0),
    odeme_turu NVARCHAR(30) NOT NULL CHECK (odeme_turu IN (N'KrediKarti', N'Kapida')),
    CONSTRAINT Siparis_musteri FOREIGN KEY (musteri_id) REFERENCES Musteri(id)
);
CREATE TABLE Siparis_Detay(
    id INT IDENTITY(1,1) PRIMARY KEY ,
    siparis_id INT NOT NULL,
    urun_id INT NOT NULL,
    adet INT NOT NULL CHECK (adet > 0),
    fiyat DECIMAL(15,5) NOT NULL CHECK (fiyat >= 0),
    CONSTRAINT FK_SiparisDetay_Siparis FOREIGN KEY (siparis_id) REFERENCES Siparis(id),
    CONSTRAINT FK_SiparisDetay_Urun FOREIGN KEY (urun_id) REFERENCES urun(id)
);
INSERT INTO Musteri(ad,soyad,email,sehir,kayit_tarihi)
VALUES
(N'Ali', N'Yılmaz', N'ali.yilmaz@gmail.com', N'İstanbul', GETDATE()),
(N'Ayşe', N'Demir', N'ayse.demir@gmail.com', N'Ankara', GETDATE()),
(N'Mehmet', N'Kaya', N'mehmet.kaya@gmail.com', N'İzmir', GETDATE()),
(N'Fatma', N'Çelik', N'fatma.celik@gmail.com', N'Bursa', GETDATE()),
(N'Ahmet', N'Arslan', N'ahmet.arslan@gmail.com', N'Adana', GETDATE()),
(N'Zeynep', N'Yıldız', N'zeynep.yildiz@gmail.com', N'Antalya', GETDATE()),
(N'Murat', N'Sahin', N'murat.sahin@gmail.com', N'Konya', GETDATE()),
(N'Elif', N'Koç', N'elif.koc@gmail.com', N'Samsun', GETDATE()),
(N'Hasan', N'Kurt', N'hasan.kurt@gmail.com', N'Gaziantep', GETDATE()),
(N'Emine', N'Polat', N'emine.polat@gmail.com', N'Mersin', GETDATE()),
(N'Selim', N'Öztürk', N'selim.ozturk@gmail.com', N'Diyarbakır', GETDATE()),
(N'Gamze', N'Acar', N'gamze.acar@gmail.com', N'Kayseri', GETDATE()),
(N'Burak', N'Çetin', N'burak.cetin@gmail.com', N'Eskişehir', GETDATE()),
(N'Seda', N'Bulut', N'seda.bulut@gmail.com', N'Trabzon', GETDATE()),
(N'Yusuf', N'Tek', N'yusuf.tek@gmail.com', N'Sakarya', GETDATE()),
(N'Nur', N'Güneş', N'nur.gunes@gmail.com', N'Balıkesir', GETDATE()),
(N'Hüseyin', N'Doğan', N'huseyin.dogan@gmail.com', N'Malatya', GETDATE()),
(N'Melisa', N'Erdoğan', N'melisa.erdogan@gmail.com', N'Tekirdağ', GETDATE()),
(N'Sinan', N'Kaplan', N'sinan.kaplan@gmail.com', N'Kocaeli', GETDATE()),
(N'Esra', N'Taş', N'esra.tas@gmail.com', N'Çanakkale', GETDATE());
INSERT INTO Satici(ad,adres)
VALUES
(N'Teknoloji Dünyası', N'İstanbul'),
(N'Ev Yaşam Market', N'Ankara'),
(N'Moda Merkezi', N'İzmir'),
(N'Spor Dünyası', N'Bursa'),
(N'Kitap Yolu', N'Eskişehir'),
(N'Oyun Vadisi', N'Gaziantep'),
(N'Kozmetik Dünyası', N'Antalya'),
(N'Elektronik Plus', N'Konya'),
(N'Bebek Market', N'Samsun'),
(N'Pet Shop Dünyası', N'Adana'),
(N'Mobilya Evi', N'Kayseri'),
(N'Mutfak Marketi', N'Malatya'),
(N'Ofis Dünyası', N'Kocaeli'),
(N'Bahçe Market', N'Tekirdağ'),
(N'Otomotiv Marketi', N'Mersin'),
(N'Cep Telefonu Dünyası', N'Diyarbakır'),
(N'Bilgisayar Dünyası', N'Trabzon'),
(N'Saat & Aksesuar', N'Sakarya'),
(N'Beyaz Eşya Dünyası', N'Balıkesir'),
(N'Ev Dekorasyon', N'Çanakkale');
INSERT INTO Katagori(ad)
VALUES
(N'Elektronik'),
(N'Ev Eşyaları'),
(N'Kitap'),
(N'Spor & Outdoor'),
(N'Kozmetik'),
(N'Moda & Giyim'),
(N'Ayakkabı & Çanta'),
(N'Bebek & Oyuncak'),
(N'Petshop'),
(N'Mobilya'),
(N'Mutfak & Ev Aletleri'),
(N'Ofis & Kırtasiye'),
(N'Bahçe & Yapı Market'),
(N'Otomotiv & Aksesuar'),
(N'Sağlık & Medikal'),
(N'Mücevher & Aksesuar'),
(N'Bilgisayar & Tablet'),
(N'Telefon & Aksesuar'),
(N'Beyaz Eşya'),
(N'Müzik & Film & Hobi');
INSERT INTO Urun(ad,fiyat,stok,katagori_id,satici_id)
VALUES
(N'Laptop', 15000, 10, 1, 1),
(N'Kulaklık', 500, 50, 1, 1),
(N'Süpürge', 3000, 20, 2, 2),
(N'Roman Kitap', 50, 100, 3, 2),
(N'Futbol Topu', 250, 40, 4, 3),
(N'Ruj', 120, 80, 5, 7),
(N'Tişört', 200, 60, 6, 3),
(N'Sneaker Ayakkabı', 900, 30, 7, 4),
(N'Bebek Arabası', 2500, 15, 8, 9),
(N'Kedi Maması', 150, 200, 9, 10),
(N'Koltuk Takımı', 12000, 5, 10, 11),
(N'Blender', 750, 25, 11, 12),
(N'Ofis Sandalyesi', 2000, 12, 12, 13),
(N'Bahçe Çim Biçme Makinesi', 4500, 7, 13, 14),
(N'Lastik Seti', 8000, 10, 14, 15),
(N'Vitamin Takviyesi', 350, 60, 15, 16),
(N'Altın Kolye', 5000, 8, 16, 17),
(N'Tablet', 7000, 25, 17, 18),
(N'Akıllı Telefon', 12000, 35, 18, 19),
(N'Buzdolabı', 18000, 6, 19, 20);
INSERT INTO Siparis(musteri_id,toplam_tutar,odeme_turu)
VALUES
(1, 1500, 'KrediKarti'),
(2, 4050, 'Kapida'),
(3, 720, 'Kapida'),
(4, 2500, 'KrediKarti'),
(5, 5250, 'Kapida'),
(6, 1900, 'KrediKarti'),
(7, 6540, 'KrediKarti'),
(8, 32780, 'Kapida'),
(9, 12050, 'KrediKarti'),
(10, 30200, 'KrediKarti');
INSERT INTO Siparis_Detay(siparis_id,urun_id,adet,fiyat)
VALUES
(1, 1, 1, 15000),
(2, 2, 2, 500),
(3, 3, 1, 3000),
(4, 4, 1, 50),
(5, 5, 2, 250),
(6, 6, 1, 120),
(7, 7, 3, 200),
(8, 8, 1, 900),
(9, 9, 1, 2500),
(10, 10, 5, 150);
SELECT * FROM Musteri;
SELECT * FROM Satici;
SELECT * FROM Katagori;
SELECT * FROM Urun;
SELECT * FROM Siparis;
SELECT * FROM Siparis_Detay;

-- EN ÇOK SİPARİŞ VEREN 5 MÜŞTERİ.
select top 5
    m.ad, 
    m.soyad, 
    COUNT(s.id) AS SiparisSayisi
FROM Musteri m
JOIN Siparis s 
    ON m.id = s.musteri_id
GROUP BY m.ad, m.soyad
ORDER BY SiparisSayisi DESC,m.ad;

--EN ÇOK SATILAN ÜRÜNLER.

SELECT 
    u.ad, 
    SUM(sd.adet) AS ToplamSatilan
FROM Urun u
JOIN Siparis_Detay sd 
    ON u.id = sd.urun_id
GROUP BY u.ad
ORDER BY ToplamSatilan DESC;

--En yüksek cirosu olan satıcılar
SELECT 
    s.ad AS SaticiAdi,
    SUM(sd.adet * sd.fiyat) AS ToplamCiro
FROM Satici s
JOIN Urun u ON s.id = u.satici_id
JOIN Siparis_Detay sd ON u.id = sd.urun_id
GROUP BY s.ad
ORDER BY ToplamCiro DESC;

--Şehirlere göre müşteri sayısı.
SELECT 
    sehir,
    COUNT(*) AS MusteriSayisi
FROM Musteri
GROUP BY sehir
ORDER BY MusteriSayisi DESC;

--Kategori bazlı toplam satışlar
SELECT 
    k.ad AS KategoriAdi,
    SUM(sd.adet * sd.fiyat) AS ToplamSatis
FROM Katagori k
JOIN Urun u ON k.id = u.katagori_id
JOIN Siparis_Detay sd ON u.id = sd.urun_id
GROUP BY k.ad
ORDER BY ToplamSatis DESC;

--Aylara göre sipariş sayısı.

SELECT 
    YEAR(tarih) AS Yil,
    MONTH(tarih) AS Ay,
    COUNT(*) AS SiparisSayisi
FROM Siparis
GROUP BY YEAR(tarih), MONTH(tarih)
ORDER BY Yil, Ay;

--JOİNLER
--Siparişlerde müşteri bilgisi + ürün bilgisi + satıcı bilgisi.
SELECT 
    s.id AS SiparisID,
    m.ad AS MusteriAd,
    m.soyad AS MusteriSoyad,
    u.ad AS UrunAd,
    sa.ad AS SaticiAd,
    sd.adet,
    sd.fiyat,
    (sd.adet * sd.fiyat) AS ToplamTutar,
    s.tarih,
    s.odeme_turu
FROM Siparis s
JOIN Musteri m ON s.musteri_id = m.id
JOIN Siparis_Detay sd ON s.id = sd.siparis_id
JOIN Urun u ON sd.urun_id = u.id
JOIN Satici sa ON u.satici_id = sa.id
ORDER BY s.tarih DESC;

--Hiç satılmamış ürünler.
SELECT 
    u.id,
    u.ad AS UrunAdi,
    u.fiyat,
    u.stok,
    k.ad AS KategoriAdi,
    s.ad AS SaticiAdi
FROM Urun u
JOIN Katagori k ON u.katagori_id = k.id
JOIN Satici s ON u.satici_id = s.id
LEFT JOIN Siparis_Detay sd ON u.id = sd.urun_id
WHERE sd.urun_id IS NULL;


--Hiç sipariş vermemiş müşteriler
SELECT 
    m.id,
    m.ad,
    m.soyad,
    m.email,
    m.sehir,
    m.kayit_tarihi
FROM Musteri m
LEFT JOIN Siparis s ON m.id = s.musteri_id
WHERE s.id IS NULL;

