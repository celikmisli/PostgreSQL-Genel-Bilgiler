--Merhaba Arkadaşlar Ben MİSLİ ÇELİK
--Sizlerle PostgreSQL Çalışmamı Paylaşmak İsterim.
--Umarım sizlere de rehber olur.

/* ÖĞRETİCİ 1: SELECT ile tablo çekme */

SELECT * FROM employees

/* ÖĞRETİCİ 2: INSERT ile Tabloya veri ekleme */

INSERT INTO USER(id, name) VALUES(2, 'Misli')

/* ÖĞRETİCİ 3: CREATE ile Veritabanı oluşturma */

CREATE DATABASE demoDB

/* ÖĞRETİCİ 4: DROP ile Veritabanı silme */

DROP DATABASE demoDB

/* ÖĞRETİCİ 5: CREATE ile Tablo oluşturma */

CREATE TABLE USERS
(
	id int primary key not null,
	ad varchar(10) not null
)

/* ÖĞRETİCİ 6: DELETE ile veri silmek */
 
 DELETE FROM USERS
 WHERE id=1
 
/* ÖĞRETİCİ 7: CHECK Constraint  */

CREATE TABLE IF NOT EXISTS --(Tablo Yoksa Oluştur)
USERS(
			id int,
			name varchar(10),
			age int,
			CHECK country_name IN ('GERMANY', 'TURKEY', 'AAMERICA') --(sadece bu 3 veriyi kabul eder)
)

/* ÖĞRETİCİ 8: NOT NULL Constraint */

CREATE TABLE IF NOT EXISTS --(Tablo Yoksa Oluştur)
USERS(
			id int,
			name varchar(10) not null ,
			age int
)

/* ÖĞRETİCİ 9: UNIQUE (BENZERSİZ) */

CREATE TABLE IF NOT EXISTS --(Tablo Yoksa Oluştur)
USERS(
			id int,
			name varchar(10),
			age int,
			email varchar(50) UNIQUE --(Aynı email adresinden başka kimsede olamaz)
)

/* ÖĞRETİCİ 10: PRİMARY KEY (anahtar alan) */

CREATE TABLE USERS
(
	id int primary key not null,
	ad varchar(10) not null
)

/* ÖĞRETİCİ 11: JOİN Kullanımları */

--INNER JOİN TÜM EŞLEŞMELERİ GETİRİR
SELECT c.country_name, c.region_id, r.region_name FROM countries c 
INNER JOIN regions r ON r.region_id=c.region_id

--LEFT JOİN HEM KESİŞİMLERİ HEM DE SOL TARAFTAKİ TÜM TABLO VERİLERİNİ GETİRİR
SELECT c.country_name, c.region_id, r.region_name FROM countries c 
LEFT JOIN regions r ON c.region_id=r.region_id
--Eğer kesişen verileri istemiyorsak
SELECT c.country_name, c.region_id, r.region_name FROM countries c 
LEFT JOIN regions r ON c.region_id=r.region_id
WHERE r.region_id=IS NULL

--RİGHT JOİN HEM KESİŞİMLERİ HEM DE SAĞ TARAFTAKİ TÜM TABLO VERİLERİNİ GETİRİR
SELECT c.country_name, c.region_id, r.region_name FROM countries c 
RIGHT JOIN regions r ON c.region_id=r.region_id
--Eğer kesişen verileri istemiyorsak
SELECT c.country_name, c.region_id, r.region_name FROM countries c 
RIGHT JOIN regions r ON c.region_id=r.region_id
WHERE c.region_id=IS NULL

/* ÖĞRETİCİ 12: UNION VE UNION ALL */

--UNİON kesişen tablo verilerini getirir
SELECT * FROM countries
UNION
SELECT * FROM regions

--UNİON ALL ttüm tablo verilerini getirir
SELECT * FROM countries
UNION ALL
SELECT * FROM regions

/* ÖĞRETİCİ 13: INTERSECT (Kesişim) */

SELECT * FROM derslerfenfakultesi
INTERSECT
SELECT * FROM derslermuhendislik

/* ÖĞRETİCİ 14: NULL veri Filtreleme */

SELECT * FROM employees WHERE manager_id IS NULL

SELECT * FROM employees WHERE manager_id IS NOT NULL

/* ÖĞRETİCİ 15: SEQUENCE İLE OTOMATİK ARTAN */

CREATE SEQUENCE demotable_id_seq -- demotable tablo adı, id sütunumuz

