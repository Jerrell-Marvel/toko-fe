-- Insert Kecamatan (Districts)
INSERT INTO Districts (district_name) VALUES 
('Andir'),
('Astana Anyar'),
('Antapani'),
('Arcamanik'),
('Babakan Ciparay'),
('Bandung Kidul'),
('Bandung Kulon'),
('Bandung Wetan'),
('Batununggal'),
('Bojongloa Kaler'),
('Bojongloa Kidul'),
('Buahbatu'),
('Cibeunying Kaler'),
('Cibeunying Kidul'),
('Cibiru'),
('Cicendo'),
('Cidadap'),
('Cinambo'),
('Coblong'),
('Gedebage'),
('Kiaracondong'),
('Lengkong'),
('Mandalajati'),
('Panyileukan'),
('Rancasari'),
('Regol'),
('Sukajadi'),
('Sukasari'),
('Sumur Bandung'),
('Ujungberung');

-- Insert Kelurahan (Subdistricts)
INSERT INTO Subdistricts (subdistrict_name, district_id) VALUES
('Campaka', (SELECT district_id FROM Districts WHERE district_name = 'Andir')),
('Ciroyom', (SELECT district_id FROM Districts WHERE district_name = 'Andir')),
('Dunguscariang', (SELECT district_id FROM Districts WHERE district_name = 'Andir')),
('Garuda', (SELECT district_id FROM Districts WHERE district_name = 'Andir')),
('Kebonjeruk', (SELECT district_id FROM Districts WHERE district_name = 'Andir')),
('Maleber', (SELECT district_id FROM Districts WHERE district_name = 'Andir')),

('Cibadak', (SELECT district_id FROM Districts WHERE district_name = 'Astana Anyar')),
('Karanganyar', (SELECT district_id FROM Districts WHERE district_name = 'Astana Anyar')),
('Karasak', (SELECT district_id FROM Districts WHERE district_name = 'Astana Anyar')),
('Nyengseret', (SELECT district_id FROM Districts WHERE district_name = 'Astana Anyar')),
('Panjunan', (SELECT district_id FROM Districts WHERE district_name = 'Astana Anyar')),
('Pelindunghewan', (SELECT district_id FROM Districts WHERE district_name = 'Astana Anyar')),

('Antapani Kidul', (SELECT district_id FROM Districts WHERE district_name = 'Antapani')),
('Antapani Kulon', (SELECT district_id FROM Districts WHERE district_name = 'Antapani')),
('Antapani Tengah', (SELECT district_id FROM Districts WHERE district_name = 'Antapani')),
('Antapani Wetan', (SELECT district_id FROM Districts WHERE district_name = 'Antapani')),

('Cisaranten Bina Harapan', (SELECT district_id FROM Districts WHERE district_name = 'Arcamanik')),
('Cisaranten Endah', (SELECT district_id FROM Districts WHERE district_name = 'Arcamanik')),
('Cisaranten Kulon', (SELECT district_id FROM Districts WHERE district_name = 'Arcamanik')),
('Sukamiskin', (SELECT district_id FROM Districts WHERE district_name = 'Arcamanik')),

('Babakan', (SELECT district_id FROM Districts WHERE district_name = 'Babakan Ciparay')),
('Babakanciparay', (SELECT district_id FROM Districts WHERE district_name = 'Babakan Ciparay')),
('Cirangrang', (SELECT district_id FROM Districts WHERE district_name = 'Babakan Ciparay')),
('Margahayu Utara', (SELECT district_id FROM Districts WHERE district_name = 'Babakan Ciparay')),
('Margasuka', (SELECT district_id FROM Districts WHERE district_name = 'Babakan Ciparay')),
('Sukahaji', (SELECT district_id FROM Districts WHERE district_name = 'Babakan Ciparay')),

('Batununggal', (SELECT district_id FROM Districts WHERE district_name = 'Bandung Kidul')),
('Kujangsari', (SELECT district_id FROM Districts WHERE district_name = 'Bandung Kidul')),
('Mengger', (SELECT district_id FROM Districts WHERE district_name = 'Bandung Kidul')),
('Wates', (SELECT district_id FROM Districts WHERE district_name = 'Bandung Kidul')),

('Caringin', (SELECT district_id FROM Districts WHERE district_name = 'Bandung Kulon')),
('Cibuntu', (SELECT district_id FROM Districts WHERE district_name = 'Bandung Kulon')),
('Cigondewah Kaler', (SELECT district_id FROM Districts WHERE district_name = 'Bandung Kulon')),
('Cigondewah Kidul', (SELECT district_id FROM Districts WHERE district_name = 'Bandung Kulon')),
('Cigondewah Rahayu', (SELECT district_id FROM Districts WHERE district_name = 'Bandung Kulon')),
('Cijerah', (SELECT district_id FROM Districts WHERE district_name = 'Bandung Kulon')),
('Gempolsari', (SELECT district_id FROM Districts WHERE district_name = 'Bandung Kulon')),
('Warungmuncang', (SELECT district_id FROM Districts WHERE district_name = 'Bandung Kulon')),

