--personel isminde bir tablo oluşturalım
create table personel( 
persone_id int,
isim varchar(30),
sehir varchar(30),
maas int,
sirket varchar(20),
adres varchar(50)
);
--Varolan personel tablosundan pers_id,sehir,adres field'larına sahip personel_adres adında yeni bir tablo oluşturalım
create table personel_adres
as
select persone_id, sehir, adres from personel;

select * from personel

-- DML --> Data Manipulation Lang.
-- INSERT - UPDATE - DELETE
-- TABLOYA VERİ EKLEME, TABLODAN VERİ GÜNCELLEME VE TABLODAN VERİ SİLMEDE KULLANILAN KOMUTLAR.

-- INSERT
create table student
(
id varchar(4),
st_name varchar(30),
age int
);

INSERT into student VALUES ('1001','Ali Can',25);
INSERT into student VALUES ('1002','Veli Can',35);
INSERT into student VALUES ('1003','Ayse Can',45);
INSERT into student VALUES ('1004','Derya Can',55);

--Tabloya parçalı veri ekleme
insert into student(st_name,age) values ('Murat Can',65);

--DQL--> Data Query Lang.
-- SELECT
select * from student;
select st_name from student;

-- SELECT KOMUTU WHERE KOŞULU
select * from student WHERE age>35;

--TCL - Transaction Control Lang.
-- Begin -  Savepoint - rollback - commit
-- Transaction, veri tabanı sistemlerinde bir işlem başladığında başlar ve işlem bitince sona erer.
-- Bu işlemler; Veri tabanı oluşturma, veri silme, veri güncelleme ve veriyi geri getirme gibi işlemlerdir.

CREATE TABLE ogrenciler2
(
id serial,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real
);
Begin;
insert into ogrenciler2 VALUES (default, 'Ali Can','Hasan',75.5);
insert into ogrenciler2 VALUES (default, 'Canan Gül','Ayşe Şen',90.5);
savepoint x;
insert into ogrenciler2 VALUES (default, 'Suat Van','Hüseyin',85.5);
insert into ogrenciler2 VALUES (default, 'Veli Zil','Mahmut',60.5);

ROLLBACK TO x;

select * from ogrenciler2;

commit;

-- Transaction kullanımında SERIAL data türü kullanımı tavsiye edilmez.
-- savepointten sonra eklediğimiz veride sayaç mantığı ile çalıştığı için 
-- sayaçta en son hangi sayıda kaldıysa ordan devam eder.
-- NOT : PostgreSQL de Transaction kullanımı için 'BEGİN' komutu ile başlarız. Sonrasında tekrar yanlış bir veriyi düzeltmek
-- veya bizim için önemli olan verilerden sonra ekleme yapabilmek için 
-- 'SAVEPOINT' komutunu kullanırız. Bu saverpoint'e geri donebilmek için 'ROLLBAACK TO SAVEPOINTismi'
-- komutunu kullanırız. rollback çalıştırıldığında savepoint satırının üstündeki verileri tabloda bize verir.
-- Transaction'ı sonlandırmak için 'COMMIT' komutu kullanırız.
-- MySQL de transaction olmadan da kullanılır.

-- DML - DELETE - 
-- DELETE FROM tablo_adi --> Tablonun  tüm içeriğini siler
-- Veriyi secerek silmek için WHERE koşulu kullanılır.
-- DELETE FROM Tablo_adi WHERE sutun_adi = veri --> tablodaki istediğimiz veriyi siler.

