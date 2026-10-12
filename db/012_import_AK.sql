-- 012_import_animal_kingdom.sql
-- WonderBound: ThemeParks.wiki Animal Kingdom children snapshot.
-- Run the entire script in pgAdmin. Safe to rerun by themeparks_id.
BEGIN;

DO $$
BEGIN
    IF (SELECT COUNT(*) FROM locations WHERE location_name IN ('Disney''s Animal Kingdom Theme Park', 'Disney''s Animal Kingdom', 'Animal Kingdom')) <> 1 THEN
        RAISE EXCEPTION 'Animal Kingdom location not found uniquely in locations; check location_name';
    END IF;
    IF EXISTS (
        SELECT 1 FROM (VALUES ('Attractions'), ('Dining'), ('Entertainment')) AS required(category_name)
        WHERE (SELECT COUNT(*) FROM activity_categories c WHERE c.category_name = required.category_name) <> 1
    ) THEN
        RAISE EXCEPTION 'Required activity categories missing or duplicated';
    END IF;
END $$;

CREATE TEMP TABLE animal_kingdom_import (
    themeparks_id UUID NOT NULL PRIMARY KEY,
    activity_name VARCHAR(255) NOT NULL,
    entity_type VARCHAR(50) NOT NULL,
    source_external_id VARCHAR(100),
    slug VARCHAR(255),
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION
) ON COMMIT DROP;

INSERT INTO animal_kingdom_import
    (themeparks_id, activity_name, entity_type, source_external_id, slug, latitude, longitude)
