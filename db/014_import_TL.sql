-- 013_import_typhoon_lagoon.sql
-- WonderBound ThemeParks.wiki water park snapshot.
-- Run entire file in pgAdmin. Rerunnable via themeparks_id UPSERT.
BEGIN;

DO $$
BEGIN
    IF (SELECT COUNT(*) FROM locations WHERE location_name IN ('Disney''s Typhoon Lagoon Water Park', 'Disney''s Typhoon Lagoon', 'Typhoon Lagoon')) <> 1 THEN
        RAISE EXCEPTION 'Water park location not found uniquely in locations; check location_name';
    END IF;
    IF EXISTS (
        SELECT 1 FROM (VALUES ('Attractions'), ('Dining')) AS required(category_name)
        WHERE (SELECT COUNT(*) FROM activity_categories c WHERE c.category_name = required.category_name) <> 1
    ) THEN
        RAISE EXCEPTION 'Required activity categories missing or duplicated';
    END IF;
END $$;

CREATE TEMP TABLE typhoon_lagoon_import (
    themeparks_id UUID NOT NULL PRIMARY KEY,
    activity_name VARCHAR(255) NOT NULL,
    entity_type VARCHAR(50) NOT NULL,
    source_external_id VARCHAR(100),
    slug VARCHAR(255),
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION
) ON COMMIT DROP;

INSERT INTO typhoon_lagoon_import
    (themeparks_id, activity_name, entity_type, source_external_id, slug, latitude, longitude)
VALUES
    ('5327448f-463d-4567-8c5d-f1a169f4c14f', 'Castaway Creek', 'ATTRACTION', '80010115;entityType=Attraction', 'castawaycreek', 28.3660367345, -81.5287544578),
    ('a3886522-e19f-4154-8cdf-1ca7160e4e2b', 'Keelhaul Falls', 'ATTRACTION', '80010155;entityType=Attraction', 'keelhaulfalls', 28.3654943759, -81.5305106342),
    ('5e3e0fa5-830f-48e7-aada-242e32bb5a7d', 'Leaning Palms', 'RESTAURANT', '90001800;entityType=restaurant', 'leaningpalms', 28.3650655553, -81.5287088407),
    ('b8db6b26-dd1f-4048-9a07-97324ced97d9', 'Typhoon Tilly''s', 'RESTAURANT', '90002324;entityType=restaurant', 'typhoontillys', 28.366606, -81.529416),
    ('f61c4451-d0d6-440a-bdc7-cf059b5ffbc3', 'Storm Slides', 'ATTRACTION', '80010194;entityType=Attraction', 'stormslides', 28.366791097, -81.5304308189),
    ('185c53bc-7153-4bf1-a582-5c03d18c90ee', 'Ketchakiddee Creek', 'ATTRACTION', '80010156;entityType=Attraction', 'ketchakiddeecreek', 28.36507, -81.530505),
    ('0164bf43-29ab-4528-8052-98befbe81bcb', 'Mayday Falls', 'ATTRACTION', '80010167;entityType=Attraction', 'maydayfalls', 28.3656245494, -81.530521363),
    ('7e4402eb-0f0b-41d3-8713-3e57b7b58af8', 'Typhoon Lagoon Surf Pool', 'ATTRACTION', '13602;entityType=Attraction', 'typhoonlagoonsurfpool', 28.3659144638, -81.5299641145),
    ('f8f36470-ca60-4072-ba2c-9d186a337cac', 'Gangplank Falls', 'ATTRACTION', '80010138;entityType=Attraction', 'gangplankfalls', 28.3657380338, -81.5305508673),
    ('1b39b2bc-8bf3-4482-b0cf-9ad7329dc42f', 'Bay Slides', 'ATTRACTION', '20534;entityType=Attraction', 'bayslides', 28.365402, -81.529838),
    ('d298e9e5-cb62-40f7-803a-5e8500023474', 'Miss Adventure Falls', 'ATTRACTION', '18628633;entityType=Attraction', 'missadventurefalls', 28.366796, -81.528804),
    ('7dec8e5f-e082-4453-8fb3-f2f1da8b8aca', 'Humunga Kowabunga', 'ATTRACTION', '80010143;entityType=Attraction', 'humungakowabunga', 28.3665795566, -81.5303215741),
    ('9fd9c4e3-2fbc-4705-975e-67abe45c4281', 'Crush ''n'' Gusher', 'ATTRACTION', '14200;entityType=Attraction', 'crushngusher', 28.3666932987, -81.5282974765),
    ('2d10251f-240c-4e29-a6d6-191e2cff9975', 'Lowtide Lou''s', 'RESTAURANT', '90001831;entityType=restaurant', 'lowtidelous', 28.3655058603, -81.5301636136),
    ('5389f2e1-4e06-4b45-80ae-6049f805ec80', 'Let''s Go Slurpin''', 'RESTAURANT', '90001805;entityType=restaurant', 'letsgoslurpin', 28.3661513, -81.5288741);

INSERT INTO activities (
    activity_name, activity_category_id, location_id, themeparks_id,
    source_external_id, entity_type, slug, latitude, longitude
)
SELECT
    i.activity_name, c.activity_category_id, l.location_id, i.themeparks_id,
    i.source_external_id, i.entity_type, i.slug, i.latitude, i.longitude
FROM typhoon_lagoon_import i
JOIN locations l ON l.location_name IN ('Disney''s Typhoon Lagoon Water Park', 'Disney''s Typhoon Lagoon', 'Typhoon Lagoon')
JOIN activity_categories c ON c.category_name = CASE i.entity_type
    WHEN 'ATTRACTION' THEN 'Attractions'
    WHEN 'RESTAURANT' THEN 'Dining'
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

-- Verify actual database counts for this park.
SELECT a.entity_type, COUNT(*) AS activity_count
FROM activities a
JOIN locations l ON l.location_id = a.location_id
WHERE l.location_name IN ('Disney''s Typhoon Lagoon Water Park', 'Disney''s Typhoon Lagoon', 'Typhoon Lagoon')
GROUP BY a.entity_type
ORDER BY a.entity_type;