CREATE TABLE ogrenciler;(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

INSERT INTO ogrenciler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler VALUES(127, 'Mustafa Bak', 'Ali', 99);

select * from ogrenciler;

-- soru : id'si 124 olan   ogreciyi silin.
DELETE FROM ogrenciler WHERE id = 124;

-- SORU : İSMİ KEMAL YASA OLAN SATIRI SİL.
DELETE FROM ogrenciler WHERE isim = 'Kemal Yasa';

-- Soru : ismi Nesibe Yılmaz veya Mustafa Bak olan kayıtları silelim
delete from ogrenciler WHERE isim = 'Nesibe Yilmaz' or isim = 'Mustafa Bak'

-- soru : ismi Ali Can ve id'si 123 olan kaydı siliniz.
delete from ogrenciler WHERE isim = 'Ali Can' and id = 123;

-- Tablodaki tüm ogrencileri silelim
delete from ogrenciler

-- DELETE - TRUNCATE --
-- TRUNCATE komutu DELETE komutu gibi bir tablodaki verilerin tamamını siler.
-- Ancak, seçmeli silme yapamaz
select * from ogrenciler;
TRUNCATE TABLE ogrenciler

-- DDL - DATA DEFINATION LANG.
-- CREATE - ALTER - DROP
-- ALTER TABLE--
-- ALTER TABLE tabloda ADD, TYPE, SET, RENAME veya DROP COLUMNS işlemleri için kullanılır.

-- Personel tablosuna cinsiyet Varchar(20) ve yas int şeklinde yeni sutunlar ekleyin.

create table personel( 
persone_id int,
isim varchar(30),
sehir varchar(30),
maas int,
sirket varchar(20),
adres varchar(50)
);
select * from personel;
alter table personel add cinsiyet Varchar(20), add yas int;

-- personel tablosundan sirket field'ını siliniz.
alter table personel drop column sirket;

-- personel tablosundan sehir field'ının adını ulke olarak değiştirelim.
alter table personel rename column sehir to ulke;

-- personel tablosundan adını isciler olarak değiştirelim.
alter table personel rename to isciler;

select * from isciler;

--DDL - DROP KOMUTU - SİLMEK İÇİN KULLANILIR
DROP TABLE isciler;

-- CONSTRANINT --  KISITLAMALAR
-- PRIMARY KEY --> BİR SÜTÜNUN 'NULL' İÇERMEMESİNİ VE SUTUNDAKİ VERİLERİN BENZERSİZ OLMASINI SAĞLAR. (NOT NULL - UNIQUE)
-- FOREIGN KEY --> BASKA BİR TABLODAKİ PRİMARY KEY'İ REFERANS GÖSTERMEK İÇİN KULLANILIR. BOYLELIKLE TABLOLAR ARASINDA İLİŞKİ KURULUR.
-- UNIQUE 	   --> BİR SÜTÜNDAKİ TÜM DEĞERLERİN "BENZERSİZ" YANİ TEK OLMASINI SAĞLAR.
-- NOT NULL    --> BİR SÜTUNUN "NULL" İÇERMEMESİNİ YANİ BOŞ OLMAMASINI SAĞLAR.
				   "NOT NUL" KISITLAMASI İÇİN CONSTRAINT İSMİ TANIMLANMAZ. BU KISITLAMA VERİ TÜRÜNDEN HEMEN SONRA YERLEŞTİRİLİR.
-- CHECK	   --> BİR SUTUNA YERLEŞTİRİLEBİLECEK DEĞER ARALIĞINI SINIRLAMAK İÇİN KULLANILIR.

CREATE TABLE calisanlar
(
id CHAR(5) PRIMARY KEY, -- not null + unique
isim VARCHAR(50) UNIQUE,
maas int NOT NULL,
ise_baslama DATE
);
select * from calisanlar;

CREATE TABLE calisanlar2
(
id CHAR(5),
isim VARCHAR(50),
maas int NOT NULL,
ise_baslama DATE,
CONSTRAINT pk_id PRIMARY KEY(id),
CONSTRAINT ism_unq UNIQUE(isim)
);

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', Mehmet Yılmaz, 5000, '2018-04-14'); -- un unıque
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); -- not null
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); -- un unıque
INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); -- not nul
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); -- primary key
INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); -- primary key
INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); -- primary key

select * from calisanlar;

-- FOREIGN KEY --
CREATE TABLE adresler(
adres_id char(5),					 
sokak varchar(20),					 
cadde varchar(30),
sehir varchar(20),
CONSTRAINT id_fk FOREIGN KEY (adres_id) REFERENCES calisanlar (id)
);
INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');

SELECT * FROM adresler;