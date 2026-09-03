DROP ALL OBJECTS;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'BUYER',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    seller_id INT,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    category VARCHAR(50),
    price DECIMAL(10, 2) NOT NULL,
    stock_qty INT NOT NULL,
    image_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE cart_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT DEFAULT 1,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    shipping_address TEXT DEFAULT 'Standard Express Delivery Address',
    status VARCHAR(30) DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price_at_purchase DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

INSERT INTO users (id, name, email, password_hash, role) VALUES
(1, 'Admin Coach', 'admin@vtmart.com', 'admin123', 'ADMIN'),
(2, 'Pro Fitness Seller', 'seller@vtmart.com', 'seller123', 'SELLER'),
(3, 'Test Buyer', 'buyer@vtmart.com', 'Password@123', 'BUYER'),
(4, 'Iron Beast', 'user@vtmart.com', 'user123', 'BUYER'),
(5, 'Test Customer', 'customer@vtmart.com', 'customer123', 'CUSTOMER');

INSERT INTO products (id, seller_id, name, description, category, price, stock_qty, image_url) VALUES
(1, 2, 'Rubber Hex Dumbbell Set (20kg)', 'Durable cast iron hex dumbbells with ergonomic chrome handles and rubber coating.', 'Free Weights', 4499.00, 25, 'https://images.unsplash.com/photo-1638805981949-3a152e93d8b5?w=800'),
(2, 2, 'Commercial Motorized Treadmill', '3.5 HP AC motor treadmill with auto-incline, shock absorption, and LED display console.', 'Machines', 54999.00, 5, 'https://images.unsplash.com/photo-1540497077202-7c8a3999166f?w=800'),
(3, 2, 'Olympic Barbell 20kg (7ft)', 'High-tensile steel barbell with 1500lb capacity and needle bearings for smooth spin.', 'Free Weights', 7999.00, 15, 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=800'),
(4, 2, 'Heavy-Duty Power Rack Cage', 'Solid steel power cage with safety spotters, multi-grip pull-up bar, and J-hooks.', 'Machines', 24999.00, 8, 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=800'),
(5, 2, 'Adjustable Workout Bench (FID)', 'Multi-angle Flat, Incline, and Decline workout bench with high-density padding.', 'Benches', 6499.00, 20, 'https://images.unsplash.com/photo-1590487988256-9ed24133863e?w=800'),
(6, 2, 'Resistance Bands Set (5 Levels)', 'Premium latex exercise loop bands with handles, door anchor, and carry pouch.', 'Accessories', 999.00, 40, 'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=800'),
(7, 2, 'Cast Iron Kettlebell 16kg', 'Ergonomic wide grip textured kettlebell for crossfit swings, snatches, and conditioning.', 'Free Weights', 2799.00, 30, 'https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?w=800'),
(8, 2, 'Olympic Bumper Plates Set (50kg)', 'High-density natural virgin rubber bumper weight plates for heavy deadlifts and drops.', 'Free Weights', 12999.00, 12, 'https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?w=800'),
(9, 2, 'Dual Cable Lat Pulldown & Row', 'Multi-station dual pulley cable machine with smooth aircraft-grade steel cables.', 'Machines', 42999.00, 6, 'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?w=800'),
(10, 2, 'Air Resistance Assault Bike', 'Heavy-duty steel fan flywheel bike engineered for metabolic HIIT and endurance workouts.', 'Machines', 34999.00, 10, 'https://images.unsplash.com/photo-1598289431512-b97b0917affc?w=800'),
(11, 2, 'Preacher Curl Arm Blaster Bench', 'Ergonomic angled arm support bench for isolated bicep and forearm workouts.', 'Benches', 5499.00, 18, 'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?w=800'),
(12, 2, 'Commercial Hyperextension Roman Chair', '45-degree angled lower back, glute, and hamstring strengthening hyperextension bench.', 'Benches', 8999.00, 10, 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=800'),
(13, 2, 'Genuine Leather Powerlifting Belt (10mm)', 'Quick-release heavy steel lever buckle weightlifting belt for maximum core stability.', 'Accessories', 2999.00, 25, 'https://images.unsplash.com/photo-1517963879433-6ad2b056d712?w=800'),
(14, 2, 'Heavy Padded Deadlift Wrist Straps', 'Non-slip cotton lifting straps reinforced with neoprene padding for heavy pulls.', 'Accessories', 499.00, 80, 'https://images.unsplash.com/photo-1534367507873-d2d7e24c797f?w=800'),
(15, 2, 'Gym Chalk Block (Pure Magnesium)', 'Sweat-resistant pure magnesium carbonate chalk block for rock-solid deadlift grip.', 'Accessories', 349.00, 100, 'https://images.unsplash.com/photo-1574680096145-d05b474e2155?w=800'),
(16, 2, 'Steel Bearing Speed Jump Rope', 'Ultra-fast 360-degree ball bearing wire jump rope built for speed, double-unders, and cardio.', 'Accessories', 599.00, 70, 'https://images.unsplash.com/photo-1518611012118-696072aa579a?w=800'),
(17, 2, 'Deep Tissue Grid Foam Roller', 'High-density trigger point massage grid roller for myofascial back and leg release.', 'Accessories', 899.00, 40, 'https://images.unsplash.com/photo-1607962837359-5e7e89f86776?w=800'),
(18, 2, 'Heavy-Duty Battle Rope (15m)', '1.5 inch thick poly dacron conditioning wave rope with protective durable sleeve.', 'Accessories', 3699.00, 15, 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=800'),
(19, 2, 'EZ Curl Barbell Bar (Chrome)', 'Ergonomic zig-zag angled steel barbell designed to protect wrists during bicep curls.', 'Free Weights', 2499.00, 22, 'https://images.unsplash.com/photo-1586401100295-7a8096fd231a?w=800'),
(20, 2, 'Multi-Grip Wall Mount Pull-Up Bar', 'Heavy gauge solid steel wall-mounted pull-up station with foam padded ergonomic grips.', 'Machines', 2199.00, 35, 'https://images.unsplash.com/photo-1597452485669-2c7bb5fef90d?w=800'),
(21, 2, 'Gymnastic Wooden Ring Set', 'Textured birch wood gymnastic rings with heavy-duty numbered adjustable straps.', 'Accessories', 1999.00, 20, 'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=800'),
(22, 2, 'Heavy Duty Sissy Squat Bench', 'Solid compact deep-squat leg developer bench with adjustable calf and foot pads.', 'Benches', 7499.00, 12, 'https://images.unsplash.com/photo-1590487988256-9ed24133863e?w=800'),
(23, 2, 'Adjustable Iron Weight Vest (20kg)', 'Form-fitting tactical weighted vest with removable iron blocks for bodyweight training.', 'Accessories', 3999.00, 15, 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=800'),
(24, 2, 'Olympic Barbell Quick Collars', 'Durable nylon resin clamp collars with rubber padding for fast barbell plate locking.', 'Accessories', 699.00, 90, 'https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?w=800');