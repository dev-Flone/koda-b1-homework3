-- CREATE TABLE users (
--     id SERIAL PRIMARY KEY,
--     nama VARCHAR(255) NOT NULL,
--     nomor TEXT CHECK (nomor ~ '^\+?[0-9\s\-\(\)]{7,20}$'),
--     email VARCHAR(50) UNIQUE
-- );



-- CREATE TABLE menu (
--     id SERIAL PRIMARY KEY,
--     nama VARCHAR(255) NOT NULL,
--     deskripsi TEXT,
--     harga NUMERIC(12, 2) NOT NULL CHECK (harga > 0),
--     created_at DATE NOT NULL DEFAULT CURRENT_DATE
-- );

-- CREATE TABLE keranjang (
--     id SERIAL PRIMARY KEY,
--     user_id INT REFERENCES users(id) NOT NULL,
--     status VARCHAR(50) NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'pending', 'dibayar', 'dibatalkan', 'selesai')),
--     created_at DATE NOT NULL DEFAULT CURRENT_DATE
-- );

-- CREATE TABLE detail_pesanan (
--     id SERIAL PRIMARY KEY,
--     menu_id INT REFERENCES menu(id) NOT NULL,
--     keranjang_id INT REFERENCES keranjang(id) NOT NULL,
--     jumlah INT NOT NULL DEFAULT 1 CHECK (jumlah > 0)
-- );


-- CREATE TABLE kontak (
--     id SERIAL PRIMARY KEY,
--     nama VARCHAR(255) NOT NULL,
--     email VARCHAR(255) NOT NULL UNIQUE,
--     pesan TEXT NOT NULL,
--     created_at DATE DEFAULT CURRENT_DATE NOT NULL
-- )

-- INSERT INTO users(nama, nomor, email) VALUES
-- ('Kairn', '08123456789', 'kairn@gmail.com'),
-- ('Flone', '08134567890', 'flone@gmail.com'),
-- ('KairnFLone', '08145678901', 'kairnflone@gmail.com')

-- INSERT INTO menu(nama, deskripsi, harga) VALUES
-- (
--         'Margherita Classic',
--         'Saus tomat premium, mozzarella, daun basil segar, dan sedikit olive oil.',
--         75000
--     ),
--     (
--         'Pepperoni Supreme',
--         'Pepperoni sapi melimpah, mozzarella, saus tomat khas, dan oregano.',
--         95000
--     ),
--     (
--         'BBQ Chicken Blast',
--         'Dada ayam panggang, saus BBQ, bawang bombay, paprika, dan mozzarella.',
--         98000
--     ),
--     (
--         'Meat Lovers',
--         'Pepperoni, smoked beef, sosis sapi, daging cincang, dan keju mozzarella ekstra.',
--         110000
--     ),
--     (
--         'Mushroom Truffle Delight',
--         'Jamur champignon, jamur kancing, saus krim truffle, dan parmesan.',
--         105000
--     ),
--     (
--         'Hawaiian Paradise',
--         'Ham sapi, potongan nanas manis, mozzarella, dan saus tomat spesial.',
--         90000
--     ),
--     (
--         'Spicy Volcano',
--         'Ayam pedas, cabai merah, jalapeño, paprika, dan saus sambal spesial.',
--         99000
--     ),
--     (
--         'Veggie Garden',
--         'Jamur, paprika, bawang bombay, tomat ceri, zaitun hitam, dan mozzarella.',
--         85000
--     ),
--     (
--         'Cheese Overload',
--         'Kombinasi mozzarella, cheddar, parmesan, dan cream cheese dengan saus putih.',
--         100000
--     ),
--     (
--         'Rendang Fusion Pizza',
--         'Daging rendang khas Indonesia, bawang merah, cabai hijau, mozzarella, dan saus rendang spesial.',
--         115000
--     );

-- INSERT INTO keranjang(user_id, status) VALUES
-- (1, 'active'),
-- (2, 'dibayar'),
-- (3, 'dibatalkan'),
-- (3, 'dibayar')

-- INSERT INTO detail_pesanan (menu_id, keranjang_id, jumlah) VALUES
-- (7, 1, 2),
-- (4, 2, 1),
-- (2, 3, 2),
-- (2, 1, 3)

SELECT m.nama, m.harga, sum(dp.jumlah) as jumlah_total, sum(dp.jumlah * m.harga) as total_sub_total
FROM detail_pesanan dp
JOIN keranjang k ON dp.keranjang_id = k.id
JOIN menu m ON m.id = dp.menu_id
GROUP BY m.id, m.nama, m.harga
HAVING SUM(dp.jumlah * m.harga) > 50000
ORDER BY total_sub_total DESC