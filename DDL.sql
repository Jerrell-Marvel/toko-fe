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