('Cihapit', (SELECT district_id FROM Districts WHERE district_name = 'Bandung Wetan')),
('Citarum', (SELECT district_id FROM Districts WHERE district_name = 'Bandung Wetan')),
('Tamansari', (SELECT district_id FROM Districts WHERE district_name = 'Bandung Wetan')),

('Binong', (SELECT district_id FROM Districts WHERE district_name = 'Batununggal')),
('Cibangkong', (SELECT district_id FROM Districts WHERE district_name = 'Batununggal')),
('Gumuruh', (SELECT district_id FROM Districts WHERE district_name = 'Batununggal')),
('Kacapiring', (SELECT district_id FROM Districts WHERE district_name = 'Batununggal')),
('Kebongedang', (SELECT district_id FROM Districts WHERE district_name = 'Batununggal')),
('Kebonwaru', (SELECT district_id FROM Districts WHERE district_name = 'Batununggal')),
('Maleer', (SELECT district_id FROM Districts WHERE district_name = 'Batununggal')),
('Samaja', (SELECT district_id FROM Districts WHERE district_name = 'Batununggal')),

('Babakan Asih', (SELECT district_id FROM Districts WHERE district_name = 'Bojongloa Kaler')),
('Babakan Tarogong', (SELECT district_id FROM Districts WHERE district_name = 'Bojongloa Kaler')),
('Jamika', (SELECT district_id FROM Districts WHERE district_name = 'Bojongloa Kaler')),
('Kopo', (SELECT district_id FROM Districts WHERE district_name = 'Bojongloa Kaler')),
('Suka Asih', (SELECT district_id FROM Districts WHERE district_name = 'Bojongloa Kaler'));

-- Bojongloa Kidul
INSERT INTO Subdistricts (subdistrict_name, district_id) VALUES 
('Cibaduyut', (SELECT district_id FROM Districts WHERE district_name = 'Bojongloa Kidul')),
('Cibaduyut Kidul', (SELECT district_id FROM Districts WHERE district_name = 'Bojongloa Kidul')),
('Cibaduyut Wetan', (SELECT district_id FROM Districts WHERE district_name = 'Bojongloa Kidul')),
('Kebon Lega', (SELECT district_id FROM Districts WHERE district_name = 'Bojongloa Kidul')),
('Mekarwangi', (SELECT district_id FROM Districts WHERE district_name = 'Bojongloa Kidul')),
('Situsaeur', (SELECT district_id FROM Districts WHERE district_name = 'Bojongloa Kidul'));

-- Buahbatu
INSERT INTO Subdistricts (subdistrict_name, district_id) VALUES 
('Cijawura', (SELECT district_id FROM Districts WHERE district_name = 'Buahbatu')),
('Jatisari', (SELECT district_id FROM Districts WHERE district_name = 'Buahbatu')),
('Margasari', (SELECT district_id FROM Districts WHERE district_name = 'Buahbatu')),
('Sekejati', (SELECT district_id FROM Districts WHERE district_name = 'Buahbatu'));

-- Cibeunying Kaler
INSERT INTO Subdistricts (subdistrict_name, district_id) VALUES 
('Cigadung', (SELECT district_id FROM Districts WHERE district_name = 'Cibeunying Kaler')),
('Cihaurgeulis', (SELECT district_id FROM Districts WHERE district_name = 'Cibeunying Kaler')),
('Neglasari', (SELECT district_id FROM Districts WHERE district_name = 'Cibeunying Kaler')),
('Sukaluyu', (SELECT district_id FROM Districts WHERE district_name = 'Cibeunying Kaler'));

-- Cibeunying Kidul
INSERT INTO Subdistricts (subdistrict_name, district_id) VALUES 
('Cicadas', (SELECT district_id FROM Districts WHERE district_name = 'Cibeunying Kidul')),
('Cikutra', (SELECT district_id FROM Districts WHERE district_name = 'Cibeunying Kidul')),
('Padasuka', (SELECT district_id FROM Districts WHERE district_name = 'Cibeunying Kidul')),
('Pasirlayung', (SELECT district_id FROM Districts WHERE district_name = 'Cibeunying Kidul')),
('Sukamaju', (SELECT district_id FROM Districts WHERE district_name = 'Cibeunying Kidul')),
('Sukapada', (SELECT district_id FROM Districts WHERE district_name = 'Cibeunying Kidul'));

