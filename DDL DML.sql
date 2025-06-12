-- DDL

-- User bisa member / admin
CREATE TABLE Users (
  user_id SERIAL PRIMARY KEY,
  user_email VARCHAR(255) NOT NULL UNIQUE,
  user_password VARCHAR(255) NOT NULL, 
  user_name VARCHAR(255) NOT NULL,
  user_role VARCHAR(50) NOT NULL DEFAULT 'member',
  user_phone VARCHAR(50) UNIQUE,
  is_active BOOLEAN DEFAULT TRUE NOT NULL
);

--Kecamatan
CREATE TABLE Districts (
  district_id SERIAL PRIMARY KEY,
  district_name VARCHAR(255) NOT NULL
);

--Kelurahan
CREATE TABLE Subdistricts (
  subdistrict_id SERIAL PRIMARY KEY,
  subdistrict_name VARCHAR(255) NOT NULL,
  district_id INT REFERENCES Districts(district_id) NOT NULL
);

-- Alamat user
CREATE TABLE Addresses (
  address_id SERIAL PRIMARY KEY,
  user_id INT REFERENCES USERS(user_id) NOT NULL,
  address_name VARCHAR(255) NOT NULL,
  address_label varchar(255) NOT NULL,
  is_active BOOLEAN DEFAULT TRUE NOT NULL,
  subdistrict_id INT REFERENCES Subdistricts(subdistrict_id) NOT NULL --Kelurahan
);

-- Kategori produk
CREATE TABLE Categories (
  category_id SERIAL PRIMARY KEY,
  category_name VARCHAR(255) NOT NULL,
  is_active BOOLEAN DEFAULT TRUE NOT NULL
);

-- Foto untuk di banner halaman kategori, dibuat terpisah sama table Categories karena mungkin aja di masa depan banner nya mau dijadiin carousel yang bisa banyak foto
CREATE TABLE Category_Images (
  category_image_id SERIAL PRIMARY KEY,
  category_id INT REFERENCES Categories(category_id) NOT NULL,
  category_image_url VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  is_active BOOLEAN DEFAULT TRUE NOT NULL
);

-- Produk
-- product_featured_image_url itu gambar utama nya, yang kalau di tokped muncul di card
CREATE TABLE Products (
  product_id SERIAL PRIMARY KEY,
  product_name VARCHAR(255) NOT NULL,
  product_price DECIMAL(10,2) NOT NULL CHECK (product_price >= 0),
  product_stock INT DEFAULT 0,
  product_details TEXT,
  product_featured_image_url VARCHAR(255) NOT NULL,
  is_active BOOLEAN DEFAULT TRUE NOT NULL,
  category_id INT REFERENCES Categories(category_id) NOT NULL
);


-- Foto produk yang lain
-- ada created_at buat nanti jadi snapshot juga
-- jadi logic nya pas liat history pesanan, nah kalau liat foto itu ambil nya Product_Images yang created_at nya sebelum created_at Orders tapi paling baru
CREATE TABLE Product_Images (
  product_image_id SERIAL PRIMARY KEY,
  product_id INT REFERENCES Products(product_id) NOT NULL,
  product_image_url VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  is_active BOOLEAN DEFAULT TRUE NOT NULL
);

-- buat 1 product pada cart
CREATE TABLE Cart_Items (
  cart_item_id SERIAL PRIMARY KEY,
  product_id INT REFERENCES Products(product_id) NOT NULL,
  user_id INT REFERENCES Users(user_id) NOT NULL,
  product_quantity INT NOT NULL DEFAULT 1
);


-- DML
INSERT INTO Categories (category_name) VALUES
('Fashion'),
('Beauty'),
('Groceries'),
('Electronics'),
('Furniture'),
('Sports');


INSERT INTO Category_Images (category_id, category_image_url) VALUES
(1, 'category_images-fashion.jpg'),
(2, 'category_images-beauty.jpg'),
(3, 'category_images-groceries.jpg'),
(4, 'category_images-electronics.jpg'),
(5, 'category_images-furniture.jpg'),
(6, 'category_images-sports.jpg');

