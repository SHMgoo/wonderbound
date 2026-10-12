-- 015_import_disney_springs.sql
-- WonderBound Disney Springs: 45 reviewed candidate activities from ThemeParks.wiki.
-- Excludes 3 Saratoga Springs / Lake Buena Vista Golf Course dining records.
-- Execute whole script in pgAdmin. Safe to rerun via themeparks_id UPSERT.
BEGIN;

DO $$
BEGIN
    IF (SELECT COUNT(*) FROM locations WHERE location_name = 'Disney Springs') <> 1 THEN
        RAISE EXCEPTION 'Expected exactly one Disney Springs row in locations';
    END IF;
    IF EXISTS (SELECT 1 FROM (VALUES ('Attractions'), ('Dining'), ('Entertainment')) v(name)
               WHERE (SELECT COUNT(*) FROM activity_categories c WHERE c.category_name = v.name) <> 1) THEN
        RAISE EXCEPTION 'Required activity categories missing or duplicated';
    END IF;
END $$;

CREATE TEMP TABLE disney_springs_import (
    themeparks_id UUID PRIMARY KEY,
    activity_name VARCHAR(255) NOT NULL,
    entity_type VARCHAR(50) NOT NULL,
    source_external_id VARCHAR(100),
    slug VARCHAR(255),
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION
) ON COMMIT DROP;