-- Cibiru
INSERT INTO Subdistricts (subdistrict_name, district_id) VALUES 
('Cipadung', (SELECT district_id FROM Districts WHERE district_name = 'Cibiru')),
('Cisurupan', (SELECT district_id FROM Districts WHERE district_name = 'Cibiru')),
('Palasari', (SELECT district_id FROM Districts WHERE district_name = 'Cibiru')),
('Pasirbiru', (SELECT district_id FROM Districts WHERE district_name = 'Cibiru'));

-- Cicendo
INSERT INTO Subdistricts (subdistrict_name, district_id) VALUES 
('Arjuna', (SELECT district_id FROM Districts WHERE district_name = 'Cicendo')),
('Husen Sastranegara', (SELECT district_id FROM Districts WHERE district_name = 'Cicendo')),
('Pajajaran', (SELECT district_id FROM Districts WHERE district_name = 'Cicendo')),
('Pamoyanan', (SELECT district_id FROM Districts WHERE district_name = 'Cicendo')),
('Pasirkaliki', (SELECT district_id FROM Districts WHERE district_name = 'Cicendo')),
('Sukaraja', (SELECT district_id FROM Districts WHERE district_name = 'Cicendo'));

-- Cidadap
INSERT INTO Subdistricts (subdistrict_name, district_id) VALUES 
('Ciumbuleuit', (SELECT district_id FROM Districts WHERE district_name = 'Cidadap')),
('Hegarmanah', (SELECT district_id FROM Districts WHERE district_name = 'Cidadap')),
('Ledeng', (SELECT district_id FROM Districts WHERE district_name = 'Cidadap'));

-- Cinambo
INSERT INTO Subdistricts (subdistrict_name, district_id) VALUES 
('Babakan Penghulu', (SELECT district_id FROM Districts WHERE district_name = 'Cinambo')),
('Cisaranten Wetan', (SELECT district_id FROM Districts WHERE district_name = 'Cinambo')),
('Pakemitan', (SELECT district_id FROM Districts WHERE district_name = 'Cinambo')),
('Sukamulya', (SELECT district_id FROM Districts WHERE district_name = 'Cinambo'));

-- Coblong
INSERT INTO Subdistricts (subdistrict_name, district_id) VALUES 
('Cipaganti', (SELECT district_id FROM Districts WHERE district_name = 'Coblong')),
('Dago', (SELECT district_id FROM Districts WHERE district_name = 'Coblong')),
('Lebakgede', (SELECT district_id FROM Districts WHERE district_name = 'Coblong')),
('Lebaksiliwangi', (SELECT district_id FROM Districts WHERE district_name = 'Coblong')),
('Sadangserang', (SELECT district_id FROM Districts WHERE district_name = 'Coblong')),
('Sekeloa', (SELECT district_id FROM Districts WHERE district_name = 'Coblong'));

-- Gedebage
INSERT INTO Subdistricts (subdistrict_name, district_id) VALUES 
('Cimincrang', (SELECT district_id FROM Districts WHERE district_name = 'Gedebage')),
('Cisaranten Kidul', (SELECT district_id FROM Districts WHERE district_name = 'Gedebage')),
('Rancabolang', (SELECT district_id FROM Districts WHERE district_name = 'Gedebage')),
('Rancanumpang', (SELECT district_id FROM Districts WHERE district_name = 'Gedebage'));

-- Kiaracondong
INSERT INTO Subdistricts (subdistrict_name, district_id) VALUES 
('Babakansari', (SELECT district_id FROM Districts WHERE district_name = 'Kiaracondong')),
('Babakansurabaya', (SELECT district_id FROM Districts WHERE district_name = 'Kiaracondong')),
('Cicaheum', (SELECT district_id FROM Districts WHERE district_name = 'Kiaracondong')),
('Kebonkangkung', (SELECT district_id FROM Districts WHERE district_name = 'Kiaracondong')),
('Kebunjayanti', (SELECT district_id FROM Districts WHERE district_name = 'Kiaracondong')),
('Sukapura', (SELECT district_id FROM Districts WHERE district_name = 'Kiaracondong'));

-- Lengkong
INSERT INTO Subdistricts (subdistrict_name, district_id) VALUES 
('Burangrang', (SELECT district_id FROM Districts WHERE district_name = 'Lengkong')),
('Cijagra', (SELECT district_id FROM Districts WHERE district_name = 'Lengkong')),
('Cikawao', (SELECT district_id FROM Districts WHERE district_name = 'Lengkong')),
('Lingkar Selatan', (SELECT district_id FROM Districts WHERE district_name = 'Lengkong')),
('Malabar', (SELECT district_id FROM Districts WHERE district_name = 'Lengkong')),
('Paledang', (SELECT district_id FROM Districts WHERE district_name = 'Lengkong')),
('Turangga', (SELECT district_id FROM Districts WHERE district_name = 'Lengkong'));