INSERT INTO public.products VALUES (2, 'White T-Shirt', 75000.00, 100, 'Our White T-Shirt is made of high-quality cotton, offering a soft and breathable feel. Perfect for casual wear, gym, or layering under a jacket.', 'featured_image-1739182353045-309873668.jpg', true, 1);
INSERT INTO public.products VALUES (3, 'Red Lipstick', 120000.00, 200, 'A long-lasting, highly pigmented red lipstick that provides a smooth matte finish for an elegant look.', 'featured_image-1739182595164-184885418.jpg', true, 2);
INSERT INTO public.products VALUES (4, 'Slim Fit Jeans', 250000.00, 50, 'A pair of stylish slim-fit jeans made with durable denim fabric. Designed for comfort and everyday use.', 'featured_image-1739239950205-559941911.jpg', true, 1);
INSERT INTO public.products VALUES (5, 'Moisturizing Face Cream', 180000.00, 75, 'A hydrating face cream enriched with natural ingredients to keep your skin soft and nourished all day.', 'featured_image-1739242693268-171551811.jpg', true, 2);
INSERT INTO public.products VALUES (6, 'Organic Rice 5kg', 90000.00, 300, 'Premium quality organic rice, free from chemicals and pesticides. Perfect for daily meals.', 'featured_image-1739242830235-879515711.jpg', true, 3);
INSERT INTO public.products VALUES (7, 'Instant Coffee 200g', 65000.00, 150, 'Rich and aromatic instant coffee made from the finest coffee beans. Ready to enjoy in seconds.', 'featured_image-1739243204046-745948674.jpg', true, 3);
INSERT INTO public.products VALUES (8, 'Smartphone 8 128 GB', 3500000.00, 30, 'A high-performance smartphone featuring a 6.5-inch display, powerful processor, and long battery life.', 'featured_image-1739243235144-8754342.jpg', true, 4);
INSERT INTO public.products VALUES (9, 'Wireless Earbuds', 500000.00, 100, 'Bluetooth-enabled wireless earbuds with noise cancellation and long battery life. Ideal for music and calls.', 'featured_image-1739243262436-223483982.jpg', true, 4);
INSERT INTO public.products VALUES (10, 'Wooden Dining Table', 1500000.00, 20, 'A beautifully crafted wooden dining table that comfortably seats six people. Made from high-quality teak wood.', 'featured_image-1739243291956-583108983.jpg', true, 5);
INSERT INTO public.products VALUES (11, 'Ergonomic Office Chair', 850000.00, 40, 'A comfortable and stylish office chair with adjustable height and lumbar support, designed for long working hours.', 'featured_image-1739243345301-548009053.jpg', true, 5);
INSERT INTO public.products VALUES (12, 'Running Shoes', 600000.00, 80, 'Lightweight and breathable running shoes with superior cushioning for maximum comfort during workouts.', 'featured_image-1739243375702-518577292.jpg', true, 6);
INSERT INTO public.products VALUES (13, 'Yoga Mat', 200000.00, 150, 'A non-slip yoga mat made from eco-friendly material, providing excellent support and grip during exercises.', 'featured_image-1739243403552-599961944.jpg', true, 6);
INSERT INTO public.products VALUES (14, 'Maybelline Super Stay Matte Ink', 120000.00, 100, 'Maybelline Super Stay Matte Ink provides long-lasting, intense color with a matte finish. Its smudge-proof formula ensures up to 16 hours of wear, making it perfect for any occasion.', 'featured_image-1739243429905-142652181.jpg', true, 2);
INSERT INTO public.products VALUES (15, 'Indomie Mi Goreng', 3500.00, 1000, 'Indomie Mi Goreng is Indonesia''s favorite instant fried noodle, offering a delicious blend of savory soy sauce, fried onion, and chili for an authentic taste experience.', 'featured_image-1739243464996-695212489.jpg', true, 3);
INSERT INTO public.products VALUES (16, 'Samsung Galaxy S23 Ultra', 18999000.00, 20, 'Samsung Galaxy S23 Ultra comes with a powerful Snapdragon 8 Gen 2 processor, a stunning 200MP camera, and an S Pen for ultimate productivity. Experience the next level of mobile innovation.', 'featured_image-1739243493918-252264718.jpg', true, 4);
INSERT INTO public.products VALUES (17, 'IKEA MALM Bed Frame', 4500000.00, 30, 'The IKEA MALM bed frame offers a sleek and modern design with durable wood construction. It features built-in storage drawers, making it a practical choice for any bedroom.', 'featured_image-1739243519122-118035190.jpg', true, 5);
INSERT INTO public.products VALUES (18, 'Adidas Predator Edge.3 FG', 1100000.00, 40, 'The Adidas Predator Edge.3 FG is engineered for precision and control, featuring a textured upper for enhanced ball grip and a firm ground outsole for superior traction on the field.', 'featured_image-1739243551131-748982773.jpg', true, 6);
INSERT INTO public.products VALUES (19, 'Levi''s 501 Original Jeans', 899000.00, 75, 'The Levi''s 501 Original Jeans offer a classic straight-leg fit with durable denim construction. Designed for comfort and timeless style, they are perfect for everyday wear.', 'featured_image-1739243588435-340994831.jpg', true, 1);
INSERT INTO public.products VALUES (20, 'L''Oreal Paris Revitalift Night Cream', 250000.00, 90, 'L''Oreal Paris Revitalift Night Cream is formulated with Pro-Retinol and Centella Asiatica to reduce wrinkles and improve skin firmness while you sleep.', 'featured_image-1739243615217-885300164.jpg', true, 2);
INSERT INTO public.products VALUES (21, 'Blue Band Margarine 200g', 12000.00, 500, 'Blue Band Margarine is enriched with essential vitamins and a rich buttery taste, perfect for baking, cooking, and spreading on bread.', 'featured_image-1739243642500-729228027.jpg', true, 3);
INSERT INTO public.products VALUES (22, 'Apple MacBook Air M2', 19999000.00, 15, 'Apple MacBook Air M2 features a sleek, lightweight design with a powerful M2 chip, Liquid Retina display, and all-day battery life for ultimate portability and performance.', 'featured_image-1739243671839-747966874.jpg', true, 4);
INSERT INTO public.products VALUES (23, 'Minimalist Wooden Coffee Table', 1200000.00, 25, 'This minimalist wooden coffee table combines a sleek, modern aesthetic with durable solid wood construction, making it a stylish addition to any living space.', 'featured_image-1739243701171-252761277.jpg', true, 5);
INSERT INTO public.products VALUES (24, 'Yonex Astrox 99 Pro Badminton Racket', 2800000.00, 35, 'Yonex Astrox 99 Pro is designed for advanced players, offering enhanced power and control with its rotational generator system and stiff shaft.', 'featured_image-1739243726337-577624014.jpg', true, 6);
INSERT INTO public.products VALUES (25, 'Zara Men''s Slim Fit Blazer', 1299000.00, 30, 'A stylish slim-fit blazer from Zara, made with high-quality fabric for a sophisticated and modern look. Perfect for formal and semi-formal occasions.', 'featured_image-1739243758472-113075711.jpg', true, 1);
INSERT INTO public.products VALUES (26, 'The Body Shop Tea Tree Oil', 159000.00, 80, 'The Body Shop Tea Tree Oil is a purifying essential oil that helps reduce blemishes and control excess oil for clearer skin.', 'featured_image-1739243784110-364797571.jpg', true, 2);
INSERT INTO public.products VALUES (27, 'Nescafe Classic Instant Coffee 200g', 45000.00, 300, 'Nescafe Classic is made from high-quality coffee beans, offering a rich and aromatic taste to start your day right.', 'featured_image-1739243809482-874831035.jpg', true, 3);
INSERT INTO public.products VALUES (28, 'Sony WH-1000XM5 Noise Cancelling Headphones', 5999000.00, 20, 'Sony WH-1000XM5 delivers industry-leading noise cancellation, crystal-clear sound, and up to 30 hours of battery life for an immersive audio experience.', 'featured_image-1739243834813-485373973.jpg', true, 4);
INSERT INTO public.products VALUES (29, 'Inoac Premium Foam Mattress 160x200cm', 2750000.00, 15, 'Inoac''s premium foam mattress offers superior comfort and durability, ensuring restful sleep with its high-density foam material.', 'featured_image-1739243860881-175391502.jpg', true, 5);
INSERT INTO public.products VALUES (30, 'Wilson NBA Authentic Basketball', 750000.00, 50, 'Wilson NBA Authentic Basketball is designed for professional play, featuring superior grip and durability for both indoor and outdoor use.', 'featured_image-1739243885411-162798938.jpg', true, 6);
INSERT INTO public.products VALUES (31, 'Maybelline Superstay Matte Ink Lipstick', 110000.00, 120, 'Maybelline Superstay Matte Ink Lipstick provides long-lasting, smudge-proof color with a smooth matte finish that stays put for up to 16 hours.', 'featured_image-1739243911040-927258838.jpg', true, 2);
INSERT INTO public.products VALUES (32, 'IKEA MALM 3-Drawer Chest', 1799000.00, 25, 'IKEA MALM 3-Drawer Chest offers a sleek, modern design with spacious storage compartments, perfect for bedrooms and living spaces.', 'featured_image-1739243937147-689343149.jpg', true, 5);
INSERT INTO public.products VALUES (33, 'H&M Cotton Oversized Hoodie', 349000.00, 50, 'A comfortable and stylish oversized hoodie made from soft cotton. Perfect for casual wear and layering during colder days.', 'featured_image-1739243962548-604313943.jpg', true, 1);
INSERT INTO public.products VALUES (34, 'SK-II Facial Treatment Essence 230ml', 2650000.00, 20, 'SK-II Facial Treatment Essence contains over 90% Pitera to improve skin texture, reduce wrinkles, and enhance skin radiance.', 'featured_image-1739244101506-227392205.jpg', true, 2);
INSERT INTO public.products VALUES (35, 'Sunlight Dishwashing Liquid Refill 750ml', 18000.00, 500, 'Sunlight Dishwashing Liquid effectively removes grease and food stains with a fresh lemon fragrance, making dishwashing easier.', 'featured_image-1739244128752-471627932.jpg', true, 3);
INSERT INTO public.products VALUES (36, 'Logitech MX Master 3 Wireless Mouse', 1499000.00, 30, 'The Logitech MX Master 3 is an advanced wireless mouse with ultra-fast scrolling, ergonomic design, and precise tracking for productivity.', 'featured_image-1739244155678-931723556.jpg', true, 4);
INSERT INTO public.products VALUES (37, 'Minimalist Bookshelf with 5 Shelves', 899000.00, 40, 'A modern minimalist bookshelf with five spacious shelves, perfect for storing books, decorations, and household items.', 'featured_image-1739244181369-525122531.jpg', true, 5);
INSERT INTO public.products VALUES (38, 'Decathlon Domyos Adjustable Dumbbells 10kg', 650000.00, 50, 'A set of adjustable dumbbells with a 10kg total weight, ideal for home workouts and strength training.', 'featured_image-1739244208002-703900798.jpg', true, 6);
INSERT INTO public.products VALUES (39, 'Kirkland Signature Organic Almonds 1.36kg', 375000.00, 80, 'Premium quality organic almonds from Kirkland Signature, rich in nutrients and perfect for healthy snacking.', 'featured_image-1739244232938-944045039.jpg', true, 3);
INSERT INTO public.products VALUES (40, 'Ashley Furniture Recliner Sofa', 5799000.00, 10, 'A luxurious recliner sofa by Ashley Furniture, designed for ultimate comfort with premium fabric and ergonomic support.', 'featured_image-1739244259168-724782584.jpg', true, 5);
INSERT INTO public.products VALUES (41, 'Uniqlo Women''s Cotton Long Dress', 399000.00, 50, 'A comfortable and breathable long dress made from 100% cotton. Suitable for daily wear with a minimalist and elegant design.', 'featured_image-1739244282873-683470118.jpg', true, 1);
INSERT INTO public.products VALUES (42, 'Cetaphil Gentle Skin Cleanser 500ml', 195000.00, 60, 'A mild, non-irritating facial and body cleanser for all skin types, recommended by dermatologists for sensitive skin.', 'featured_image-1739244307123-794797404.jpg', true, 2);
INSERT INTO public.products VALUES (43, 'Nutella Hazelnut Spread 750g', 85000.00, 200, 'Deliciously smooth chocolate hazelnut spread, perfect for breakfast or as a topping for your favorite desserts.', 'featured_image-1739244332552-480870023.jpg', true, 3);
INSERT INTO public.products VALUES (44, 'Paseo Soft Facial Tissue 250 Sheets', 15000.00, 300, 'Premium quality soft and absorbent facial tissue, suitable for everyday use.', 'featured_image-1739244362049-330281126.jpg', true, 3);
INSERT INTO public.products VALUES (45, 'Razer BlackWidow V4 Mechanical Gaming Keyboard', 2499000.00, 25, 'A high-performance mechanical gaming keyboard with Razer Green switches, RGB lighting, and dedicated macro keys.', 'featured_image-1739244387822-760989657.jpg', true, 4);
INSERT INTO public.products VALUES (46, 'King Koil Luxury Mattress 180x200cm', 8999000.00, 15, 'A high-quality luxury mattress with premium materials that provide excellent comfort and back support.', 'featured_image-1739244413347-43782904.jpg', true, 5);
INSERT INTO public.products VALUES (47, 'Garmin Forerunner 245 GPS Running Watch', 4999000.00, 18, 'A GPS running smartwatch with advanced training features, heart rate monitoring, and music storage.', 'featured_image-1739244440614-574381632.jpg', true, 6);
INSERT INTO public.products VALUES (48, 'Wilson US Open Tennis Balls - 3 Pack', 120000.00, 150, 'Official tennis balls used in the US Open, designed for excellent durability and consistent bounce.', 'featured_image-1739244465869-258946282.jpg', true, 6);
INSERT INTO public.products VALUES (49, 'Zara Men''s Slim Fit Chinos', 499000.00, 70, 'Zara Men''s Slim Fit Chinos are made from high-quality cotton and feature a modern, tailored fit, perfect for both casual and formal occasions.', 'featured_image-1739244490687-735282830.jpg', true, 1);
INSERT INTO public.products VALUES (50, 'Bango Sweet Soy Sauce 600ml', 25000.00, 400, 'Bango Sweet Soy Sauce is a versatile condiment made from high-quality soybeans, perfect for marinating, dipping, or enhancing the flavor of your dishes.', 'featured_image-1739244526117-673576155.jpg', true, 3);
INSERT INTO public.products VALUES (51, 'Dyson V15 Detect Cordless Vacuum', 12000000.00, 12, 'The Dyson V15 Detect Cordless Vacuum features laser dust detection, powerful suction, and a HEPA filtration system for a thorough clean.', 'featured_image-1739244553170-766090254.jpg', true, 4);
INSERT INTO public.products VALUES (52, 'Adidas Ultraboost 22 Running Shoes', 2200000.00, 50, 'Adidas Ultraboost 22 running shoes feature responsive Boost cushioning and a Primeknit upper for a snug, comfortable fit, ideal for long-distance running.', 'featured_image-1739244580012-76972781.jpg', true, 6);
INSERT INTO public.products VALUES (53, 'Mid-Century Modern Sofa', 5500000.00, 10, 'This mid-century modern sofa combines timeless design with premium upholstery, offering both style and comfort for your living room.', 'featured_image-1739244605020-584140332.jpg', true, 5);
INSERT INTO public.products VALUES (54, 'LG 55-inch 4K UHD Smart TV', 8999000.00, 8, 'The LG 55-inch 4K UHD Smart TV features vibrant colors, Dolby Vision, and webOS for seamless streaming and smart functionality', 'featured_image-1739244632252-389904606.jpg', true, 4);
INSERT INTO public.products VALUES (55, 'Industrial Style Dining Table', 4500000.00, 5, 'This industrial-style dining table is crafted from reclaimed wood and metal, offering a rugged yet elegant centerpiece for your dining area.', 'featured_image-1739244658315-336175040.jpg', true, 5);
INSERT INTO public.products VALUES (56, 'Modern Glass Top Coffee Table', 1500000.00, 8, 'This modern glass top coffee table features a sleek metal frame and a tempered glass surface, adding a contemporary touch to your living room.', 'featured_image-1739244688691-936187369.jpg', true, 5);
INSERT INTO public.products VALUES (57, 'Nestlé KitKat Chunky Chocolate Bar', 10000.00, 500, 'Nestlé KitKat Chunky is a delicious chocolate bar with a thick layer of creamy milk chocolate and a crispy wafer center.', 'featured_image-1739244714378-772620021.jpg', true, 3);
INSERT INTO public.products VALUES (58, 'Apple iPad Pro 12.9-inch (M1 Chip)', 17999000.00, 15, 'The Apple iPad Pro 12.9-inch features the powerful M1 chip, a stunning Liquid Retina XDR display, and support for the Apple Pencil and Magic Keyboard.', 'featured_image-1739244741062-764301170.jpg', true, 4);
INSERT INTO public.products VALUES (59, 'MAC Matte Lipstick in Ruby Woo', 350000.00, 80, 'MAC Matte Lipstick in Ruby Woo is a vibrant red shade with a matte finish, offering long-lasting, bold color for any occasion.', 'featured_image-1739244767870-196069384.jpg', true, 2);
INSERT INTO public.products VALUES (60, 'Quaker Oats Instant Oatmeal 800g', 45000.00, 150, 'Quaker Oats Instant Oatmeal is a nutritious and convenient breakfast option, rich in fiber and essential nutrients to start your day right.', 'featured_image-1739244792806-493187375.jpg', true, 3);
INSERT INTO public.products VALUES (61, 'Tommy Hilfiger Men''s Polo Shirt', 699000.00, 50, 'The Tommy Hilfiger Men''s Polo Shirt is crafted from premium cotton and features a classic fit with the iconic Tommy Hilfiger logo.', 'featured_image-1739244817044-585907918.jpg', true, 1);
INSERT INTO public.products VALUES (62, 'Sony PlayStation 5 Console', 9999000.00, 10, 'The Sony PlayStation 5 offers lightning-fast loading, immersive 4K graphics, and a revolutionary gaming experience with the DualSense wireless controller.', 'featured_image-1739244848212-240543704.jpg', true, 4);
INSERT INTO public.products VALUES (63, 'Scandinavian Style Bookshelf', 2500000.00, 12, 'This Scandinavian-style bookshelf features a minimalist design with multiple shelves, perfect for organizing books and decor in your living space.', 'featured_image-1739244874856-284722552.jpg', true, 5);
INSERT INTO public.products VALUES (64, 'Puma Men''s Essentials Logo T-Shirt', 249000.00, 100, 'The Puma Essentials Logo T-Shirt is made from soft cotton and features a classic fit with the iconic Puma logo, perfect for casual wear.', 'featured_image-1739244902386-208425194.jpg', true, 1);
INSERT INTO public.products VALUES (65, 'Rattan Lounge Chair', 1800000.00, 18, 'This rattan lounge chair combines natural materials with a modern design, offering a comfortable and stylish seating option for your home.', 'featured_image-1739244932680-754196374.jpg', true, 5);


