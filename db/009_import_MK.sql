-- ============================================================
-- WonderBound
-- 009_import_magic_kingdom.sql
-- Import 88 Magic Kingdom activities from ThemeParks.wiki
-- Source: user-provided Magic Kingdom /children API response
-- ============================================================
-- Run this entire file in pgAdmin against the WonderBound database.
-- Safe to rerun: existing themeparks_id records are not duplicated.

BEGIN;

CREATE TEMP TABLE mk_import_stage (
    themeparks_id UUID PRIMARY KEY,
    activity_name VARCHAR(255) NOT NULL,
    entity_type VARCHAR(50) NOT NULL,
    source_external_id VARCHAR(100),
    slug VARCHAR(255),
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION
) ON COMMIT DROP;

INSERT INTO mk_import_stage
    (themeparks_id, activity_name, entity_type, source_external_id,
     slug, latitude, longitude)
VALUES
    ('92524eb7-4ee5-4eab-936c-2eb8e6eb0ecd'::uuid, 'The Cadaver Dans Barbershop Quartet at Mickey''s Not-So-Scary Halloween Party', 'SHOW', '17506082;entityType=Entertainment', NULL, 28.418951, -81.583354),
    ('52ac3730-b955-452a-a7cc-17e3b06182ac'::uuid, 'Trick-or-Treat Locations at Mickey''s Not-So-Scary Halloween Party', 'ATTRACTION', '17511582;entityType=Attraction', NULL, 28.420965290619, -81.5784311924997),
    ('05ca3e51-580b-44ca-8046-7d3e57a6d248'::uuid, 'Disney’s Not-So-Spooky Spectacular at Mickey''s Not-So-Scary Halloween Party', 'SHOW', '61265;entityType=Entertainment', NULL, 28.419507, -81.581177),
    ('9221e600-6715-4b4f-b39a-00c318c00e03'::uuid, 'Destination DescenDANCE Party at Mickey’s Not-So-Scary Halloween Party', 'SHOW', '19363777;entityType=Entertainment', NULL, 28.418309, -81.5785519),
    ('924a3b2c-6b4b-49e5-99d3-e9dc3f2e8a48'::uuid, 'The Barnstormer', 'ATTRACTION', '16491297;entityType=Attraction', 'thebarnstormer', 28.4207661576, -81.5783907473),
    ('e40ac396-cbac-43f4-8752-764ed60ccceb'::uuid, 'Walt Disney World Railroad - Fantasyland', 'ATTRACTION', '16491299;entityType=Attraction', 'waltdisneyworldrailroadfantasyland', 28.420934, -81.578368),
    ('9d4d5229-7142-44b6-b4fb-528920969a2c'::uuid, 'Seven Dwarfs Mine Train', 'ATTRACTION', '16767284;entityType=Attraction', 'sevendwarfsminetrain', 28.42037, -81.58031),
    ('de737ffc-306b-4f32-8bbb-34e5d370ec8f'::uuid, 'A Pirate''s Adventure ~ Treasures of the Seven Seas', 'ATTRACTION', '17272158;entityType=Attraction', 'apiratesadventuretreasuresofthesevenseas', 28.4183725, -81.584669),
    ('e76c93df-31af-49a5-8e2f-752c76c937c9'::uuid, 'Enchanted Tales with Belle', 'ATTRACTION', '16767276;entityType=Attraction', 'enchantedtaleswithbelle', 28.4209906, -81.58093),
    ('de3309ca-97d5-4211-bffe-739fed47e92f'::uuid, 'Big Thunder Mountain Railroad', 'ATTRACTION', '80010110;entityType=Attraction', 'bigthundermountainrailroad', 28.4199638504, -81.5846422864),
    ('f5aad2d4-a419-4384-bd9a-42f86385c750'::uuid, 'it''s a small world', 'ATTRACTION', '80010149;entityType=Attraction', 'itsasmallworld', 28.4204816402, -81.5820392026),
    ('890fa430-89c0-4a3f-96c9-11597888005e'::uuid, 'Dumbo the Flying Elephant', 'ATTRACTION', '80010129;entityType=Attraction', 'dumbotheflyingelephant', 28.420509033, -81.5789473057),
    ('30fe3c64-af71-4c66-a54b-aa61fd7af177'::uuid, 'Swiss Family Treehouse', 'ATTRACTION', '80010196;entityType=Attraction', 'swissfamilytreehouse', 28.4184325517, -81.5827982677),
    ('86a41273-5f15-4b54-93b6-829f140e5161'::uuid, 'Peter Pan''s Flight', 'ATTRACTION', '80010176;entityType=Attraction', 'peterpansflight', 28.4202640272, -81.5818916811),
    ('96455de6-f4f1-403c-9391-bf8396979149'::uuid, 'The Magic Carpets of Aladdin', 'ATTRACTION', '80010210;entityType=Attraction', 'themagiccarpetsofaladdin', 28.41843, -81.583472),
    ('0f57cecf-5502-4503-8bc3-ba84d3708ace'::uuid, 'Country Bear Musical Jamboree', 'ATTRACTION', '80069748;entityType=Attraction', 'countrybearjamboree', 28.4187861348, -81.5837222887),
    ('4c1ccb9e-ff1d-40b6-9454-72c261dd8b00'::uuid, 'The Friar''s Nook', 'RESTAURANT', '114690;entityType=restaurant', 'thefriarsnook', 28.42016512, -81.5807196587),
    ('e847a8bd-7d21-432b-a7a1-f483517a22b5'::uuid, 'Be Our Guest Restaurant', 'RESTAURANT', '16660079;entityType=restaurant', 'beourguestrestaurant', 28.4212491492, -81.5807074858),
    ('ae9a4a79-ccf1-4561-9a95-cf83d3007b98'::uuid, 'Liberty Tree Tavern', 'RESTAURANT', '90001819;entityType=restaurant', 'libertytreetavern', 28.4191196055, -81.5826159743),
    ('55bdcccc-217b-416c-b8b0-4b6a87d16179'::uuid, 'Cinderella''s Royal Table', 'RESTAURANT', '90002464;entityType=restaurant', 'cinderellasroyaltable', 28.4195, -81.581101),
    ('4bbaa21d-4203-494a-a120-b780dc7570ec'::uuid, 'Pinocchio Village Haus', 'RESTAURANT', '90002618;entityType=restaurant', 'pinocchiovillagehaus', 28.42041, -81.58143),
    ('c4b64a31-e855-46a9-9d1a-aa13c99e88af'::uuid, 'The Crystal Palace', 'RESTAURANT', '90002660;entityType=restaurant', 'thecrystalpalace', 28.4181214892, -81.5818970259),
    ('a5098eb1-a673-47c2-b782-5c48bb83da17'::uuid, 'Sunshine Tree Terrace', 'RESTAURANT', '90002656;entityType=restaurant', 'sunshinetreeterrace', 28.418434, -81.582512),
    ('83201c33-ce99-45ae-a595-f47e61d73739'::uuid, 'Tony''s Town Square Restaurant', 'RESTAURANT', '90002678;entityType=restaurant', 'tonystownsquarerestaurant', 28.4169323426, -81.5807276023),
    ('166f2985-7b27-4eff-a8b3-29c3448ba198'::uuid, 'Meet Daring Disney Pals as Circus Stars at Pete''s Silly Sideshow', 'SHOW', '387133;entityType=Entertainment', 'meetdaringdisneypalsascircusstarsatpetessillysideshow', 28.421282, -81.578932),
    ('1eee22e8-1d0a-4809-a42b-df3ae55c69d5'::uuid, 'The Dapper Dans', 'SHOW', '8075;entityType=Entertainment', 'thedapperdans', 28.4174102, -81.581217),
    ('a0613b70-293f-4a5b-8169-357be1777c62'::uuid, 'Casey''s Corner Pianist', 'SHOW', '8074;entityType=Entertainment', 'caseyscornerpianist', 28.418112, -81.581421),
    ('82483712-0603-4c67-8560-8a7364777940'::uuid, 'Astrofizz', 'RESTAURANT', '90002468;entityType=restaurant', 'coolship', 28.41876, -81.578851),
    ('012a211b-4c91-451c-8a0e-5e3ab398eda8'::uuid, 'Meet Ariel at Her Grotto', 'SHOW', '16874126;entityType=Entertainment', 'meetarielathergrotto', 28.4208933, -81.579613),
    ('72c7343a-f7fb-4f66-95df-c91016de7338'::uuid, 'Buzz Lightyear’s Space Ranger Spin', 'ATTRACTION', '80010114;entityType=Attraction', 'buzzlightyearsspacerangerspin', 28.4182868839, -81.5794086456),
    ('6fd1e225-53a0-4a80-a577-4bbc9a471075'::uuid, 'Walt Disney''s Enchanted Tiki Room', 'ATTRACTION', '16124144;entityType=Attraction', 'waltdisneysenchantedtikiroom', 28.4182264646, -81.583738382),
    ('f010bc01-b450-4476-a5f3-a5f2813104b2'::uuid, 'Casey Jr. Splash ''N'' Soak Station', 'ATTRACTION', '16512939;entityType=Attraction', 'caseyjrsplashnsoakstation', 28.4209221723, -81.5786757124),
    ('f163ddcd-43e1-488d-8276-2381c1db0a39'::uuid, 'Tomorrowland Speedway', 'ATTRACTION', '80010222;entityType=Attraction', 'tomorrowlandspeedway', 28.419368, -81.579302),
    ('273ddb8d-e7b5-4e34-8657-1113f49262a5'::uuid, 'Prince Charming Regal Carrousel', 'ATTRACTION', '80010117;entityType=Attraction', 'princecharmingregalcarrousel', 28.420169, -81.581255),
    ('0aae716c-af13-4439-b638-d75fb1649df3'::uuid, 'Mad Tea Party', 'ATTRACTION', '80010162;entityType=Attraction', 'madteaparty', 28.4200230397, -81.5798248916),
    ('e39b831b-7731-49bb-815b-289b4f49a9fd'::uuid, 'Walt Disney World Railroad - Main Street, U.S.A.', 'ATTRACTION', '80010230;entityType=Attraction', 'waltdisneyworldrailroadmainstreetusa', 28.416543, -81.581204),
    ('b2260923-9315-40fd-9c6b-44dd811dbe64'::uuid, 'Space Mountain', 'ATTRACTION', '80010190;entityType=Attraction', 'spacemountain', 28.4188341691, -81.5781962872),
    ('819fd147-3f17-420a-9188-2ba4c544d761'::uuid, 'Main Street Confectionery', 'RESTAURANT', '19624449;entityType=restaurant', NULL, 28.417116, -81.581023),
    ('8183f3f2-1b59-4b9c-b634-6a863bdf8d84'::uuid, 'Walt Disney''s Carousel of Progress', 'ATTRACTION', '80010232;entityType=Attraction', 'waltdisneyscarouselofprogress', 28.4180310951, -81.5790083064),
    ('7c5e1e02-3a44-4151-9005-44066d5ba1da'::uuid, 'Mickey''s PhilharMagic', 'ATTRACTION', '80010170;entityType=Attraction', 'mickeysphilharmagic', 28.4200304909, -81.5814839853),
    ('ffcfeaa2-1416-4920-a1ed-543c1a1695c4'::uuid, 'Tomorrowland Transit Authority PeopleMover', 'ATTRACTION', '80010224;entityType=Attraction', 'tomorrowlandtransitauthoritypeoplemover', 28.418155, -81.579033),
    ('e8f0b426-7645-4ea3-8b41-b94ae7091a41'::uuid, 'Monsters, Inc. Laugh Floor', 'ATTRACTION', '136550;entityType=Attraction', 'monstersinclaughfloor', 28.4183977566, -81.5797358751),
    ('2ebfb38c-5cb5-4de1-86c0-f7af14188022'::uuid, 'The Hall of Presidents', 'ATTRACTION', '80069754;entityType=Attraction', 'thehallofpresidents', 28.4194484171, -81.5823248578),
    ('888fb4a4-7adf-47a1-8ba2-c258cc64fd75'::uuid, 'Main Street Vehicles', 'ATTRACTION', '80010165;entityType=Attraction', 'mainstreetvehicles', 28.4168698711, -81.5815081252),
    ('d9d12438-d999-4482-894b-8955fdb20ccf'::uuid, 'Astro Orbiter', 'ATTRACTION', '80010107;entityType=Attraction', 'astroorbiter', 28.4184926179, -81.5789887902),
    ('40737d3d-0ff6-4a9e-a050-beb87bf90120'::uuid, 'Meet Cinderella and a Visiting Princess at Princess Fairytale Hall', 'SHOW', '18498503;entityType=Entertainment', 'meetcinderellaandelenaatprincessfairytalehall', 28.420071, -81.580893),
    ('5a43d1a7-ad53-4d25-abfe-25625f0da304'::uuid, 'TRON Lightcycle / Run', 'ATTRACTION', '411504498;entityType=Attraction', NULL, 28.419625, -81.577985),
    ('73cb9445-0695-47a3-87ce-d08ae36b5f3c'::uuid, 'Tiana''s Bayou Adventure', 'ATTRACTION', '412021364;entityType=Attraction', NULL, 28.419418, -81.58498),
    ('90d79335-c907-4069-a021-d0fe1ec73ae2'::uuid, 'Cinderella Castle', 'ATTRACTION', '16767209;entityType=Attraction', 'cinderellacastle', 28.4194549043, -81.5811809),
    ('2551a77d-023f-4ab1-9a19-8afec0190f39'::uuid, 'Haunted Mansion', 'ATTRACTION', '80010208;entityType=Attraction', 'hauntedmansion', 28.4202, -81.58288),
    ('b5d6d1d1-e960-4c8f-a8a4-b9748b386b64'::uuid, 'Meet Dashing Disney Pals as Circus Stars at Pete''s Silly Sideshow', 'SHOW', '15743682;entityType=Entertainment', 'meetdashingdisneypalsascircusstarsatpetessillysideshow', 28.421282, -81.578932),
    ('4c31b3ad-5dc9-437f-ac1a-0fdff36a2818'::uuid, 'Mickey''s Magical Friendship Faire', 'SHOW', '18381020;entityType=Entertainment', NULL, 28.419169, -81.581204),
    ('cf4b2ba4-3626-4de7-9d07-abe8a65b1665'::uuid, 'Meet Princess Tiana and a Visiting Princess at Princess Fairytale Hall', 'SHOW', '17505397;entityType=Entertainment', 'meetrapunzelandtianaatprincessfairytalehall', 28.4200458, -81.580917),
    ('5af2c3a9-7697-414f-9642-6cb17a329613'::uuid, 'Columbia Harbour House', 'RESTAURANT', '90001399;entityType=restaurant', 'columbiaharbourhouse', 28.4200310807, -81.5825126124),
    ('48d0c81e-3f47-4ff9-aa3c-331cb83a0af9'::uuid, 'Casey''s Corner', 'RESTAURANT', '90002458;entityType=restaurant', 'caseyscorner', 28.418112, -81.581281),
    ('8073763e-19ee-4506-a823-a902e8e7f3b9'::uuid, 'Tortuga Tavern', 'RESTAURANT', '90001473;entityType=restaurant', 'tortugatavern', 28.418324, -81.584282),
    ('5135ff2e-2f42-4138-bc30-706eb25963e4'::uuid, 'Cosmic Ray''s Starlight Café', 'RESTAURANT', '90002470;entityType=restaurant', 'cosmicraysstarlightcaf', 28.419477, -81.579873),
    ('1c708beb-41e1-43ae-8dd8-1e85075aeb38'::uuid, 'Flag Retreat', 'SHOW', '7922;entityType=Entertainment', 'flagretreat', 28.416856, -81.581195),
    ('0d94ad60-72f0-4551-83a6-ebaecdd89737'::uuid, 'The Many Adventures of Winnie the Pooh', 'ATTRACTION', '80010213;entityType=Attraction', 'themanyadventuresofwinniethepooh', 28.420212, -81.580266),
    ('ee56b2f3-fd49-4a29-ae1a-2d321549a633'::uuid, 'Disney Festival of Fantasy Parade', 'SHOW', '17718925;entityType=Entertainment', 'disneyfestivaloffantasyparade', 28.4189533, -81.583787),
    ('352feb94-e52e-45eb-9c92-e4b44c6b1a9d'::uuid, 'Pirates of the Caribbean', 'ATTRACTION', '80010177;entityType=Attraction', 'piratesofthecaribbean', 28.4179699235, -81.5842252029),
    ('646a3063-dc41-4671-bc0a-0958b95fb553'::uuid, 'The Beak and Barrel', 'RESTAURANT', '412358722;entityType=restaurant', NULL, 28.4181, -81.58435),
    ('796b0a25-c51e-456e-9bb8-50a324e301b3'::uuid, 'Jungle Cruise', 'ATTRACTION', '80010153;entityType=Attraction', 'junglecruise', 28.41797818, -81.5834393157),
    ('3cba0cb4-e2a6-402c-93ee-c11ffcb127ef'::uuid, 'Under the Sea - Journey of The Little Mermaid', 'ATTRACTION', '16767263;entityType=Attraction', 'undertheseajourneyofthelittlemermaid', 28.4211203226, -81.5799752427),
    ('d69261dc-62b8-434c-83bd-93649b43c408'::uuid, 'Disney Starlight: Dream the Night Away', 'SHOW', '412328853;entityType=Entertainment', NULL, 28.4168649, -81.581193),
    ('51392ca4-f824-42d8-8808-8110ec8e0e22'::uuid, 'Main Street Philharmonic at Main Street, U.S.A.', 'SHOW', '8066;entityType=Entertainment', 'mainstreetphilharmonicatmainstreetusa', 28.4185407873192, -81.5813068741155),
    ('e0cd6a94-6dbe-4f52-aaa8-b3d2fdf5f2f6'::uuid, 'Jessie’s Roundup: A Rip-Roarin’ Revue!', 'SHOW', '412577081;entityType=Entertainment', NULL, 28.4189329813, -81.5829262845),
    ('86c198b0-7c02-4354-814a-27ad70067d45'::uuid, 'Disney Enchantment at Disney After Hours at Magic Kingdom', 'SHOW', '412040920;entityType=Entertainment', NULL, 28.419507, -81.581177),
    ('22b78ed9-a692-47cb-b6a4-6d1224ff67e3'::uuid, 'Happily Ever After', 'SHOW', '18672598;entityType=Entertainment', 'happilyeverafter', 28.419169, -81.581204),
    ('f819079e-644e-4fce-bda3-26b899ac7027'::uuid, 'Disney Adventure Friends Cavalcade', 'SHOW', '411550122;entityType=Entertainment', NULL, 28.4168649, -81.581193),
    ('a2d92647-634d-4eb4-886b-9da858e871f1'::uuid, 'Meet Mickey at Town Square Theater', 'SHOW', '15850196;entityType=Entertainment', NULL, 28.416727, -81.580746),
    ('1b9a6231-b658-470f-92cc-808925280214'::uuid, 'The Lunching Pad', 'RESTAURANT', '90002664;entityType=restaurant', 'thelunchingpad', 28.4184189875, -81.5792530775),
    ('6ea670b8-3097-4d60-b69c-94e16071da17'::uuid, 'Jungle Navigation Co. LTD Skipper Canteen', 'RESTAURANT', '18185631;entityType=restaurant', 'junglenavigationcoltdskippercanteen', 28.418491, -81.582592),
    ('697473c5-ae17-4c3f-80c7-09a813248013'::uuid, 'The Diamond Horseshoe', 'RESTAURANT', '247904;entityType=restaurant', 'thediamondhorseshoe', 28.4189329813, -81.5829262845),
    ('5f42b43a-e745-487b-9545-dd601f6984ce'::uuid, 'Sleepy Hollow', 'RESTAURANT', '90002140;entityType=restaurant', 'sleepyhollow', 28.4192798, -81.5820112),
    ('75d43698-162c-47af-a607-e879637dc8e7'::uuid, 'The Plaza Restaurant', 'RESTAURANT', '90002670;entityType=restaurant', 'theplazarestaurant', 28.4180247703, -81.5809394969),
    ('be2c6511-750b-4fa6-8332-606d4342f814'::uuid, 'Golden Oak Outpost', 'RESTAURANT', '90002530;entityType=restaurant', 'goldenoakoutpost', 28.4186023132, -81.584727253),
    ('ab1b9ce7-aada-4b47-9fa0-1b178203d02b'::uuid, 'Pecos Bill Tall Tale Inn and Cafe', 'RESTAURANT', '90002610;entityType=restaurant', 'pecosbilltalltaleinnandcafe', 28.4188897676, -81.5844008876),
    ('a74421f2-5de4-4425-bd06-8b4639b29826'::uuid, 'Meet Festive Disney Pals at Mickey’s Not-So-Scary Halloween Party', 'SHOW', '411980018;entityType=Entertainment', NULL, 28.421297, -81.578933),
    ('5c00cd7c-b207-4d9d-9c8c-a8d418fc5425'::uuid, 'Mickey’s Boo-To-You Halloween Parade at Mickey''s Not-So-Scary Halloween Party', 'SHOW', '8317;entityType=Entertainment', NULL, 28.4168668, -81.5812),
    ('6d74b3d9-f977-4c9b-8114-93969b51b105'::uuid, 'Hocus Pocus Villain Spelltacular', 'SHOW', '18161751;entityType=Entertainment', NULL, 28.419169, -81.581204),
    ('5564113f-25b4-4646-ac35-aacf983e2fd6'::uuid, 'Meet Mickey Mouse and Minnie Mouse at Mickey''s Not-So-Scary Halloween Party', 'SHOW', '411776692;entityType=Entertainment', NULL, 28.416727, -81.580746),
    ('947edbee-85a5-4aa0-99f3-14c7de539542'::uuid, 'Meet Jack Skellington and Sally at Mickey''s Not-So-Scary Halloween Party', 'SHOW', '17912526;entityType=Entertainment', NULL, 28.416808, -81.580815),
    ('9140033d-d746-464b-acad-f05f9357f0bd'::uuid, 'Character Greetings at Mickey''s Not-So-Scary Halloween Party', 'SHOW', '17515888;entityType=Entertainment', NULL, 28.416808, -81.580815),
    ('97c837c3-4a0f-4d52-b93c-074cf31d6f41'::uuid, 'Stitch’s Masquerade Mashup at Mickey’s Not-So-Scary Halloween Party', 'SHOW', '412734988;entityType=Entertainment', NULL, 28.41828, -81.57864),
    ('c1f39c15-7845-46b5-b6fd-2ae368a32a37'::uuid, 'Captain Jack’s Buccaneer Bash at Mickey’s Not-So-Scary Halloween Party', 'SHOW', '412734987;entityType=Entertainment', NULL, 28.418256, -81.584366),
    ('62eac07c-fa2d-45ab-a6e6-d8aa0054540d'::uuid, 'Energy Bytes', 'RESTAURANT', '411901863;entityType=restaurant', NULL, 28.419633, -81.578227),
    ('362aa1ba-b1a2-4617-a97c-5a6805f32417'::uuid, 'Allergy Request Trick-or-Treating Experience at Mickey''s Not-So-Scary Halloween Party', 'ATTRACTION', '17511485;entityType=Attraction', NULL, 28.41869, -81.579365);