INSERT INTO disney_springs_import (themeparks_id, activity_name, entity_type, source_external_id, slug, latitude, longitude)
VALUES
    ('1a28e52a-2d77-4c47-a4a9-7ec7448ebe86', 'Aerophile - The World Leader in Balloon Flight', 'ATTRACTION', '18721320;entityType=Attraction', NULL, 28.370954, -81.519473),
    ('7b5f10e4-2b9e-45bc-a0f9-2aeccde3511e', 'Disney PhotoPass(R) Studio', 'ATTRACTION', '412179400;entityType=Attraction', NULL, 28.3719593528654, -81.514506718637),
    ('e18743bb-86dd-4c4b-b7e5-e067c6d0cecc', 'LEVEL99', 'ATTRACTION', '412340300;entityType=Attraction', NULL, 28.3704643761067, -81.5220148949035),
    ('0fdae04f-15f5-45d6-b705-cae3bf32a27a', 'Marketplace Carousel', 'ATTRACTION', '65081;entityType=Attraction', NULL, 28.372854, -81.514925),
    ('a1919d4a-62db-486b-b958-5ddb380f3a6c', 'Marketplace Train Express', 'ATTRACTION', '65082;entityType=Attraction', NULL, 28.372459, -81.51473),
    ('b7f1180a-65fd-4f56-9ba3-44c7ef7ab0a2', 'Vintage Amphicar Tours', 'ATTRACTION', '18693677;entityType=Attraction', NULL, 28.37167, -81.517986),
    ('22a28609-167e-4303-ae86-36055bcce908', 'Amorette''s Patisserie', 'RESTAURANT', '18415488;entityType=restaurant', NULL, 28.370903, -81.515568),
    ('a2c20fd0-d7a4-4673-9f90-38ad076f408c', 'B.B. Wolf''s Sausage Co.', 'RESTAURANT', '18424520;entityType=restaurant', NULL, 28.371604, -81.516218),
    ('2814cb10-6acf-4cd9-bfae-1e5538fd1d20', 'Chef Art Smith''s Homecomin''', 'RESTAURANT', '18427314;entityType=restaurant', NULL, 28.370506, -81.518161),
    ('927d02df-e29e-406a-b6e0-db8ae62e6f8b', 'City Works Eatery & Pour House', 'RESTAURANT', '19124370;entityType=restaurant', NULL, 28.370596, -81.522276),
    ('21a5ca02-34cf-4b06-96b4-36b55da0f58b', 'D-Luxe Burger', 'RESTAURANT', '18396826;entityType=restaurant', NULL, 28.370314, -81.517603),
    ('761ab303-115c-4a74-90f5-e1ba1bb820e7', 'Dockside Margaritas', 'RESTAURANT', '18061966;entityType=restaurant', NULL, 28.372128, -81.514895),
    ('2c3dc890-9640-4577-a0bf-edfc0d35a420', 'eet by Maneet Chauhan', 'RESTAURANT', '412013553;entityType=restaurant', NULL, 28.37318511, -81.51492566),
    ('20fd5ca8-4803-4a63-8c7b-f5bf7f0ac438', 'Enzo''s Hideaway', 'RESTAURANT', '18808553;entityType=restaurant', NULL, 28.370388, -81.518849),
    ('147d2b17-6401-47ed-803d-56f0245b31ac', 'Frontera Cocina', 'RESTAURANT', '18436515;entityType=restaurant', NULL, 28.370572, -81.517059),
    ('12848c7f-1560-481c-8766-c744f127cad2', 'Goofy''s Candy Company', 'RESTAURANT', '19630459;entityType=restaurant', NULL, 28.372798, -81.515258),
    ('4fd47b79-1d70-46b7-b245-93aa6ff05141', 'House of Blues(R) Restaurant & Bar', 'RESTAURANT', '90001754;entityType=restaurant', NULL, 28.370981, -81.522092),
    ('651211a5-4521-47e8-9f4c-38c470750ab1', 'Jaleo(R) by Jose Andres', 'RESTAURANT', '19063652;entityType=restaurant', NULL, 28.370454, -81.521242),
    ('9bc68422-dca0-4dcd-b6a5-5df122a4a521', 'Jock Lindsey''s Hangar Bar', 'RESTAURANT', '18107544;entityType=restaurant', NULL, 28.371583, -81.518348),
    ('5117dd93-1fb1-4215-aa2f-af520bb316f2', 'Lava Lounge at Rainforest Cafe(R)', 'RESTAURANT', '17480848;entityType=restaurant', NULL, 28.372584, -81.515846),
    ('d5ae53c1-d58c-4d8b-80ad-34115b1e9010', 'MacGUFFINS', 'RESTAURANT', '15775832;entityType=restaurant', NULL, 28.3699962, -81.52075627),
    ('a3a16def-102d-4264-b181-f4e6a19396bf', 'Maria & Enzo''s Ristorante', 'RESTAURANT', '18807537;entityType=restaurant', NULL, 28.370632, -81.518844),
    ('5b1f886f-4f27-4dbe-aa05-3e3701046d57', 'Morimoto Asia(TM)', 'RESTAURANT', '17936194;entityType=restaurant', NULL, 28.370915, -81.517838),
    ('682db3a8-1bd3-4ff1-8efb-d3522c52b1cc', 'Morimoto Asia(TM) Street Food', 'RESTAURANT', '18427474;entityType=restaurant', NULL, 28.370741, -81.51806),
    ('2c6deb77-9c18-4c8d-8b41-685be62302ad', 'Paddlefish', 'RESTAURANT', '18457125;entityType=restaurant', NULL, 28.37177, -81.517019),
    ('e34b847d-fe0e-4a53-8d3b-3b03b1454ff2', 'Paradiso 37, Taste of the Americas', 'RESTAURANT', '343233;entityType=restaurant', NULL, 28.370997, -81.518455),
    ('7ad20d41-f0dd-4f37-aad1-9896a69f03f8', 'Planet Hollywood(R)', 'RESTAURANT', '18475350;entityType=restaurant', NULL, 28.369605, -81.518921),
    ('e711b7c8-5fd2-4a92-89ae-2b1ad9f9f312', 'Raglan Road(TM) Irish Pub and Restaurant', 'RESTAURANT', '90002044;entityType=restaurant', NULL, 28.37108, -81.517761),
    ('05f7fd04-0f74-4311-ab99-87fc46f8d3e2', 'Rainforest Cafe(R) at Disney Springs Marketplace', 'RESTAURANT', '90001873;entityType=restaurant', NULL, 28.372817, -81.515516),
    ('07858618-c4a5-491c-a46e-f23e1e8f702e', 'Splitsville Dining Room', 'RESTAURANT', '17134590;entityType=restaurant', NULL, 28.37015719, -81.52134816),
    ('54342abd-9ca5-4c22-8248-b375f19a05bf', 'Stargazers Bar', 'RESTAURANT', '18687557;entityType=restaurant', NULL, 28.369886, -81.518875),
    ('8c794f55-b178-4fd5-83fa-d968e6e99621', 'STK(R) Steakhouse', 'RESTAURANT', '17957969;entityType=restaurant', NULL, 28.370591, -81.518601),
    ('5ef3a16f-5567-4b28-ac3f-0fe14efec9ad', 'Summer House on the Lake', 'RESTAURANT', '411854928;entityType=restaurant', NULL, 28.370372, -81.520659),
    ('4f4a2520-0f1c-4ca0-b50d-5330f86dac0d', 'T-REX (TM)', 'RESTAURANT', '293563;entityType=restaurant', NULL, 28.371309, -81.516568),
    ('517915ac-153d-4d46-a5ce-49caa99a24ea', 'Terralina Crafted Italian', 'RESTAURANT', '18752054;entityType=restaurant', NULL, 28.371737, -81.51725),
    ('4a2e8a2d-b1f4-43b6-bac6-9cac176f144a', 'The Basket at Wine Bar George', 'RESTAURANT', '19025524;entityType=restaurant', NULL, 28.371388, -81.517902),
    ('15bbd788-0124-4da9-b8ab-b8bfb113a07d', 'The BOATHOUSE(R): Great Food, Waterfront Dining, Dream Boats(TM)', 'RESTAURANT', '17936197;entityType=restaurant', NULL, 28.371775, -81.517975),
    ('7ea07ed3-df47-4354-84e6-d300e7e11ea8', 'The Daily Poutine', 'RESTAURANT', '18424498;entityType=restaurant', NULL, 28.371099, -81.51574),
    ('2c304546-14c9-43ce-afc9-882e584ea739', 'The Edison', 'RESTAURANT', '18472966;entityType=restaurant', NULL, 28.370847, -81.51871),
    ('82449365-24c5-4acd-abe9-cd020dc498e5', 'The Front Porch at House of Blues', 'RESTAURANT', '131027;entityType=restaurant', NULL, 28.370887, -81.522014),
    ('77f5f20d-b201-4278-8467-229707d6ee3e', 'The Smokehouse at House of Blues(R)', 'RESTAURANT', '17728113;entityType=restaurant', NULL, 28.370698, -81.522029),
    ('017be6c6-f85a-4e1c-b2dd-e5634de9d2f6', 'Wine Bar George - A Restaurant & Bar', 'RESTAURANT', '18667615;entityType=restaurant', NULL, 28.371388, -81.517902),
    ('9bc45ea6-b1e7-4370-9df2-08609f5dc61d', 'Wolfgang Puck(R) Bar & Grill', 'RESTAURANT', '19084067;entityType=restaurant', NULL, 28.369231, -81.518499),
    ('7ecb9219-1f28-4b76-af97-afd1f7ddb769', 'YeSake Kiosk', 'RESTAURANT', '18430303;entityType=restaurant', NULL, 28.370055, -81.519053),
    ('c1e11196-5e3e-4441-a4ad-85bbde64f7fe', 'Drawn to Life Presented by Cirque du Soleil & Disney', 'SHOW', '19382527;entityType=Entertainment', NULL, 28.370719, -81.522536);

