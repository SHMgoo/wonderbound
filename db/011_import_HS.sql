-- WonderBound 011_import_hollywood_studios.sql
-- Source: ThemeParks.wiki Hollywood Studios /children JSON supplied 2026-10-12.
-- 53 entries: 11 ATTRACTION, 20 RESTAURANT, 22 SHOW.
-- Rerunnable: matches existing activities by themeparks_id.

BEGIN;

DO $$
BEGIN
    IF (SELECT COUNT(*) FROM locations WHERE location_name = 'Disney''s Hollywood Studios') <> 1 THEN
        RAISE EXCEPTION 'Expected exactly one Disney''s Hollywood Studios row in locations';
    END IF;
    IF (SELECT COUNT(*) FROM activity_categories WHERE category_name IN ('Attractions','Dining','Entertainment')) <> 3 THEN
        RAISE EXCEPTION 'Expected activity categories Attractions, Dining, Entertainment';
    END IF;
END $$;

WITH source_data (themeparks_id, activity_name, entity_type, source_external_id, slug, latitude, longitude) AS (
    VALUES
    ('42328c39-76ab-4f03-b862-4206c8d9f7bb'::uuid, 'Fantasmic!', 'SHOW', '80010887;entityType=Entertainment', 'fantasmic', 28.3612252, -81.558233),
    ('c113b1cf-7b6d-416a-8e21-bf8f387ecd77'::uuid, 'Meet Ariel at Walt Disney Presents', 'SHOW', '411926516;entityType=Entertainment', NULL, 28.356945, -81.560998),
    ('f020b5e3-d26d-4339-83f9-0f1f858a0e40'::uuid, 'Oga''s Cantina', 'RESTAURANT', '19267226;entityType=restaurant', 'ogascantinaatthewaltdisneyworldresort', 28.354095, -81.562075),
    ('399aa0a1-98e2-4d2b-b297-2b451e9665e1'::uuid, 'Slinky Dog Dash', 'ATTRACTION', '18904138;entityType=Attraction', 'slinkydogdash', 28.356245, -81.562786),
    ('d56506e2-6ad3-443a-8065-fea37987248d'::uuid, 'Alien Swirling Saucers', 'ATTRACTION', '18904172;entityType=Attraction', 'alienswirlingsaucers', 28.355385, -81.562379),
    ('6e118e37-5002-408d-9d88-0b5d9cdb5d14'::uuid, 'Mickey & Minnie''s Runaway Railway', 'ATTRACTION', '19259335;entityType=Attraction', 'mickeyminniesrunawayrailway', 28.3566783801, -81.5605667783),
    ('1a2e70d9-50d5-4140-b69e-799e950f7d18'::uuid, 'Star Wars: Rise of the Resistance', 'ATTRACTION', '19263736;entityType=Attraction', 'starwarsriseoftheresistance', 28.354884, -81.560457),
    ('3b290419-8ca2-44bc-a710-a6c83fca76ec'::uuid, 'Star Tours – The Adventures Continue', 'ATTRACTION', '80010193;entityType=Attraction', 'startourstheadventurescontinue', 28.355695, -81.558891),
    ('07fc0229-4e50-419a-ba10-0ce07cc54a53'::uuid, 'BaseLine Tap House', 'RESTAURANT', '18744584;entityType=restaurant', 'baselinetaphouse', 28.355696, -81.559565),
    ('1ae86482-6627-4229-814d-0f1ccebb20d4'::uuid, 'ABC Commissary', 'RESTAURANT', '90001220;entityType=restaurant', 'abccommissary', 28.356062, -81.559872),
    ('4ea1129c-749c-4be8-a0f9-9700740213fc'::uuid, 'Ronto Roasters', 'RESTAURANT', '19296378;entityType=restaurant', 'rontoroasters', 28.354341, -81.561652),
    ('a595b641-4472-4d2b-92b5-5a0e31785193'::uuid, 'Catalina Eddie''s', 'RESTAURANT', '90001365;entityType=restaurant', 'catalinaeddies', 28.358915, -81.560278),
    ('904887b2-82b5-426c-b2b0-0b5d6977ff94'::uuid, 'Fairfax Fare', 'RESTAURANT', '90001531;entityType=restaurant', 'fairfaxfare', 28.3590392579, -81.5600222899),
    ('0beccd84-7a6d-454a-94d3-c8a3265e7e8d'::uuid, 'Tune-In Lounge', 'RESTAURANT', '90002300;entityType=restaurant', 'tuneinlounge', 28.357482, -81.558808),
    ('a8804f66-ed5c-4daa-99a1-bcddd2f1fca6'::uuid, 'Rosie''s All-American Café', 'RESTAURANT', '90002090;entityType=restaurant', 'rosiesallamericancaf', 28.358821, -81.560268),
    ('d9dbd260-9e34-406d-abb7-19f9d733e577'::uuid, 'Sci-Fi Dine-In Theater Restaurant', 'RESTAURANT', '90002114;entityType=restaurant', 'scifidineintheaterrestaurant', 28.3559, -81.559495),
    ('27f9fc86-2341-4bf4-8cbf-67fc16a841f1'::uuid, 'Meet Olaf at Celebrity Spotlight', 'SHOW', '18368385;entityType=Entertainment', 'celebrityspotlight', 28.356072, -81.559158),
    ('d91a0e9a-8652-4036-822f-e7b12b381273'::uuid, 'For the First Time in Forever: A Frozen Sing-Along Celebration', 'SHOW', '17842841;entityType=Entertainment', 'forthefirsttimeinforeverafrozensingalongcelebration', 28.3568243, -81.559694),
    ('847ab726-3672-42fd-a232-df7a3fb2baf7'::uuid, 'The Record Setters', 'SHOW', '412496812;entityType=Entertainment', NULL, 28.357555, -81.560658),
    ('34c4916b-989b-4ff1-a7e3-a6a846a3484f'::uuid, 'Millennium Falcon: Smugglers Run', 'ATTRACTION', '19263735;entityType=Attraction', 'millenniumfalconsmugglersrun', 28.353889, -81.561689),
    ('6f6998e8-a629-412c-b964-2cb06af8e26b'::uuid, 'The Twilight Zone™ Tower of Terror', 'ATTRACTION', '80010218;entityType=Attraction', 'thetwilightzonetowerofterror', 28.359553, -81.559772),
    ('d7669edc-eaa1-4af2-bbb5-6e98df564166'::uuid, 'Walt Disney Presents', 'ATTRACTION', '18770880;entityType=Attraction', 'waltdisneypresents', 28.35686, -81.560982),
    ('9211adc9-b296-4667-8e97-b40cf76108e4'::uuid, 'Vacation Fun - An Original Animated Short with Mickey & Minnie', 'ATTRACTION', '19497952;entityType=Attraction', 'vacationfunanoriginalanimatedshortwithmickeyminnie', 28.356316, -81.559031),
    ('20b5daa8-e1ea-436f-830c-2d7d18d929b5'::uuid, 'Toy Story Mania!', 'ATTRACTION', '209857;entityType=Attraction', 'toystorymania', 28.356404, -81.561894),
    ('02861a9b-584d-47d5-a8d0-98e05c3b5dce'::uuid, 'Meet Disney Stars at Red Carpet Dreams', 'SHOW', '18368386;entityType=Entertainment', 'mickeyandminniestarringinredcarpetdreams', 28.356068, -81.559479),
    ('bc2c2ffe-3cf0-4e75-a408-bf5e86515c4c'::uuid, 'Green Army Drum Corps', 'SHOW', '19025720;entityType=Entertainment', 'greenarmydrumcorps', 28.355815, -81.562344),
    ('83edcec8-7ff2-495e-9f61-fe596aa92447'::uuid, 'Backlot Express', 'RESTAURANT', '90001260;entityType=restaurant', 'backlotexpress', 28.35589, -81.558388),
    ('e2e6cccf-acf4-48f4-bbfb-47b712714583'::uuid, 'Dockside Diner', 'RESTAURANT', '90001951;entityType=restaurant', 'docksidediner', 28.3570985, -81.559552),
    ('6a696644-26ba-496e-8e2b-efbaad615785'::uuid, 'Milk Stand', 'RESTAURANT', '19267228;entityType=restaurant', 'milkstand', 28.354311, -81.562296),
    ('30070790-e166-4135-b7ce-d89da20a7b95'::uuid, 'Meet Disney Jr. Stars on Commissary Lane', 'SHOW', '412636198;entityType=Entertainment', NULL, 28.3561823, -81.55973),
    ('1bbce25c-36eb-4d16-9216-4a1bbd46932b'::uuid, 'Disney Jr. Mickey Mouse Clubhouse Live!', 'SHOW', '412521565;entityType=Entertainment', NULL, 28.35792, -81.56073),
    ('eea07a8d-30e0-42d8-9c47-58cc038801e8'::uuid, 'Meet the Toys in Toy Story Land', 'SHOW', '19205060;entityType=Entertainment', NULL, 28.356184, -81.56207),
    ('a7763ca6-bca3-4e78-b75c-22886aa06bec'::uuid, 'The Little Mermaid – A Musical Adventure', 'SHOW', '412328858;entityType=Entertainment', NULL, 28.3574862, -81.560848),
    ('90ab2c64-e05c-4783-bde5-fddf41f78402'::uuid, 'Disney Movie Magic', 'SHOW', '18693119;entityType=Entertainment', 'disneymoviemagic', 28.356965, -81.560425),
    ('69cb35f2-c58e-4b44-88c9-ea0cc720e075'::uuid, 'Disney Villains: Unfairly Ever After', 'SHOW', '412328859;entityType=Entertainment', NULL, 28.359869, -81.560947),
    ('0e7426d1-7406-4e7c-9da6-ac6c126211c6'::uuid, 'Meet Joy at Pixar Plaza', 'SHOW', '411908664;entityType=Entertainment', NULL, 28.356374, -81.560839),
    ('79860074-658f-49bc-8c1b-624af8b4718e'::uuid, 'Meet Edna Mode at the Edna Mode Experience', 'SHOW', '19205017;entityType=Entertainment', NULL, 28.356086, -81.560742),
    ('eb325677-d32a-41ec-b2c9-e1ab91bade02'::uuid, 'Meet Pixar Pals at Pixar Plaza', 'SHOW', '411927635;entityType=Entertainment', NULL, 28.3563769305406, -81.5609562845992),
    ('343de9f4-e100-4a52-9285-0fcc3a486603'::uuid, 'First Order Searches for the Resistance', 'SHOW', '411979428;entityType=Entertainment', NULL, 28.354335, -81.562562),
    ('e516f303-e82d-4fd3-8fbf-8e6ab624cf89'::uuid, 'Rock ’n’ Roller Coaster Starring The Muppets', 'ATTRACTION', '412573652;entityType=Attraction', 'rocknrollercoasterstarringaerosmith', 28.359712, -81.56059),
    ('375197ac-27ac-41f7-bd93-f4e9b9fc4d5d'::uuid, 'Beauty and the Beast – Live on Stage', 'SHOW', '80010848;entityType=Entertainment', 'beautyandthebeastliveonstage', 28.3589163, -81.559599),
    ('b1ed574f-40f2-4132-a1ee-893a276633c8'::uuid, 'Wonderful World of Animation', 'SHOW', '19260580;entityType=Entertainment', 'wonderfulworldofanimation', 28.356965, -81.560425),
    ('7357772c-6b11-4a8d-af97-05a1bb45f001'::uuid, 'Indiana Jones™ Epic Stunt Spectacular!', 'SHOW', '136;entityType=Entertainment', NULL, 28.3566701, -81.558611),
    ('d07a17c2-7720-4db7-b12a-a68ecdb51108'::uuid, 'Hollygroove Swingin’', 'SHOW', '412496861;entityType=Entertainment', NULL, 28.357555, -81.560658),
    ('7a73a6df-4d33-4648-b3e3-57985f84f0ae'::uuid, 'Roundup Rodeo BBQ', 'RESTAURANT', '19553134;entityType=restaurant', NULL, 28.356832, -81.56201),
    ('c600282c-227b-4ffc-b1ee-b5987609ee4f'::uuid, '50''s Prime Time Café', 'RESTAURANT', '90001216;entityType=restaurant', '50sprimetimecaf', 28.357444, -81.558881),
    ('d2af9650-9f91-45ef-98be-de44b4b44c32'::uuid, 'The Hollywood Brown Derby Lounge', 'RESTAURANT', '17571157;entityType=restaurant', 'thehollywoodbrownderbylounge', 28.3576436192, -81.5601785481),
    ('451855cc-d19e-40c3-838a-33c8fefe4af8'::uuid, 'Docking Bay 7 Food and Cargo', 'RESTAURANT', '19267227;entityType=restaurant', 'dockingbay7foodandcargo', 28.354088, -81.561643),
    ('7bf05bdc-8279-427b-8a6d-50fc62ef31cb'::uuid, 'Hollywood & Vine', 'RESTAURANT', '90001744;entityType=restaurant', 'hollywoodvine', 28.357611, -81.558975),
    ('917783a5-da9c-4c55-ac51-0ac1f8253131'::uuid, 'The Hollywood Brown Derby', 'RESTAURANT', '90002245;entityType=restaurant', 'thehollywoodbrownderby', 28.357648, -81.560297),
    ('07b8c193-a185-4559-a403-4d950c3b386d'::uuid, 'Woody''s Lunch Box', 'RESTAURANT', '18904173;entityType=restaurant', 'woodyslunchbox', 28.355747, -81.562185),
    ('43891eb1-27bb-429e-b6b9-430b54f57858'::uuid, 'Kat Saka''s Kettle', 'RESTAURANT', '19296379;entityType=restaurant', 'katsakaskettle', 28.35432, -81.561467),
    ('3c5d2f71-0c09-43d9-9c56-44544800853b'::uuid, 'Meet Cruz and DJ in Cars Courtyard', 'SHOW', '18693117;entityType=Entertainment', NULL, 28.35992, -81.56077)
), mapped AS (
    SELECT s.themeparks_id, s.activity_name, c.activity_category_id,
           l.location_id, s.source_external_id, s.entity_type, s.slug,
           s.latitude::double precision AS latitude,
           s.longitude::double precision AS longitude
    FROM source_data s
    JOIN locations l ON l.location_name = 'Disney''s Hollywood Studios'
    JOIN activity_categories c ON c.category_name = CASE s.entity_type
        WHEN 'ATTRACTION' THEN 'Attractions'
        WHEN 'RESTAURANT' THEN 'Dining'
        WHEN 'SHOW' THEN 'Entertainment'
    END
)
INSERT INTO activities (
    themeparks_id, activity_name, activity_category_id, location_id,
    source_external_id, entity_type, slug, latitude, longitude
)
SELECT themeparks_id, activity_name, activity_category_id, location_id,
       source_external_id, entity_type, slug, latitude, longitude
FROM mapped
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

SELECT entity_type, COUNT(*) AS activity_count
FROM activities
WHERE location_id = (
    SELECT location_id FROM locations
    WHERE location_name = 'Disney''s Hollywood Studios'
)
GROUP BY entity_type
ORDER BY entity_type;