-- Mandalajati
INSERT INTO Subdistricts (subdistrict_name, district_id) VALUES 
('Jatihandap', (SELECT district_id FROM Districts WHERE district_name = 'Mandalajati')),
('Karangpamulang', (SELECT district_id FROM Districts WHERE district_name = 'Mandalajati')),
('Pasir Impun', (SELECT district_id FROM Districts WHERE district_name = 'Mandalajati')),
('Sindangjaya', (SELECT district_id FROM Districts WHERE district_name = 'Mandalajati'));

-- Panyileukan
INSERT INTO Subdistricts (subdistrict_name, district_id) VALUES 
('Cipadung Kidul', (SELECT district_id FROM Districts WHERE district_name = 'Panyileukan')),
('Cipadung Kulon', (SELECT district_id FROM Districts WHERE district_name = 'Panyileukan')),
('Cipadung Wetan', (SELECT district_id FROM Districts WHERE district_name = 'Panyileukan')),
('Mekarmulya', (SELECT district_id FROM Districts WHERE district_name = 'Panyileukan'));

-- Rancasari
INSERT INTO Subdistricts (subdistrict_name, district_id) VALUES 
('Cisaranten', (SELECT district_id FROM Districts WHERE district_name = 'Rancasari')),
('Kampung Baru', (SELECT district_id FROM Districts WHERE district_name = 'Rancasari')),
('Rancanera', (SELECT district_id FROM Districts WHERE district_name = 'Rancasari'));

-- Regol
INSERT INTO Subdistricts (subdistrict_name, district_id) VALUES 
('Kebon Kelapa', (SELECT district_id FROM Districts WHERE district_name = 'Regol')),
('Kebon Pala', (SELECT district_id FROM Districts WHERE district_name = 'Regol')),
('Neglasari', (SELECT district_id FROM Districts WHERE district_name = 'Regol')),
('Sukamaju', (SELECT district_id FROM Districts WHERE district_name = 'Regol'));

-- Sukajadi
INSERT INTO Subdistricts (subdistrict_name, district_id) VALUES 
('Cijagra', (SELECT district_id FROM Districts WHERE district_name = 'Sukajadi')),
('Husein Sastranegara', (SELECT district_id FROM Districts WHERE district_name = 'Sukajadi')),
('Indihiang', (SELECT district_id FROM Districts WHERE district_name = 'Sukajadi')),
('Ledeng', (SELECT district_id FROM Districts WHERE district_name = 'Sukajadi')),
('Mekarwangi', (SELECT district_id FROM Districts WHERE district_name = 'Sukajadi'));

-- Sumur Bandung
INSERT INTO Subdistricts (subdistrict_name, district_id) VALUES 
('Cikawao', (SELECT district_id FROM Districts WHERE district_name = 'Sumur Bandung')),
('Cidadap', (SELECT district_id FROM Districts WHERE district_name = 'Sumur Bandung')),
('Kebon Kawung', (SELECT district_id FROM Districts WHERE district_name = 'Sumur Bandung')),
('Pahlawan', (SELECT district_id FROM Districts WHERE district_name = 'Sumur Bandung')),
('Pasirkaliki', (SELECT district_id FROM Districts WHERE district_name = 'Sumur Bandung')),
('Sukaraja', (SELECT district_id FROM Districts WHERE district_name = 'Sumur Bandung'));

-- Ujungberung
INSERT INTO Subdistricts (subdistrict_name, district_id) VALUES 
('Cicalengka', (SELECT district_id FROM Districts WHERE district_name = 'Ujungberung')),
('Cicadas', (SELECT district_id FROM Districts WHERE district_name = 'Ujungberung')),
('Cimekar', (SELECT district_id FROM Districts WHERE district_name = 'Ujungberung')),
('Sukamulya', (SELECT district_id FROM Districts WHERE district_name = 'Ujungberung')),
('Ujungberung', (SELECT district_id FROM Districts WHERE district_name = 'Ujungberung')),
('Pasirjati', (SELECT district_id FROM Districts WHERE district_name = 'Ujungberung'));

-- Sukasari
INSERT INTO Subdistricts (subdistrict_name, district_id) VALUES 
('Gegerkalong', (SELECT district_id FROM Districts WHERE district_name = 'Sukasari')),
('Isola', (SELECT district_id FROM Districts WHERE district_name = 'Sukasari')),
('Sarijadi', (SELECT district_id FROM Districts WHERE district_name = 'Sukasari')),
('Sukarasa', (SELECT district_id FROM Districts WHERE district_name = 'Sukasari'));