INSERT INTO public.product_images VALUES (1, 3, 'images-1739271341407-829975982.jpg', '2025-02-11 17:55:41.507971', true);
INSERT INTO public.product_images VALUES (2, 3, 'images-1739271341409-718574792.jpg', '2025-02-11 17:55:41.507971', true);
INSERT INTO public.product_images VALUES (3, 3, 'images-1739271341412-372905640.jpg', '2025-02-11 17:55:41.507971', true);

INSERT INTO Districts(district_name) VALUES 
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

-- Insert subdistricts
INSERT INTO subdistricts (subdistrict_name, district_id) VALUES
('Campaka', (SELECT district_id FROM districts WHERE district_name = 'Andir')),
('Ciroyom', (SELECT district_id FROM districts WHERE district_name = 'Andir')),
('Dunguscariang', (SELECT district_id FROM districts WHERE district_name = 'Andir')),
('Garuda', (SELECT district_id FROM districts WHERE district_name = 'Andir')),
('Kebonjeruk', (SELECT district_id FROM districts WHERE district_name = 'Andir')),
('Maleber', (SELECT district_id FROM districts WHERE district_name = 'Andir')),

('Cibadak', (SELECT district_id FROM districts WHERE district_name = 'Astana Anyar')),
('Karanganyar', (SELECT district_id FROM districts WHERE district_name = 'Astana Anyar')),
('Karasak', (SELECT district_id FROM districts WHERE district_name = 'Astana Anyar')),
('Nyengseret', (SELECT district_id FROM districts WHERE district_name = 'Astana Anyar')),
('Panjunan', (SELECT district_id FROM districts WHERE district_name = 'Astana Anyar')),
('Pelindunghewan', (SELECT district_id FROM districts WHERE district_name = 'Astana Anyar')),