/* ÖĞRETİCİ 16: SERIAL İLE OTOMATİK ARTAN */

CREATE TABLE IF NOT EXISTS --(Tablo Yoksa Oluştur) 
USERS(
			id int SERIAL NOT NULL,
			name varchar(10) NOT NULL ,
			age int
)

/* ÖĞRETİCİ 17: UPDATE KOMUTU */

UPDATE USERS --UPDATE GÜNCELLEME İŞLEMİ YAPAR
SET name='Misli'  --(SET komutu değişken atamak için kullanılır)
WHERE id=5

/* ÖĞRETİCİ 18: SUM, AVG, COUNT, MAX, MİN) */

--SUM TOPLAM DEMEKTİR
SELECT SUM(maas) FROM calisan
WHERE departman='İstatistik' --İstatistikçi maaşlarının toplamını bulduk

--AVG 
SELECT AVG(maas) FROM calisan
WHERE departman='İstatistik' -- istatistikçi maaşlarının ortalamasını bulduk

--count toplam demektir. İstediğimiz özelliklere göre toplam veriyi bize verir
SELECT COUNT(*) FROM calisan
WHERE departman='İstatistik' and maas>=5000 --İstatistikçi olan ve maaşı 5000'denn fazla olan kaç kişi var

--Max en yüksek değeri verir
SELECT MAX(maas) FROM calisan
WHERE departman='İstatistik' --istatistikçilerin en yüksek maaşını verir

--Min en düşük değeri verir
SELECT MIN(maas) FROM calisan
WHERE departman='İstatistik' --istatistikçilerin en düşük maaşını verir

/* ÖĞRETİCİ 19: GROUP BY ve HAVING */

SELECT departman, COUNT(*)
GROUP BY departman
--
SELECT salary, COUNT(*) from employees
GROUP BY salary
HAVING salary>3500
--
SELECT manager_id, COUNT(*) from employees
GROUP BY manager_id
HAVING manager_id IS NOT NULL

/* ÖĞRETİCİ 20: ALT SORGU-SUBQUERY */

-- Alt sorgu bazı join işlemlerinin yetersiz kaldığı 
-- hatta fonksiyonların bile yetersiz kaldığı durumlarda 
-- bir tane daha sorgu oluşturmaktır.

SELECT * FROM calisan
WHERE maas=(SELECT MAX(maas) FROM calisan) 
-- Burada sadece en yüksek maaşı değil en yüksek maaşın kime ait olduğunu göstermiş olduk

SELECT * FROM celisan
WHERE maas=(SELECT departman, MAX(maas) FROM calisan WHERE departman='İstatistik') 
-- İstatistikçi olan çalışanlar içerisinden hangisinin maaşının en yüksek olduğunu bulduk

/* Öğretici 21: Truncate Kullanımı */

TRUNCATE TABLE calisan --Tablodakş tüm verileri sıfırlar ama tabloyu sizlemz

/* ÖĞRETİCİ 22: EXCEPT */

SELECT * FROM derslerfenfakultesi
EXCEPT
SELECT * FROM derslerlermuhendislik
-- ÜSTE YAZDIĞIMIZDA VAR OLAN AMA ALTA YAZDIĞIMIZDA OLMAYAN VERİLERİ GETİRİR

/* ÖĞRETİCİ 23: Metinsel Fonksiyonlar */

--ASCII, metinsel ifadelerin değerlerini bize verir
SELECT ASCII('A') --65 MESELA

-- CONCAT Birleştirme için kullanılır
SELECT CONCAT('Misli', ' ', 'Çelik', ' ', 'Bir', ' ', 'İstatistikçidir')

--CONCAT_WS
SELECT CONCAT_WS(' ','Misli', 'Çelik', 'Bir', 'İstatistikçidir') --Aralarına ilk parametreyi yerleştirdi

--LENGTH bize kaç karaktere sahip olduğunu gösterir
SELECT LENGTH('MİSLİ') --5

--RIGHT verdiğimiz konumun sağ tarafını getirir
SELECT RIGHT('MİSLİ',3) --SLİ

--LEFT verdiğimiz konumun sol tarafını getirir
SELECT LEFT('MİSLİ',3) --MİS

--REPLACE İstenen veriyi istenen şekilde değiştirir
SELECT REPLACE(first_name, 'Steven', 'Stella') FROM employees

--REVERSE ters çevirir
SELECT REVERSE('MİSLİ ÇELİK')--KİLEÇ İLSİM

