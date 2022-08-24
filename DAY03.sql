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
--INSERT INTO calisanlar VALUES('10010', Mehmet Yılmaz, 5000, '2018-04-14'); -- un unıque
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); -- not null
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); -- un unıque
--INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); -- not nul
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
--INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); -- primary key
--INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); -- primary key
--INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); -- primary key

select * from calisanlar;

-- FOREIGN KEY --
CREATE TABLE adresler(
adres_id char(5),					 
sokak varchar(20),					 
cadde varchar(30),
sehir varchar(20),
CONSTRAINT fk FOREIGN KEY (adres_id) REFERENCES calisanlar (id)
);
INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');

SELECT * FROM adresler;

INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');
-- paren tabloda  olmayan id ile child tabloya ekleme yapamayız.

INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');

-- Calısanlar id ile adresler tablosundaki adres_id ile eşleşenlere bakmak için 
select * from calisanlar, adresler where calisanlar.id=adresler.adres_id

drop table calisanlar;
-- paren tabloyu yani primary key olan tabloyu silmek istediğinizde tabloyu silmez.
-- önce child tabloyu (foreign key) silmemiz gerekir.

DELETE FROM calisanlar where id='10002'; -- parent (silmez ve önce child'daki veriyi sil diye uyarı verir.)

delete from adresler where adres_id='10002'; -- child (önce child'dan silersek sonra parent tablodan da silmemize izin verir.)

-- ON DELETE CASCADE --
-- Her defasında önce child tablodaki verileri silmek yerine
-- ON DELETE CASCADE silme özelliğini aktif hale getirin.
-- bunun için FK olan satırın en sonuna ON DELETE CASCADE komutunu yazmanız yeterlidir.

CREATE TABLE talebeler
(
id CHAR(3) primary key,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);

CREATE TABLE notlar(
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id)
ON DELETE CASCADE
);

INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90);

select * from talebeler;
select * from notlar;

DELETE FROM notlar WHERE talebe_id='123';

delete from talebeler where id='126';  -- ON DELETE CASCADE kullandığımız için parent table'dan direkt silebildik.
-- Parent table'dan sildiğimiz için child table'danda silinmiş olur.

delete from talebeler; -- talebeler tablosu içindeki tüm veriyi sildi. tablo duruyor ama verileri silindi.
drop table talebeler CASCADE; 	-- Parent tablosu kaldırmak istersek DROP TABLE tablo_adi'ndan  sonra 
								-- CASCADE komutu kulanılır.
-- SORU : talebeler tablosundaki isim sutununa NOT NUL kısıtlaması ekleyin ve veri tipini VARCHAR(30) olarak belirtin.
ALTER table talebeler 
ALTER column isim TYPE VARCHAR(30),
ALTER COLUMN isim SET NOT NULL;

-- TALEBELER TABLOSUNDAKİ yazili_notu sutununa 60 dan buyuk sayı girilebilsin 
alter table talebeler
ADD CONSTRAINT sinir check (yazili_notu>60); -- CHECK komutu ile istediğimiz sutun için sınır koyabiliriz.

INSERT INTO talebeler VALUES(128, 'Mustafa Cak', 'ali',45); -- CHECK kısıtlama komutu ile 60 puan sınırı koyduğumuzdan ekleyemedik.

create table ogrenciler(
id int,
isim varchar(45),
adres varchar(100),
sinav_notu int
);

Create table ogrenci_adres
AS
SELECT id, adres from ogrenciler;

select * from ogrenciler;
select * from ogrenci_adres;

-- Tablodaki bir sutuna PRIMARY KEY ekleme
alter table ogrenciler
ADD PRIMARY KEY (id);

-- PRIMARY KEY oluşturmada 2.yol
alter table ogrenciler
ADD CONSTRAINT pk_id PRIMARY KEY (id);

-- PRIMARY KEY DEN SONRA FOREIGN KEY ATAMASI YAPALIM.
alter table ogrenci_adres
ADD FOREIGN KEY (id) REFERENCES ogrenciler;
-- child tabloyu, parent tablodan oluşturduğumuz için REFERENCES komutundan sonra sutun adı vermedik.