('Antapani Kidul', (SELECT district_id FROM districts WHERE district_name = 'Antapani')),
('Antapani Kulon', (SELECT district_id FROM districts WHERE district_name = 'Antapani')),
('Antapani Tengah', (SELECT district_id FROM districts WHERE district_name = 'Antapani')),
('Antapani Wetan', (SELECT district_id FROM districts WHERE district_name = 'Antapani')),

('Cisaranten Bina Harapan', (SELECT district_id FROM districts WHERE district_name = 'Arcamanik')),
('Cisaranten Endah', (SELECT district_id FROM districts WHERE district_name = 'Arcamanik')),
('Cisaranten Kulon', (SELECT district_id FROM districts WHERE district_name = 'Arcamanik')),
('Sukamiskin', (SELECT district_id FROM districts WHERE district_name = 'Arcamanik')),

('Babakan', (SELECT district_id FROM districts WHERE district_name = 'Babakan Ciparay')),
('Babakanciparay', (SELECT district_id FROM districts WHERE district_name = 'Babakan Ciparay')),
('Cirangrang', (SELECT district_id FROM districts WHERE district_name = 'Babakan Ciparay')),
('Margahayu Utara', (SELECT district_id FROM districts WHERE district_name = 'Babakan Ciparay')),
('Margasuka', (SELECT district_id FROM districts WHERE district_name = 'Babakan Ciparay')),
('Sukahaji', (SELECT district_id FROM districts WHERE district_name = 'Babakan Ciparay')),