VALUES
    ('6fbe6d02-4057-43bb-80a3-047b1e8a50ca', 'Animal Care at Conservation Station', 'ATTRACTION', '80010119;entityType=Attraction', 'conservationstation', 28.36533, -81.58872),
    ('d58d9262-ec95-4161-80a0-07ca43b2f5f3', 'Kali River Rapids', 'ATTRACTION', '80010154;entityType=Attraction', 'kaliriverrapids', 28.3587834288, -81.5889412165),
    ('4f391f0e-52be-4f9d-99d6-b3ae0373b43c', 'Wildlife Express Train', 'ATTRACTION', '80010235;entityType=Attraction', 'wildlifeexpresstrain', 28.3598097347, -81.5914175464),
    ('f210842b-8c9b-4088-9f48-6284e9ce389a', 'Nomad Lounge', 'RESTAURANT', '18377778;entityType=restaurant', 'nomadlounge', 28.356719, -81.591487),
    ('d58db4d0-3bad-4655-937b-1cbc9ed0e880', 'Tusker House Restaurant', 'RESTAURANT', '90002686;entityType=restaurant', 'tuskerhouserestaurant', 28.3585843066, -81.5921041919),
    ('9a64300c-4861-4bed-9713-b4f49e55e566', 'The Smiling Crocodile', 'RESTAURANT', '90002646;entityType=restaurant', 'thesmilingcrocodile', 28.3577, -81.589802),
    ('a8781403-1344-4c06-89ef-b7a39b99ae59', 'Harambe Village Street Band – Burudika', 'SHOW', '16235871;entityType=Entertainment', NULL, 28.35873, -81.591951),
    ('a349429a-5ef8-41c4-9a28-84ed4f7a0465', 'Viva Gaia Street Band!', 'SHOW', '16629705;entityType=Entertainment', 'vivagaiastreetband', 28.357122, -81.589667),
    ('1b15c77b-0311-4171-8e59-7f38e6d60754', 'Zootopia: Better Zoogether!', 'ATTRACTION', '412430582;entityType=Attraction', NULL, 28.357488, -81.590118),
    ('d8497541-53a2-4206-b95f-39cb238ae511', 'Tam Tam Drummers of Harambe', 'SHOW', '72877;entityType=Entertainment', 'tamtamdrummersofharambe', 28.35873, -81.591928),
    ('e7976e25-4322-4587-8ded-fb1d9dcbb83c', 'Gorilla Falls Exploration Trail', 'ATTRACTION', '80010175;entityType=Attraction', 'gorillafallsexplorationtrail', 28.359954, -81.592149),
    ('6ef1b126-5b0b-46a1-8608-4fcf98ab92c8', 'Wilderness Explorers', 'ATTRACTION', '17396838;entityType=Attraction', 'wildernessexplorers', 28.356682, -81.590292),
    ('7a5af3b7-9bc1-4962-92d0-3ea9c9ce35f0', 'Na''vi River Journey', 'ATTRACTION', '18665185;entityType=Attraction', 'naviriverjourney', 28.355257, -81.591641),
    ('859a02c9-5d54-49fa-a85c-0a6318d4986b', 'Zuri''s Sweet Shop', 'RESTAURANT', '19624454;entityType=restaurant', NULL, 28.359071, -81.591605),
    ('4d27b0d7-2b0a-4569-90fa-e79f117ec7ef', 'Discovery Island Trails', 'ATTRACTION', '80010126;entityType=Attraction', 'discoveryislandtrails', 28.3581032852655, -81.5911151562868),
    ('bc1ffa86-9b1a-4ce9-84a5-b479dfa3cb53', 'Tree of Life', 'ATTRACTION', '80010217;entityType=Attraction', 'treeoflife', 28.357994, -81.590597),
    ('1a8ea967-229a-42a0-8290-59b036c84e14', 'Maharajah Jungle Trek', 'ATTRACTION', '80010164;entityType=Attraction', 'maharajahjungletrek', 28.359379, -81.589019),
    ('24cf863c-b6ba-4826-a056-0b698989cbf7', 'Avatar Flight of Passage', 'ATTRACTION', '18665186;entityType=Attraction', 'avatarflightofpassage', 28.355554, -81.592147),
    ('32e01181-9a5f-4936-8a77-0dace1de836c', 'Kilimanjaro Safaris', 'ATTRACTION', '80010157;entityType=Attraction', 'kilimanjarosafaris', 28.359331, -81.59228),
    ('64a6915f-a835-4226-ba5c-8389fc4cade3', 'Expedition Everest - Legend of the Forbidden Mountain', 'ATTRACTION', '26068;entityType=Attraction', 'expeditioneverestlegendoftheforbiddenmountain', 28.3584769119, -81.5873781396),
    ('bc997600-fcc0-4f6f-b908-a1419b26cfd8', 'The Oasis Exhibits', 'ATTRACTION', '80010214;entityType=Attraction', 'theoasisexhibits', 28.355965, -81.59014),
    ('f526f3ab-190b-4576-8c79-e2968d171b4e', 'Meet Moana at Character Landing', 'SHOW', '411921961;entityType=Entertainment', NULL, 28.357086, -81.589374),
    ('95712b31-ceed-4f7d-be3e-3d5e6badac5c', 'Finding Nemo: The Big Blue... and Beyond!', 'SHOW', '411550125;entityType=Entertainment', NULL, 28.357401, -81.587455),
    ('665cc4c1-1bcd-4e5e-a44d-adb6a6889abc', 'Harambe Market', 'RESTAURANT', '18088970;entityType=restaurant', 'harambemarket', 28.359161, -81.591369),
    ('6730b8bb-f592-40cd-8e6f-e7788f3f175b', 'Flame Tree Barbecue', 'RESTAURANT', '90002524;entityType=restaurant', 'flametreebarbecue', 28.35734, -81.58954),
    ('7aa4f221-7b52-445e-bc27-f7baac4530ad', 'Satu''li Canteen', 'RESTAURANT', '18665138;entityType=restaurant', 'satulicanteen', 28.3560347386574, -81.5924408283262),
    ('93d3c183-737f-4e26-98f9-b18a3e190393', 'Animal Encounters: Winged Encounters – The Kingdom Takes Flight', 'SHOW', '17821434;entityType=Entertainment', 'animalencounterswingedencountersthekingdomtakesflight', 28.357339, -81.590462),
    ('d5dfc051-f951-40ac-8774-3e9961331ab9', 'Bluey''s Wild World at Conservation Station', 'ATTRACTION', '412862995;entityType=Attraction', NULL, 28.36533, -81.58872),
    ('a08d9f84-fbdf-45f3-9b68-645d296de307', 'DiVine', 'SHOW', '432709;entityType=Entertainment', NULL, 28.355795, -81.589863),
    ('52be1d78-e0b4-433f-b1ce-0be4f7053813', 'Beats and Strings', 'SHOW', '412226163;entityType=Entertainment', NULL, 28.358553, -81.590054),
    ('f7830bfd-3d25-4ba2-8021-b0d429ef0193', 'Eco-Rhythmics', 'SHOW', '412303521;entityType=Entertainment', NULL, 28.357002, -81.587678),
    ('dd142c0b-622a-4b44-8e22-c0facb2b20a8', 'Kora Tinga Tinga', 'SHOW', '18435910;entityType=Entertainment', 'koratingatinga', 28.35899, -81.591471),
    ('13d7c9d1-a785-403d-9ba8-71fee2f02d55', 'Meet Favorite Disney Pals at Adventurers Outpost', 'SHOW', '17421326;entityType=Entertainment', 'meetfavoritedisneypalsatadventurersoutpost', 28.357972, -81.589796),
    ('fdf62904-8125-4735-81ae-8648dd607399', 'Zoogether Day Gathering Spot', 'SHOW', '412499185;entityType=Entertainment', NULL, 28.357425, -81.590153),
    ('2a55aee6-c87a-4bda-a3d4-b022693a62a3', 'Tree of Life Awakenings', 'SHOW', '18447293;entityType=Entertainment', NULL, 28.357994, -81.590597),
    ('d8214ba6-22a7-4a92-8977-bae3779d5c4c', 'Feathered Friends in Flight!', 'SHOW', '19581372;entityType=Entertainment', 'featheredfriendsinflight', 28.358791, -81.590061),
    ('3a4e0f49-f9ff-4481-a95b-d4952cdf6097', 'Festival of the Lion King', 'SHOW', '12432;entityType=Entertainment', 'acelebrationoffestivalofthelionking', 28.35811, -81.592643),
    ('625821c3-5bd2-4c08-b449-257f3c81cbde', 'Pizzafari', 'RESTAURANT', '90002620;entityType=restaurant', 'pizzafari', 28.3572167558, -81.5912854671),
    ('f609fcf6-0aef-44ef-b838-f10ff3b8543b', 'Warung Outpost', 'RESTAURANT', '15921468;entityType=restaurant', 'warungoutpost', 28.35874, -81.590306),
    ('e12fb6d6-0985-44e5-bdd3-65ff74433063', 'Tiffins Restaurant', 'RESTAURANT', '18069632;entityType=restaurant', 'tiffinsrestaurant', 28.356846, -81.591487),
    ('cea213d9-bf4f-408a-ac61-768e7709ab7d', 'Yak & Yeti™ Restaurant', 'RESTAURANT', '215686;entityType=restaurant', 'yakyetirestaurant', 28.35859, -81.58958),
    ('84f51faa-72a3-4491-9449-20a999e5885c', 'Yak & Yeti™ Quality Beverages', 'RESTAURANT', '247503;entityType=restaurant', 'yakyetiqualitybeverages', 28.358803, -81.5893),
    ('224d803c-cd7a-45d8-bfab-d843f2030983', 'Rainforest Cafe® at Disney''s Animal Kingdom', 'RESTAURANT', '90002440;entityType=restaurant', 'rainforestcafeatdisneysanimalkingdom', 28.35478, -81.59039),
    ('88d5c6ad-fd4a-4c8b-8ed3-656e3ee3a4eb', 'Thirsty River Bar', 'RESTAURANT', '18076996;entityType=restaurant', 'thirstyriverbartreksnacks', 28.358551, -81.587646),
    ('1286aad3-bdbe-401b-99ef-4097477c556d', 'Dawa Bar', 'RESTAURANT', '90001443;entityType=restaurant', 'dawabar', 28.35854, -81.59198),
    ('91237556-7557-4b18-88a8-581254de96c6', 'Jumping Junction', 'ATTRACTION', '412606840;entityType=Attraction', NULL, 28.365346, -81.588852),
    ('b81bf8f4-3d43-47eb-8e27-9e6156112167', 'Adventures with Kevin on Discovery Island', 'SHOW', '19205476;entityType=Entertainment', NULL, 28.355542, -81.590079);

INSERT INTO activities (
    activity_name, activity_category_id, location_id, themeparks_id,
    source_external_id, entity_type, slug, latitude, longitude
)
SELECT
    i.activity_name,
    c.activity_category_id,
    l.location_id,
    i.themeparks_id,
    i.source_external_id,
    i.entity_type,
    i.slug,
    i.latitude,
    i.longitude
FROM animal_kingdom_import i
JOIN locations l
  ON l.location_name IN ('Disney''s Animal Kingdom Theme Park', 'Disney''s Animal Kingdom', 'Animal Kingdom')
JOIN activity_categories c
  ON c.category_name = CASE i.entity_type
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

-- Confirm actual database counts for this park.
SELECT a.entity_type, COUNT(*) AS activity_count
FROM activities a
JOIN locations l ON l.location_id = a.location_id
WHERE l.location_name IN ('Disney''s Animal Kingdom Theme Park', 'Disney''s Animal Kingdom', 'Animal Kingdom')
GROUP BY a.entity_type
ORDER BY a.entity_type;