--PK'yi silme CONTRAINT silme
alter table ogrenciler DROP CONSTRAINT pk_id;
--FK'yi silme CONTRAINT silme
alter table ogrenci_adres DROP CONSTRAINT ogrenci_adres_id_fkey;

-- SORU : Yazılı notu 85 den buyuk olan talebe bilgilerini getirin.
select * from talebeler where yazili_notu>85;

-- SORU : ismi Mustafa Bak olan talebenin bilgilerini getirin.
select * from talebeler where isim = 'Mustafa Bak';

-- SELECT komutunda BETWEEN koşulu
-- BETWEEN, belirttiğiniz iki veri arasındaki bilgileri listeler.
-- BETWEEN 'DE BELİRTTİĞİNİZ DEĞERLERDE DAHİLDİR.

create table personel
(
id char(4),
isim varchar(50),
maas int
);
insert into personel values('1001', 'Ali Can', 70000);
insert into personel values('1002', 'Veli Mert', 85000);
insert into personel values('1003', 'Ayşe Tan', 65000);
insert into personel values('1004', 'Derya Soylu', 95000);
insert into personel values('1005', 'Yavuz Bal', 80000);
insert into personel values('1006', 'Sena Beyaz', 100000);
/*
AND (ve) : Belirtilen şartların her ikiside gerçekleşiyor ise o kayıt listelenir.
bir tanesi gerçekleşmez ise listelenmez.
select * from matematik sinavi >50 AND sinav2 >50
hem sınav1 hemde sınav2 alanı 50 den buyuk olanları listeler.
*/
/*
OR (veya) : Belirtilen şartların bir tanesi gerçekleşiyor ise o kayıt listelenir.
bir tanesi gerçekleşmez ise listelenmez.
select * from matematik sinavi >50 OR sinav2 >50
hem sınav1 alanı,hemde sınav2 alanı 50 den buyuk olanları listeler.
*/

select * from personel;

-- SORU : id'si 1003 ile 1005 arasında olan  personel bilgisini listeleyiniz.
-- 1.yol
select * from personel where id between '1003' and '1005';  --between komutunda sınırlar dahil oldukları için listelenmiş oldular.

2.yol
select * from personel where id>='1003' and id<='1005';

-- SORU : Derya Soylu ile Yazuz Bal arasındaki personel bilgisini listeleyin.
select * from personel where isim between 'Derya Soylu' and 'Yazuz Bal';

-- SORU : Maası 70000 veya ismi Sena olan personeli listele
select * from personel where maas=70000 or isim='Sena Beyaz';

-- IN : Birden fazla mantıksal ifade ile tanımlayabileceğimiz durumları tek komutta yazabilme imkanı verir.
-- Farklı sutunlar için IN komutu kullanılamaz.

-- SORU : id'si 1001,1002 ve 1004 olan personelin bilgilerini listele.
-- 1.yol
select * from personel where id='1001'or id='1002'or id='1004';

-- 2.yol
select * from personel where id  IN ('1001','1002','1004');

-- SORU : maas'ı sadece 70000, 100000 olan personeli listele
select * from personel where maas=70000 or maas= 100000;
select * from personel where maas IN (70000,100000);

/*
SELECT - LIKE koşulu

LIKE 	: Sorgulama yaparken belirli kalıp ifadeleri kullanabilmemizi sağlar.
ILIKE 	: Sorgulama yaparken buyuk-kucuk harfe duyarsız olarak eşleştirir.
LIKE 	: ~~
ILIKE 	: ~~*
NOT LIKE	: !~~
NOT ILIKE	: !~~*

% --> 0 veya daha fazla karakteri belirtir.
_ --> Tek bir karakteri belirtir

*/

-- SORU : Ismi A harfi ile başlayan personeli listele.
SELECT * FROM PERSONEL WHERE isim like 'A%'; -- A ile başlasın devamı ne olursa olsun manasında A% yazdık.

-- SORU : Ismi t harfi ile biten personeli listele.
SELECT * FROM PERSONEL WHERE isim like '%t'; -- t ile bitsinde önünde ne olursa olsun manasında %t yazdık.

-- SORU : Isminin ikinci harfi e olan personeli listele.
SELECT * FROM PERSONEL WHERE isim like '_e%'; -- ikinci harfi e olsunda ne olursa olsun manasında '_e%' yazdık.