('Batununggal', (SELECT district_id FROM districts WHERE district_name = 'Bandung Kidul')),
('Kujangsari', (SELECT district_id FROM districts WHERE district_name = 'Bandung Kidul')),
('Mengger', (SELECT district_id FROM districts WHERE district_name = 'Bandung Kidul')),
('Wates', (SELECT district_id FROM districts WHERE district_name = 'Bandung Kidul')),

('Caringin', (SELECT district_id FROM districts WHERE district_name = 'Bandung Kulon')),
('Cibuntu', (SELECT district_id FROM districts WHERE district_name = 'Bandung Kulon')),
('Cigondewah Kaler', (SELECT district_id FROM districts WHERE district_name = 'Bandung Kulon')),
('Cigondewah Kidul', (SELECT district_id FROM districts WHERE district_name = 'Bandung Kulon')),
('Cigondewah Rahayu', (SELECT district_id FROM districts WHERE district_name = 'Bandung Kulon')),
('Cijerah', (SELECT district_id FROM districts WHERE district_name = 'Bandung Kulon')),
('Gempolsari', (SELECT district_id FROM districts WHERE district_name = 'Bandung Kulon')),
('Warungmuncang', (SELECT district_id FROM districts WHERE district_name = 'Bandung Kulon')),

('Cihapit', (SELECT district_id FROM districts WHERE district_name = 'Bandung Wetan')),
('Citarum', (SELECT district_id FROM districts WHERE district_name = 'Bandung Wetan')),
('Tamansari', (SELECT district_id FROM districts WHERE district_name = 'Bandung Wetan')),

