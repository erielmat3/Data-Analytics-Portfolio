**Deskripsi Database:**
Database ini berisi data perusahaan fiktif dengan tabel berikut:
- `website_sessions(website_session_id, created_at, user_id, is_repeat_session, utm_source, utm_campaign, utm_content, device_type, http_referer)`
- `products(product_id, product_name, price)`
- `orders(order_id, order_date, customer_id)`
- `order_items(order_id, product_id, quantity)`

**Pertanyaan:**
1. Tampilkan total penjualan per bulan.
2. Cari produk dengan penjualan terbanyak.
3. Dari produk terlaris (soal 2), tampilkan siapa customer paling sering membelinya.
4. Hitung persentase kontribusi tiap produk terhadap total revenue.
