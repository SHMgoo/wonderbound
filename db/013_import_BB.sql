-- 014_import_blizzard_beach.sql
-- WonderBound ThemeParks.wiki water park snapshot.
-- Run entire file in pgAdmin. Rerunnable via themeparks_id UPSERT.
BEGIN;

DO $$
BEGIN
    IF (SELECT COUNT(*) FROM locations WHERE location_name IN ('Disney''s Blizzard Beach Water Park', 'Disney''s Blizzard Beach', 'Blizzard Beach')) <> 1 THEN
        RAISE EXCEPTION 'Water park location not found uniquely in locations; check location_name';
    END IF;
    IF EXISTS (
        SELECT 1 FROM (VALUES ('Attractions'), ('Dining')) AS required(category_name)
        WHERE (SELECT COUNT(*) FROM activity_categories c WHERE c.category_name = required.category_name) <> 1
    ) THEN
        RAISE EXCEPTION 'Required activity categories missing or duplicated';
    END IF;
END $$;

CREATE TEMP TABLE blizzard_beach_import (
    themeparks_id UUID NOT NULL PRIMARY KEY,
    activity_name VARCHAR(255) NOT NULL,
    entity_type VARCHAR(50) NOT NULL,
    source_external_id VARCHAR(100),
    slug VARCHAR(255),
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION
) ON COMMIT DROP;

INSERT INTO blizzard_beach_import
    (themeparks_id, activity_name, entity_type, source_external_id, slug, latitude, longitude)
VALUES
    ('97011c19-a864-4922-b63b-6519ca9e6ed0', 'Chairlift', 'ATTRACTION', '80010116;entityType=Attraction', 'chairlift', 28.3521916073, -81.5742527498),
    ('310d5c7e-433c-46bb-91ee-da8bc39edf32', 'Melt-Away Bay', 'ATTRACTION', '80010168;entityType=Attraction', 'meltawaybay', 28.3513855054, -81.5745799793),
    ('896053f3-55e7-40f9-9473-208d4bc43d33', 'Snow Stormers', 'ATTRACTION', '80010187;entityType=Attraction', 'snowstormers', 28.3514397089, -81.5756890923),
    ('ada6a611-31ef-426a-a1f4-bfce8503f4a6', 'Runoff Rapids', 'ATTRACTION', '80010183;entityType=Attraction', 'runoffrapids', 28.351462, -81.576098),
    ('c0feb82e-f296-4f4d-9474-f31797e32e5a', 'Polar Pub', 'RESTAURANT', '90002049;entityType=restaurant', 'polarpub', 28.3510474667, -81.5740509331),
    ('2b3e5eeb-0cbc-4d19-a46e-07b5ddf8a700', 'Cross Country Creek', 'ATTRACTION', '80010122;entityType=Attraction', 'crosscountrycreek', 28.3513399635, -81.5736767258),
    ('6f427ef0-9c56-4041-8f78-357ad2fcf390', 'Teamboat Springs', 'ATTRACTION', '80010198;entityType=Attraction', 'teamboatsprings', 28.351967, -81.575911),
    ('b9516054-a8b4-4d4c-aa0b-a60f3c3dc360', 'Summit Plummet', 'ATTRACTION', '80010195;entityType=Attraction', 'summitplummet', 28.3519232056, -81.5758319199),
    ('161f82e8-eaf8-4401-811b-fe2b45cccd0e', 'Slush Gusher', 'ATTRACTION', '80010186;entityType=Attraction', 'slushgusher', 28.3518728427, -81.5757836401),
    ('7220bf88-61e6-4d04-b134-635336dbbd6b', 'Avalunch', 'RESTAURANT', '90001258;entityType=restaurant', 'avalunch', 28.3522776001, -81.5746162087),
    ('bd408ea5-efba-47da-84cc-e304ac0ee974', 'Tike''s Peak', 'ATTRACTION', '71;entityType=Attraction', 'tikespeak', 28.3529402305, -81.5745699406),
    ('849728c7-0043-4bbe-af64-e65679679e09', 'Toboggan Racers', 'ATTRACTION', '80010219;entityType=Attraction', 'tobogganracers', 28.351715, -81.575773),
    ('fdc8e386-4fc9-4d0f-ba0d-d3df695df071', 'Downhill Double Dipper', 'ATTRACTION', '80010128;entityType=Attraction', 'downhilldoubledipper', 28.351215713, -81.5756836496),
    ('b218c3de-0f7f-436c-be44-2f5112d5d139', 'Ski Patrol Training Camp', 'ATTRACTION', '24750;entityType=Attraction', 'skipatroltrainingcamp', 28.352258, -81.575348),
    ('8854deed-264b-4dcd-bf1a-6dd83e023f13', 'Warming Hut', 'RESTAURANT', '90002364;entityType=restaurant', 'warminghut', 28.3507657218, -81.5746757006),
    ('9f14a00b-54f5-4a71-b904-decd4bcc6957', 'Lottawatta Lodge', 'RESTAURANT', '90001827;entityType=restaurant', 'lottawattalodge', 28.351487, -81.573231),
    ('17ecbbd6-4d5b-4ad8-9f77-3ee8f69795dc', 'Frostbite Freddy''s Frozen Refreshments', 'RESTAURANT', '113666;entityType=restaurant', 'frostbitefreddysfrozenfreshments', 28.3523550694, -81.5736693497);

INSERT INTO activities (
    activity_name, activity_category_id, location_id, themeparks_id,
    source_external_id, entity_type, slug, latitude, longitude
)
SELECT
    i.activity_name, c.activity_category_id, l.location_id, i.themeparks_id,
    i.source_external_id, i.entity_type, i.slug, i.latitude, i.longitude
FROM blizzard_beach_import i
JOIN locations l ON l.location_name IN ('Disney''s Blizzard Beach Water Park', 'Disney''s Blizzard Beach', 'Blizzard Beach')
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
WHERE l.location_name IN ('Disney''s Blizzard Beach Water Park', 'Disney''s Blizzard Beach', 'Blizzard Beach')
GROUP BY a.entity_type
ORDER BY a.entity_type;