--SUBSTRİNG belirtilen konuma bağlı olarak belirtilen dizeden alt dizeyi çıkarır.
SELECT SUBSTRING('MİSLİ',2) --İSLİ
SELECT SUBSTRING('SQL Tutorial', 1, 3) AS ExtractString; --SQL

/* ÖĞRETİCİ 24: Matematiksel Fonksiyonlar */

--ABS() Mutlak değer olarak çıkarır
SELECT ABS(-15) --15

--CEIL() sayıyı yukarıya yuvarlar
SELECT CEIL(25.4865416) --26

--FLOOR sayıyı aşağıya yuvarlar
SELECT FLOOR(25.4865416) --25

--RANDOM () 0 ile 1 arasında rastgele sayı getirir
SELECT RANDOM()

--ROUND() virgülden sonrası için istediğin kadarını alır
SELECT ROUND(25.4865416,1) --25.5
SELECT ROUND(25.4865416,2) --25.49

--POWER() üssü işlemi için kullanılır
SELECT POWER(2,5) --32

--LOG() logaritma hesaplar
SELECT LOG(45) --10 tabanlı logaritma
SELECT LOG(5,5) --5 tabanlı logaritma

--ln e tabanlı logaritma
SELECT LN(25) --3.2188758248682006

--SIGN() argümanın işaretini verir. 0 ise sayı sıfır, 1 ise sayı pozitif, -1 ise negatif
SELECT SIGN(-38) -- -1
SELECT SIGN(38)  -- 1
SELECT SIGN(0)   -- 0

--SQRT() Karekök
SELECT SQRT(25) --5

/* ÖĞRENTİCİ 25: Tarih Fonksiyonları */

--CURRENT_DATE tarih bilgisi verir
SELECT CURRENT_DATE

--CURRENT_TIME Zaman bilgisi verir
SELECT CURRENT_TIME 

--SELECT NOW() Tarih ve zaman bilgisi bir arada
SELECT NOW()

/* ÖĞRETİCİ 26: AGE KULLANIMI (İki tarih arası fark) */

SELECT AGE(TIMESTAMP '20.06.1998') --TİMESTAMP bugünün tarihini veirir

/* ÖĞRETİCİ 27: Değişken Tanımlama */

DO $$
DECLARE x int :=20;
		y int :=15;
		z int ;
BEGIN
RAISE NOTICE 'SAYI 1= %',x;
RAISE NOTICE 'SAYI 2= %',y;
RAISE NOTICE 'SAYI 3= %',z;
END $$

--İŞLEMLER

DO $$
DECLARE x int :=20;
		y int :=15;
		toplam int;
		fark int;
		carpim int;
		bolum int;		
BEGIN
		toplam=x+y;
		fark=x-y;
		carpim=x*y;
		bolum=x/y;
RAISE NOTICE 'SAYI 1= %',x;
RAISE NOTICE 'SAYI 2= %',y;
RAISE NOTICE 'toplam = %',toplam;
RAISE NOTICE 'fark = %',fark;
RAISE NOTICE 'carpim = %',carpim;
RAISE NOTICE 'bolum = %',bolum;
END $$

--Tablo Sonuçlarını Değişkenlere Atama

DO $$
DECLARE toplam int;	
BEGIN
toplam=(SELECT COUNT(*) FROM departments);
RAISE NOTICE 'Kayıt Sayısı= %',toplam;
END $$

--IF

DO $$
DECLARE sinav1 int :=65;
		sinav2 int :=100;
		sinav3 int :=75;
		ortalama int := (sinav1+sinav2+sinav3)/3;
BEGIN
RAISE NOTICE 'Öğrenci sınav ortalaması: %',ortalama;
if ortalama>=50 then
RAISE NOTICE 'Öğrenci Dersi Geçti';
else
RAISE NOTICE 'Öğrenci Dersten Kaldı';
end if;
END $$

--WHİLE

DO $$
DECLARE 
		sayac int:=1;
BEGIN
		WHILE sayac<=10 LOOP
		RAISE NOTICE 'SAYAÇ: %', sayac;
		sayac:= sayac+1;
		END LOOP;
END $$

-- Fonksiyonlar

CREATE FUNCTION toplam(s1 int, s2 int)
RETURNS int
LANGUAGE plpgsql
AS $$
DECLARE
		sonuc int;
BEGIN
		sonuc:=s1+s2;
		RETURN sonuc;
END $$;

SELECT toplam(75,85);