-- Validate reference records before importing anything.
DO $$
DECLARE
    v_location_count INTEGER;
    v_category_count INTEGER;
    v_stage_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_location_count
    FROM locations
    WHERE location_name IN ('Magic Kingdom', 'Magic Kingdom Park');

    IF v_location_count <> 1 THEN
        RAISE EXCEPTION 'Expected one Magic Kingdom Park in locations, found %', v_location_count;
    END IF;

    SELECT COUNT(*) INTO v_category_count
    FROM activity_categories
    WHERE category_name IN ('Attractions', 'Dining', 'Entertainment');

    IF v_category_count <> 3 THEN
        RAISE EXCEPTION 'Expected Attractions, Dining, Entertainment categories; found %', v_category_count;
    END IF;

    SELECT COUNT(*) INTO v_stage_count FROM mk_import_stage;
    IF v_stage_count <> 88 THEN
        RAISE EXCEPTION 'Expected 88 staged activities, found %', v_stage_count;
    END IF;

    IF EXISTS (
        SELECT 1 FROM mk_import_stage
        WHERE entity_type NOT IN ('ATTRACTION', 'RESTAURANT', 'SHOW')
    ) THEN
        RAISE EXCEPTION 'Unexpected entity type in Magic Kingdom import';
    END IF;
