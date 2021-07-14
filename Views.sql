/* POSTGRESQL VİEWS
İstenen SQL tablolarını tıpkı gerçek bir tabloymuş gibi sanal bir şekilde toplayan bir özelliktir. 
Uzun birleştirmelerde karmaşık sorguları oldukça basit bir hale getirirler.
Direkt views sekmesinden işlemlerin yapıldığı gibi kodlarlada bu işlemler uygulanabilir.
*/

CREATE VIEW viewMisli
AS
SELECT c.country_name, r.region_name From countries c
INNER JOIN regions r ON r.region_id=c.region_id

-- Bu işlemleri oluşturduğunuz VİEWS'e sağ tıkladıktan sonra Proporties kısmından görebilirsiniz.
-- Elimizde ki kısa bir kod fakat satırlarca kod yazdığımızı düşünün, bu nedenle viewler çok önemli ve değerlidir. 

SELECT * FROM viewMisli

-- Ve artık yaptığımız işlemleri tek bir görüntü altında toplayabiliyoruz. :)

CREATE VIEW viewMisli2
AS
INSERT INTO viewMisli2(id,name,surname) 
VALUES (1, 'Misli', 'ÇELİK')

/* VİEW WİTH CHECK OPTİON */
--VİEW WİTH CHECK OPTİON yapısı insert, update, delete işlemlerinde where koşulu sağlanmıyorsa
--bu işlemlerin gerçekleşmesini önler