('Binong', (SELECT district_id FROM districts WHERE district_name = 'Batununggal')),
('Cibangkong', (SELECT district_id FROM districts WHERE district_name = 'Batununggal')),
('Gumuruh', (SELECT district_id FROM districts WHERE district_name = 'Batununggal')),
('Kacapiring', (SELECT district_id FROM districts WHERE district_name = 'Batununggal')),
('Kebongedang', (SELECT district_id FROM districts WHERE district_name = 'Batununggal')),
('Kebonwaru', (SELECT district_id FROM districts WHERE district_name = 'Batununggal')),
('Maleer', (SELECT district_id FROM districts WHERE district_name = 'Batununggal')),
('Samaja', (SELECT district_id FROM districts WHERE district_name = 'Batununggal')),

('Babakan Asih', (SELECT district_id FROM districts WHERE district_name = 'Bojongloa Kaler')),
('Babakan Tarogong', (SELECT district_id FROM districts WHERE district_name = 'Bojongloa Kaler')),
('Jamika', (SELECT district_id FROM districts WHERE district_name = 'Bojongloa Kaler')),
('Kopo', (SELECT district_id FROM districts WHERE district_name = 'Bojongloa Kaler')),
('Suka Asih', (SELECT district_id FROM districts WHERE district_name = 'Bojongloa Kaler'));

-- Bojongloa Kidul (district_id 11)
INSERT INTO subdistricts (subdistrict_name, district_id) VALUES 
('Cibaduyut', (SELECT district_id FROM districts WHERE district_name = 'Bojongloa Kidul')),
('Cibaduyut Kidul', (SELECT district_id FROM districts WHERE district_name = 'Bojongloa Kidul')),
('Cibaduyut Wetan', (SELECT district_id FROM districts WHERE district_name = 'Bojongloa Kidul')),
('Kebon Lega', (SELECT district_id FROM districts WHERE district_name = 'Bojongloa Kidul')),
('Mekarwangi', (SELECT district_id FROM districts WHERE district_name = 'Bojongloa Kidul')),
('Situsaeur', (SELECT district_id FROM districts WHERE district_name = 'Bojongloa Kidul'));

-- Buahbatu (district_id 12)
INSERT INTO subdistricts (subdistrict_name, district_id) VALUES 
('Cijawura', (SELECT district_id FROM districts WHERE district_name = 'Buahbatu')),
('Jatisari', (SELECT district_id FROM districts WHERE district_name = 'Buahbatu')),
('Margasari', (SELECT district_id FROM districts WHERE district_name = 'Buahbatu')),
('Sekejati', (SELECT district_id FROM districts WHERE district_name = 'Buahbatu'));

-- Cibeunying Kaler (district_id 13)
INSERT INTO subdistricts (subdistrict_name, district_id) VALUES 
('Cigadung', (SELECT district_id FROM districts WHERE district_name = 'Cibeunying Kaler')),
('Cihaurgeulis', (SELECT district_id FROM districts WHERE district_name = 'Cibeunying Kaler')),
('Neglasari', (SELECT district_id FROM districts WHERE district_name = 'Cibeunying Kaler')),
('Sukaluyu', (SELECT district_id FROM districts WHERE district_name = 'Cibeunying Kaler'));