END;
$$;

INSERT INTO activities (
    activity_name,
    activity_category_id,
    location_id,
    themeparks_id,
    source_external_id,
    entity_type,
    slug,
    latitude,
    longitude
)
SELECT
    s.activity_name,
    c.activity_category_id,
    l.location_id,
    s.themeparks_id,
    s.source_external_id,
    s.entity_type,
    s.slug,
    s.latitude,
    s.longitude
FROM mk_import_stage AS s
JOIN locations AS l
    ON l.location_name IN ('Magic Kingdom', 'Magic Kingdom Park')
JOIN activity_categories AS c
    ON c.category_name = CASE s.entity_type
        WHEN 'ATTRACTION' THEN 'Attractions'
        WHEN 'RESTAURANT' THEN 'Dining'
        WHEN 'SHOW' THEN 'Entertainment'
    END
ON CONFLICT (themeparks_id) DO NOTHING;

COMMIT;

-- Verification: returns total imported records by API classification.
SELECT entity_type, COUNT(*) AS activity_count
FROM activities
WHERE themeparks_id IN (
    '92524eb7-4ee5-4eab-936c-2eb8e6eb0ecd'::uuid,
    '52ac3730-b955-452a-a7cc-17e3b06182ac'::uuid,
    '05ca3e51-580b-44ca-8046-7d3e57a6d248'::uuid,
    '9221e600-6715-4b4f-b39a-00c318c00e03'::uuid,
    '924a3b2c-6b4b-49e5-99d3-e9dc3f2e8a48'::uuid,
    'e40ac396-cbac-43f4-8752-764ed60ccceb'::uuid,
    '9d4d5229-7142-44b6-b4fb-528920969a2c'::uuid,
    'de737ffc-306b-4f32-8bbb-34e5d370ec8f'::uuid,
    'e76c93df-31af-49a5-8e2f-752c76c937c9'::uuid,
    'de3309ca-97d5-4211-bffe-739fed47e92f'::uuid,
    'f5aad2d4-a419-4384-bd9a-42f86385c750'::uuid,
    '890fa430-89c0-4a3f-96c9-11597888005e'::uuid,
    '30fe3c64-af71-4c66-a54b-aa61fd7af177'::uuid,
    '86a41273-5f15-4b54-93b6-829f140e5161'::uuid,
    '96455de6-f4f1-403c-9391-bf8396979149'::uuid,
    '0f57cecf-5502-4503-8bc3-ba84d3708ace'::uuid,
    '4c1ccb9e-ff1d-40b6-9454-72c261dd8b00'::uuid,
    'e847a8bd-7d21-432b-a7a1-f483517a22b5'::uuid,
    'ae9a4a79-ccf1-4561-9a95-cf83d3007b98'::uuid,
    '55bdcccc-217b-416c-b8b0-4b6a87d16179'::uuid,
    '4bbaa21d-4203-494a-a120-b780dc7570ec'::uuid,
    'c4b64a31-e855-46a9-9d1a-aa13c99e88af'::uuid,
    'a5098eb1-a673-47c2-b782-5c48bb83da17'::uuid,
    '83201c33-ce99-45ae-a595-f47e61d73739'::uuid,
    '166f2985-7b27-4eff-a8b3-29c3448ba198'::uuid,
    '1eee22e8-1d0a-4809-a42b-df3ae55c69d5'::uuid,
    'a0613b70-293f-4a5b-8169-357be1777c62'::uuid,
    '82483712-0603-4c67-8560-8a7364777940'::uuid,
    '012a211b-4c91-451c-8a0e-5e3ab398eda8'::uuid,
    '72c7343a-f7fb-4f66-95df-c91016de7338'::uuid,
    '6fd1e225-53a0-4a80-a577-4bbc9a471075'::uuid,
    'f010bc01-b450-4476-a5f3-a5f2813104b2'::uuid,
    'f163ddcd-43e1-488d-8276-2381c1db0a39'::uuid,
    '273ddb8d-e7b5-4e34-8657-1113f49262a5'::uuid,
    '0aae716c-af13-4439-b638-d75fb1649df3'::uuid,
    'e39b831b-7731-49bb-815b-289b4f49a9fd'::uuid,
    'b2260923-9315-40fd-9c6b-44dd811dbe64'::uuid,
    '819fd147-3f17-420a-9188-2ba4c544d761'::uuid,
    '8183f3f2-1b59-4b9c-b634-6a863bdf8d84'::uuid,
    '7c5e1e02-3a44-4151-9005-44066d5ba1da'::uuid,
    'ffcfeaa2-1416-4920-a1ed-543c1a1695c4'::uuid,
    'e8f0b426-7645-4ea3-8b41-b94ae7091a41'::uuid,
    '2ebfb38c-5cb5-4de1-86c0-f7af14188022'::uuid,
    '888fb4a4-7adf-47a1-8ba2-c258cc64fd75'::uuid,
    'd9d12438-d999-4482-894b-8955fdb20ccf'::uuid,
    '40737d3d-0ff6-4a9e-a050-beb87bf90120'::uuid,
    '5a43d1a7-ad53-4d25-abfe-25625f0da304'::uuid,
    '73cb9445-0695-47a3-87ce-d08ae36b5f3c'::uuid,
    '90d79335-c907-4069-a021-d0fe1ec73ae2'::uuid,
    '2551a77d-023f-4ab1-9a19-8afec0190f39'::uuid,
    'b5d6d1d1-e960-4c8f-a8a4-b9748b386b64'::uuid,
    '4c31b3ad-5dc9-437f-ac1a-0fdff36a2818'::uuid,
    'cf4b2ba4-3626-4de7-9d07-abe8a65b1665'::uuid,
    '5af2c3a9-7697-414f-9642-6cb17a329613'::uuid,
    '48d0c81e-3f47-4ff9-aa3c-331cb83a0af9'::uuid,
    '8073763e-19ee-4506-a823-a902e8e7f3b9'::uuid,
    '5135ff2e-2f42-4138-bc30-706eb25963e4'::uuid,
    '1c708beb-41e1-43ae-8dd8-1e85075aeb38'::uuid,
    '0d94ad60-72f0-4551-83a6-ebaecdd89737'::uuid,
    'ee56b2f3-fd49-4a29-ae1a-2d321549a633'::uuid,
    '352feb94-e52e-45eb-9c92-e4b44c6b1a9d'::uuid,
    '646a3063-dc41-4671-bc0a-0958b95fb553'::uuid,
    '796b0a25-c51e-456e-9bb8-50a324e301b3'::uuid,
    '3cba0cb4-e2a6-402c-93ee-c11ffcb127ef'::uuid,
    'd69261dc-62b8-434c-83bd-93649b43c408'::uuid,
    '51392ca4-f824-42d8-8808-8110ec8e0e22'::uuid,
    'e0cd6a94-6dbe-4f52-aaa8-b3d2fdf5f2f6'::uuid,
    '86c198b0-7c02-4354-814a-27ad70067d45'::uuid,
    '22b78ed9-a692-47cb-b6a4-6d1224ff67e3'::uuid,
    'f819079e-644e-4fce-bda3-26b899ac7027'::uuid,
    'a2d92647-634d-4eb4-886b-9da858e871f1'::uuid,
    '1b9a6231-b658-470f-92cc-808925280214'::uuid,
    '6ea670b8-3097-4d60-b69c-94e16071da17'::uuid,
    '697473c5-ae17-4c3f-80c7-09a813248013'::uuid,
    '5f42b43a-e745-487b-9545-dd601f6984ce'::uuid,
    '75d43698-162c-47af-a607-e879637dc8e7'::uuid,
    'be2c6511-750b-4fa6-8332-606d4342f814'::uuid,
    'ab1b9ce7-aada-4b47-9fa0-1b178203d02b'::uuid,
    'a74421f2-5de4-4425-bd06-8b4639b29826'::uuid,
    '5c00cd7c-b207-4d9d-9c8c-a8d418fc5425'::uuid,
    '6d74b3d9-f977-4c9b-8114-93969b51b105'::uuid,
    '5564113f-25b4-4646-ac35-aacf983e2fd6'::uuid,
    '947edbee-85a5-4aa0-99f3-14c7de539542'::uuid,
    '9140033d-d746-464b-acad-f05f9357f0bd'::uuid,
    '97c837c3-4a0f-4d52-b93c-074cf31d6f41'::uuid,
    'c1f39c15-7845-46b5-b6fd-2ae368a32a37'::uuid,
    '62eac07c-fa2d-45ab-a6e6-d8aa0054540d'::uuid,
    '362aa1ba-b1a2-4617-a97c-5a6805f32417'::uuid
)
GROUP BY entity_type
ORDER BY entity_type;