-- Fail before writing if the staged source unexpectedly changes.
DO $$
BEGIN
    IF (SELECT COUNT(*) FROM disney_springs_import) <> 45 THEN
        RAISE EXCEPTION 'Expected 45 Disney Springs activities in staging';
    END IF;
END $$;

INSERT INTO activities (activity_name, activity_category_id, location_id, themeparks_id,
                        source_external_id, entity_type, slug, latitude, longitude)
SELECT i.activity_name, c.activity_category_id, l.location_id, i.themeparks_id,
       i.source_external_id, i.entity_type, i.slug, i.latitude, i.longitude
FROM disney_springs_import i
JOIN locations l ON l.location_name = 'Disney Springs'
JOIN activity_categories c ON c.category_name = CASE i.entity_type
    WHEN 'ATTRACTION' THEN 'Attractions'
    WHEN 'RESTAURANT' THEN 'Dining'
    WHEN 'SHOW' THEN 'Entertainment'
END
ON CONFLICT (themeparks_id) DO UPDATE SET
    activity_name = EXCLUDED.activity_name,
    activity_category_id = EXCLUDED.activity_category_id,
    location_id = EXCLUDED.location_id,
    source_external_id = EXCLUDED.source_external_id,
    entity_type = EXCLUDED.entity_type,
    slug = EXCLUDED.slug,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

COMMIT;

-- Post-import verification: expect 6 ATTRACTION, 38 RESTAURANT, 1 SHOW.
SELECT a.entity_type, COUNT(*) AS activity_count
FROM activities a
JOIN locations l ON l.location_id = a.location_id
WHERE l.location_name = 'Disney Springs'
GROUP BY a.entity_type
ORDER BY a.entity_type;
