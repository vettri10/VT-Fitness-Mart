package com.vt.vtmart.dao;

import com.vt.vtmart.model.Product;
import com.vt.vtmart.util.DBUtil;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT id, name, description, price, category, image_url FROM products";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getLong("id"));
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getBigDecimal("price"));
                p.setCategory(rs.getString("category"));
                p.setImageUrl(rs.getString("image_url"));
                list.add(p);
            }
        } catch (Exception e) {
            System.out.println("ProductDAO DB Notice: " + e.getMessage());
        }

        // DB-la 40 items illanaalum guaranteed-aa 40 products load panna fallback
        if (list.size() < 15) {
            return getFortyProductsList();
        }
        return list;
    }

    public List<Product> getProductsByCategory(String category) {
        List<Product> all = getAllProducts();
        if (category == null || category.trim().isEmpty() || "All".equalsIgnoreCase(category)) {
            return all;
        }
        List<Product> filtered = new ArrayList<>();
        for (Product p : all) {
            if (category.equalsIgnoreCase(p.getCategory())) {
                filtered.add(p);
            }
        }
        return filtered;
    }

    public List<Product> searchProducts(String keyword) {
        List<Product> all = getAllProducts();
        if (keyword == null || keyword.trim().isEmpty()) {
            return all;
        }
        String kw = keyword.toLowerCase();
        List<Product> filtered = new ArrayList<>();
        for (Product p : all) {
            if ((p.getName() != null && p.getName().toLowerCase().contains(kw)) ||
                (p.getDescription() != null && p.getDescription().toLowerCase().contains(kw)) ||
                (p.getCategory() != null && p.getCategory().toLowerCase().contains(kw))) {
                filtered.add(p);
            }
        }
        return filtered;
    }

    private List<Product> getFortyProductsList() {
        List<Product> pList = new ArrayList<>();
        long id = 1;

        // --- FREE WEIGHTS (10 items) ---
        pList.add(createP(id++, "Cast Iron Kettlebell 16kg", "Ergonomic wide grip textured kettlebell for crossfit swings.", "2799.00", "Free Weights", "collars.jpg"));
        pList.add(createP(id++, "Olympic Barbell 20kg (7ft)", "High-tensile steel barbell with 1500lb capacity and needle bearings.", "7999.00", "Free Weights", "collars.jpg"));
        pList.add(createP(id++, "Rubber Hex Dumbbell Set (20kg)", "Durable cast iron hex dumbbells with ergonomic chrome handles.", "4499.00", "Free Weights", "collars.jpg"));
        pList.add(createP(id++, "Cast Iron Dumbbell Pair (10kg)", "Heavy-duty textured grip dumbbells for upper body workout.", "1899.00", "Free Weights", "collars.jpg"));
        pList.add(createP(id++, "Cast Iron Dumbbell Pair (15kg)", "Solid weight iron dumbbells designed for strength training.", "2799.00", "Free Weights", "collars.jpg"));
        pList.add(createP(id++, "Olympic Bumper Plates (5kg Pair)", "High density solid rubber bumper plates with steel inserts.", "1499.00", "Free Weights", "collars.jpg"));
        pList.add(createP(id++, "Olympic Bumper Plates (10kg Pair)", "Standard Olympic size bumper plates built for heavy deadlifts.", "2699.00", "Free Weights", "collars.jpg"));
        pList.add(createP(id++, "Olympic Bumper Plates (20kg Pair)", "Competition grade heavy rubber plates for squat and bench.", "4999.00", "Free Weights", "collars.jpg"));
        pList.add(createP(id++, "EZ Curl Barbell (1.2m)", "Ergonomic curved bar to minimize wrist fatigue during curls.", "2499.00", "Free Weights", "collars.jpg"));
        pList.add(createP(id++, "Hex Trap Barbell", "Specialized shrug and deadlift bar for balanced lifting.", "5999.00", "Free Weights", "collars.jpg"));

        // --- BENCHES (10 items) ---
        pList.add(createP(id++, "Adjustable Workout Bench (FID)", "Multi-angle flat, incline, and decline workout bench.", "6499.00", "Benches", "bench.jpg"));
        pList.add(createP(id++, "Heavy-Duty Flat Utility Bench", "Thick high-density padded foam flat bench with sturdy frame.", "3499.00", "Benches", "bench.jpg"));
        pList.add(createP(id++, "Commercial Olympic Incline Bench", "Heavy gauge steel frame bench equipped with Olympic bar catchers.", "14999.00", "Benches", "bench.jpg"));
        pList.add(createP(id++, "Commercial Olympic Decline Bench", "Reinforced decline bench targeting lower pectoral muscle development.", "14499.00", "Benches", "bench.jpg"));
        pList.add(createP(id++, "Seated Preacher Arm Curl Bench", "Ergonomic armrest angle designed for strict isolated bicep curls.", "6999.00", "Benches", "bench.jpg"));
        pList.add(createP(id++, "Hyperextension Roman Chair Bench", "Reinforced lower back and core developer bench station.", "5999.00", "Benches", "bench.jpg"));
        pList.add(createP(id++, "Sissy Squat Machine Bench", "Compact deep squat station isolating quad and knee stability.", "5499.00", "Benches", "bench.jpg"));
        pList.add(createP(id++, "Multi-Angle Foldable Ab Bench", "Space-saving abdominal crunch and sit-up decline bench.", "4299.00", "Benches", "bench.jpg"));
        pList.add(createP(id++, "Competition Olympic Flat Press Bench", "Wide-stance powerlifting competition flat press bench.", "15999.00", "Benches", "bench.jpg"));
        pList.add(createP(id++, "Adjustable Preacher & Hyperextension Combo", "Dual function compact bench for biceps and lower lumbar support.", "8499.00", "Benches", "bench.jpg"));

        // --- MACHINES (10 items) ---
        pList.add(createP(id++, "Heavy-Duty Power Rack Cage", "Solid steel power cage with safety spotters and pull-up bar.", "24999.00", "Machines", "bench.jpg"));
        pList.add(createP(id++, "Commercial Motorized Treadmill", "3.5 HP AC motor treadmill with auto-incline and shock absorbers.", "54999.00", "Machines", "bench.jpg"));
        pList.add(createP(id++, "Cable Crossover Functional Trainer", "Dual weight-stack cable pulleys for unlimited exercise freedom.", "64999.00", "Machines", "pullupbar.jpg"));
        pList.add(createP(id++, "Plate-Loaded Lat Pulldown Station", "High-low dual cable pulley system for back lat workouts.", "28999.00", "Machines", "pullupbar.jpg"));
        pList.add(createP(id++, "Seated Cable Row Machine", "Heavy-duty commercial row station with anti-slip footplate.", "27499.00", "Machines", "pullupbar.jpg"));
        pList.add(createP(id++, "45-Degree Leg Press & Hack Squat", "Smooth roller carriage commercial leg press with safety locks.", "58999.00", "Machines", "bench.jpg"));
        pList.add(createP(id++, "Seated Leg Extension Machine", "Pin-select weight stack machine isolating quadriceps muscles.", "24999.00", "Machines", "bench.jpg"));
        pList.add(createP(id++, "Prone Leg Curl Machine", "Ergonomic lying hamstring curl machine with contoured pads.", "24999.00", "Machines", "bench.jpg"));
        pList.add(createP(id++, "Commercial Smith Machine System", "Linear bearing ultra-smooth vertical bar track with safety catches.", "41999.00", "Machines", "bench.jpg"));
        pList.add(createP(id++, "Air Resistance Assault Bike", "High-intensity interval cardio trainer with heavy-duty fan.", "21999.00", "Machines", "pullupbar.jpg"));

        // --- ACCESSORIES (10 items) ---
        pList.add(createP(id++, "Resistance Bands Set (5 Levels)", "Premium latex exercise loop bands with handles and door anchor.", "999.00", "Accessories", "rings.jpg"));
        pList.add(createP(id++, "Olympic Barbell Quick Lock Collars", "High-impact nylon resin collars with quick release clamp.", "499.00", "Accessories", "collars.jpg"));
        pList.add(createP(id++, "Gymnastic Wooden Rings with Straps", "Solid birch wood rings with 15ft heavy duty numbered straps.", "1699.00", "Accessories", "rings.jpg"));
        pList.add(createP(id++, "Wall-Mounted Multi-Grip Pull-Up Bar", "Laser-cut heavy steel pull up station with foam grips.", "2299.00", "Accessories", "pullupbar.jpg"));
        pList.add(createP(id++, "Heavy-Duty Battle Rope (15m)", "Poly-dacron conditioning rope with heat shrink handles.", "3499.00", "Accessories", "collars.jpg"));
        pList.add(createP(id++, "10mm Leather Weightlifting Belt", "Top-grain genuine leather belt with heavy alloy buckle.", "1999.00", "Accessories", "collars.jpg"));
        pList.add(createP(id++, "Neoprene Padded Lifting Wrist Straps", "Cotton webbed wrist support straps for heavy deadlifts.", "449.00", "Accessories", "collars.jpg"));
        pList.add(createP(id++, "High-Density Foam Roller", "Deep tissue muscle recovery roller for mobility workouts.", "799.00", "Accessories", "collars.jpg"));
        pList.add(createP(id++, "Kettlebell Wrist Guards Pair", "Padded shock-absorbing wrist sleeves for kettlebell cleans.", "599.00", "Accessories", "collars.jpg"));
        pList.add(createP(id++, "Gym Chalk Ball & Container", "Refillable magnesium carbonate chalk ball for sweat-free grip.", "399.00", "Accessories", "collars.jpg"));

        return pList;
    }

    private Product createP(long id, String name, String desc, String price, String category, String img) {
        Product p = new Product();
        p.setId(id);
        p.setName(name);
        p.setDescription(desc);
        p.setPrice(new BigDecimal(price));
        p.setCategory(category);
        p.setImageUrl(img);
        return p;
    }
}