-- Cibeunying Kidul (district_id 14)
INSERT INTO subdistricts (subdistrict_name, district_id) VALUES 
('Cicadas', (SELECT district_id FROM districts WHERE district_name = 'Cibeunying Kidul')),
('Cikutra', (SELECT district_id FROM districts WHERE district_name = 'Cibeunying Kidul')),
('Padasuka', (SELECT district_id FROM districts WHERE district_name = 'Cibeunying Kidul')),
('Pasirlayung', (SELECT district_id FROM districts WHERE district_name = 'Cibeunying Kidul')),
('Sukamaju', (SELECT district_id FROM districts WHERE district_name = 'Cibeunying Kidul')),
('Sukapada', (SELECT district_id FROM districts WHERE district_name = 'Cibeunying Kidul'));

-- Cibiru (district_id 15)
INSERT INTO subdistricts (subdistrict_name, district_id) VALUES 
('Cipadung', (SELECT district_id FROM districts WHERE district_name = 'Cibiru')),
('Cisurupan', (SELECT district_id FROM districts WHERE district_name = 'Cibiru')),
('Palasari', (SELECT district_id FROM districts WHERE district_name = 'Cibiru')),
('Pasirbiru', (SELECT district_id FROM districts WHERE district_name = 'Cibiru'));

-- Cicendo (district_id 16)
INSERT INTO subdistricts (subdistrict_name, district_id) VALUES 
('Arjuna', (SELECT district_id FROM districts WHERE district_name = 'Cicendo')),
('Husen Sastranegara', (SELECT district_id FROM districts WHERE district_name = 'Cicendo')),
('Pajajaran', (SELECT district_id FROM districts WHERE district_name = 'Cicendo')),
('Pamoyanan', (SELECT district_id FROM districts WHERE district_name = 'Cicendo')),
('Pasirkaliki', (SELECT district_id FROM districts WHERE district_name = 'Cicendo')),
('Sukaraja', (SELECT district_id FROM districts WHERE district_name = 'Cicendo'));

-- Cidadap (district_id 17)
INSERT INTO subdistricts (subdistrict_name, district_id) VALUES 
('Ciumbuleuit', (SELECT district_id FROM districts WHERE district_name = 'Cidadap')),
('Hegarmanah', (SELECT district_id FROM districts WHERE district_name = 'Cidadap')),
('Ledeng', (SELECT district_id FROM districts WHERE district_name = 'Cidadap'));

-- Cinambo (district_id 18)
INSERT INTO subdistricts (subdistrict_name, district_id) VALUES 
('Babakan Penghulu', (SELECT district_id FROM districts WHERE district_name = 'Cinambo')),
('Cisaranten Wetan', (SELECT district_id FROM districts WHERE district_name = 'Cinambo')),
('Pakemitan', (SELECT district_id FROM districts WHERE district_name = 'Cinambo')),
('Sukamulya', (SELECT district_id FROM districts WHERE district_name = 'Cinambo'));

-- Coblong (district_id 19)
INSERT INTO subdistricts (subdistrict_name, district_id) VALUES 
('Cipaganti', (SELECT district_id FROM districts WHERE district_name = 'Coblong')),
('Dago', (SELECT district_id FROM districts WHERE district_name = 'Coblong')),
('Lebakgede', (SELECT district_id FROM districts WHERE district_name = 'Coblong')),
('Lebaksiliwangi', (SELECT district_id FROM districts WHERE district_name = 'Coblong')),
('Sadangserang', (SELECT district_id FROM districts WHERE district_name = 'Coblong')),
('Sekeloa', (SELECT district_id FROM districts WHERE district_name = 'Coblong'));

-- Gedebage (district_id 20)
INSERT INTO subdistricts (subdistrict_name, district_id) VALUES 
('Cimincrang', (SELECT district_id FROM districts WHERE district_name = 'Gedebage')),
('Cisaranten Kidul', (SELECT district_id FROM districts WHERE district_name = 'Gedebage')),
('Rancabolang', (SELECT district_id FROM districts WHERE district_name = 'Gedebage')),
('Rancanumpang', (SELECT district_id FROM districts WHERE district_name = 'Gedebage'));

-- Kiaracondong (district_id 21)
INSERT INTO subdistricts (subdistrict_name, district_id) VALUES 
('Babakansari', (SELECT district_id FROM districts WHERE district_name = 'Kiaracondong')),
('Babakansurabaya', (SELECT district_id FROM districts WHERE district_name = 'Kiaracondong')),
('Cicaheum', (SELECT district_id FROM districts WHERE district_name = 'Kiaracondong')),
('Kebonkangkung', (SELECT district_id FROM districts WHERE district_name = 'Kiaracondong')),
('Kebunjayanti', (SELECT district_id FROM districts WHERE district_name = 'Kiaracondong')),
('Sukapura', (SELECT district_id FROM districts WHERE district_name = 'Kiaracondong'));

-- Lengkong (district_id 22)
INSERT INTO subdistricts (subdistrict_name, district_id) VALUES 
('Burangrang', (SELECT district_id FROM districts WHERE district_name = 'Lengkong')),
('Cijagra', (SELECT district_id FROM districts WHERE district_name = 'Lengkong')),
('Cikawao', (SELECT district_id FROM districts WHERE district_name = 'Lengkong')),
('Lingkar Selatan', (SELECT district_id FROM districts WHERE district_name = 'Lengkong')),
('Malabar', (SELECT district_id FROM districts WHERE district_name = 'Lengkong')),
('Paledang', (SELECT district_id FROM districts WHERE district_name = 'Lengkong')),
('Turangga', (SELECT district_id FROM districts WHERE district_name = 'Lengkong'));

-- Mandalajati (district_id 23)
INSERT INTO subdistricts (subdistrict_name, district_id) VALUES 
('Jatihandap', (SELECT district_id FROM districts WHERE district_name = 'Mandalajati')),
('Karangpamulang', (SELECT district_id FROM districts WHERE district_name = 'Mandalajati')),
('Pasir Impun', (SELECT district_id FROM districts WHERE district_name = 'Mandalajati')),
('Sindangjaya', (SELECT district_id FROM districts WHERE district_name = 'Mandalajati'));

-- Panyileukan (district_id 24)
INSERT INTO subdistricts (subdistrict_name, district_id) VALUES 
('Cipadung Kidul', (SELECT district_id FROM districts WHERE district_name = 'Panyileukan')),
('Cipadung Kulon', (SELECT district_id FROM districts WHERE district_name = 'Panyileukan')),
('Cipadung Wetan', (SELECT district_id FROM districts WHERE district_name = 'Panyileukan')),
('Mekarmulya', (SELECT district_id FROM districts WHERE district_name = 'Panyileukan'));

-- Rancasari (district_id 25)
INSERT INTO subdistricts (subdistrict_name, district_id) VALUES 
('Cisaranten', (SELECT district_id FROM districts WHERE district_name = 'Rancasari')),
('Kampung Baru', (SELECT district_id FROM districts WHERE district_name = 'Rancasari')),
('Rancanera', (SELECT district_id FROM districts WHERE district_name = 'Rancasari'));

-- Regol (district_id 26)
INSERT INTO subdistricts (subdistrict_name, district_id) VALUES 
('Kebon Kelapa', (SELECT district_id FROM districts WHERE district_name = 'Regol')),
('Kebon Pala', (SELECT district_id FROM districts WHERE district_name = 'Regol')),
('Neglasari', (SELECT district_id FROM districts WHERE district_name = 'Regol')),
('Sukamaju', (SELECT district_id FROM districts WHERE district_name = 'Regol'));

-- Sukajadi (district_id 27)
INSERT INTO subdistricts (subdistrict_name, district_id) VALUES 
('Cijagra', (SELECT district_id FROM districts WHERE district_name = 'Sukajadi')),
('Husein Sastranegara', (SELECT district_id FROM districts WHERE district_name = 'Sukajadi')),
('Indihiang', (SELECT district_id FROM districts WHERE district_name = 'Sukajadi')),
('Ledeng', (SELECT district_id FROM districts WHERE district_name = 'Sukajadi')),
('Mekarwangi', (SELECT district_id FROM districts WHERE district_name = 'Sukajadi'));

-- Sumur Bandung (district_id 28)
INSERT INTO subdistricts (subdistrict_name, district_id) VALUES 
('Cikawao', (SELECT district_id FROM districts WHERE district_name = 'Sumur Bandung')),
('Cidadap', (SELECT district_id FROM districts WHERE district_name = 'Sumur Bandung')),
('Kebon Kawung', (SELECT district_id FROM districts WHERE district_name = 'Sumur Bandung')),
('Pahlawan', (SELECT district_id FROM districts WHERE district_name = 'Sumur Bandung')),
('Pasirkaliki', (SELECT district_id FROM districts WHERE district_name = 'Sumur Bandung')),
('Sukaraja', (SELECT district_id FROM districts WHERE district_name = 'Sumur Bandung'));

-- Ujungberung (district_id 29)
INSERT INTO subdistricts (subdistrict_name, district_id) VALUES 
('Cicalengka', (SELECT district_id FROM districts WHERE district_name = 'Ujungberung')),
('Cicadas', (SELECT district_id FROM districts WHERE district_name = 'Ujungberung')),
('Cimekar', (SELECT district_id FROM districts WHERE district_name = 'Ujungberung')),
('Sukamulya', (SELECT district_id FROM districts WHERE district_name = 'Ujungberung')),
('Ujungberung', (SELECT district_id FROM districts WHERE district_name = 'Ujungberung')),
('Pasirjati', (SELECT district_id FROM districts WHERE district_name = 'Ujungberung'));

-- Sukasari (district_id 30)
INSERT INTO subdistricts (subdistrict_name, district_id) VALUES 
('Gegerkalong', (SELECT district_id FROM districts WHERE district_name = 'Sukasari')),
('Isola', (SELECT district_id FROM districts WHERE district_name = 'Sukasari')),
('Sarijadi', (SELECT district_id FROM districts WHERE district_name = 'Sukasari')),
('Sukarasa', (SELECT district_id FROM districts WHERE district_name = 'Sukasari'));