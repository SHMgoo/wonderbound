-- WonderBound | 010_import_epcot.sql
-- EPCOT activity catalog, based on supplied ThemeParks.wiki API snapshot.
-- Preserves API classifications. Safe to rerun; updates matched source IDs.
BEGIN;

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM locations WHERE location_name = 'EPCOT') THEN
        RAISE EXCEPTION 'EPCOT location missing from locations';
    END IF;
    IF (SELECT COUNT(*) FROM locations WHERE location_name = 'EPCOT') <> 1 THEN
        RAISE EXCEPTION 'EPCOT location name is not unique';
    END IF;
    IF EXISTS (
        SELECT 1 FROM (VALUES ('ATTRACTION','Attractions'), ('RESTAURANT','Dining'), ('SHOW','Entertainment')) AS m(entity_type, category_name)
        WHERE (SELECT COUNT(*) FROM activity_categories c WHERE c.category_name = m.category_name) <> 1
    ) THEN
        RAISE EXCEPTION 'Required category missing or duplicated: Attractions, Dining, Entertainment';
    END IF;
END $$;

CREATE TEMP TABLE epcot_import (
    themeparks_id UUID PRIMARY KEY,
    activity_name VARCHAR(255) NOT NULL,
    entity_type VARCHAR(50) NOT NULL,
    source_external_id VARCHAR(100),
    slug VARCHAR(255),
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION
) ON COMMIT DROP;

INSERT INTO epcot_import (themeparks_id, activity_name, entity_type, source_external_id, slug, latitude, longitude)
VALUES
    ('eb6a60d7-b354-47a1-a091-0beb11b24188', 'Akershus Royal Banquet Hall', 'RESTAURANT', '90002066;entityType=restaurant', 'akershusroyalbanquethall', 28.370588, -81.546728),
    ('0e35a7a2-c2cd-451b-88e2-afc9d370e69e', 'Garden Rocks Concert Series at EPCOT International Flower & Garden Festival', 'SHOW', '17198736;entityType=Entertainment', NULL, 28.36831, -81.549428),
    ('3beaa9a5-6404-4446-bfd1-e0d0eea65e85', 'JAMMitors', 'SHOW', '13507;entityType=Entertainment', 'jammingardeners', 28.3732336499128, -81.5501600577662),
    ('fb1e45fc-a2bb-4e3c-951d-3a4e2130b79d', 'Acrobatico!', 'SHOW', '412442146;entityType=Entertainment', NULL, 28.367875, -81.54822),
    ('fc64aa10-290f-472e-9fab-4d649f53ab2d', 'La Crêperie de Paris', 'RESTAURANT', '19511274;entityType=restaurant', NULL, 28.368536, -81.553597),
    ('7b79e739-c540-4ea5-a4c8-f8d8bac5719b', 'Meet the Legendary Warrior in China', 'SHOW', '268742;entityType=Entertainment', NULL, 28.3698563364835, -81.5461904203374),
    ('8410885a-115d-4a5f-9cd5-08d0e659a603', 'Takumi-Tei', 'RESTAURANT', '19317888;entityType=restaurant', 'takumitei', 28.367848, -81.550833),
    ('b772df79-1fca-4c0a-a2f3-88b22e63e7c3', 'Space 220 Restaurant', 'RESTAURANT', '19433706;entityType=restaurant', 'space220comingsoon', 28.373777, -81.547056),
    ('fb076275-0570-4d62-b2a9-4d6515130fa3', 'The Seas with Nemo & Friends', 'ATTRACTION', '107785;entityType=Attraction', 'theseaswithnemofriends', 28.374904, -81.550852),
    ('1e735ffb-4868-47f1-b2cd-2ac1156cd5f0', 'Remy''s Ratatouille Adventure', 'ATTRACTION', '19497835;entityType=Attraction', 'remysratatouilleadventureopeningoctober12021', 28.36825, -81.553097),
    ('482169b9-2889-4747-8aef-f9d13a37d940', 'Awesome Planet', 'ATTRACTION', '19473173;entityType=Attraction', 'awesomeplanet', 28.374301, -81.552138),
    ('66ff36de-9cb3-4d9a-b891-1665d19ffb3e', 'Stave Church Gallery', 'ATTRACTION', '61525;entityType=Attraction', 'stavechurchgallery', 28.370621, -81.546971),
    ('2ecc4fff-2994-476f-9926-24a4af173838', 'Bruce''s Shark World', 'ATTRACTION', '56404;entityType=Attraction', 'brucessharkworld', 28.375099, -81.551245451),
    ('75449e85-c410-4cef-a368-9d2ea5d52b58', 'Journey Into Imagination With Figment', 'ATTRACTION', '80010152;entityType=Attraction', 'journeyintoimaginationwithfigment', 28.372994, -81.551401),
    ('1f542745-cda1-4786-a536-5fff373e5964', 'The American Adventure', 'ATTRACTION', '80010200;entityType=Attraction', 'theamericanadventure', 28.367517, -81.549446),
    ('8f8746cb-c714-4c60-848d-e2dc4e6f586b', 'Mexico Folk Art Gallery', 'ATTRACTION', '80069743;entityType=Attraction', 'mexicofolkartgallery', 28.371511, -81.54746),
    ('37ae57c5-feaf-4e47-8f27-4b385be200f0', 'Test Track', 'ATTRACTION', '80010199;entityType=Attraction', 'testtrack', 28.373228, -81.547489),
    ('5b7cf10a-763b-45ba-9049-87140270826f', 'La Hacienda de San Angel', 'RESTAURANT', '15525573;entityType=restaurant', 'lahaciendadesanangel', 28.371221, -81.547532),
    ('736b2e6c-daaf-45c4-ba9e-fb60d7cf92d6', 'La Cava del Tequila', 'RESTAURANT', '348023;entityType=restaurant', 'lacavadeltequila', 28.37158, -81.547299),
    ('93843fb0-ee5a-49c6-91a8-40a042e93865', 'Monsieur Paul', 'RESTAURANT', '90001296;entityType=restaurant', 'monsieurpaul', 28.368868, -81.55273),
    ('c9e1d1f6-021f-43f2-a14b-3e67f65adbc4', 'Biergarten Restaurant', 'RESTAURANT', '90001292;entityType=restaurant', 'biergartenrestaurant', 28.368153, -81.546819),
    ('38892221-f69c-4913-97c9-7473c88854fa', 'Coral Reef Restaurant', 'RESTAURANT', '90001416;entityType=restaurant', 'coralreefrestaurant', 28.375096, -81.550458),
    ('91e9cda9-b39f-4a24-b63e-57bc1ba612f5', 'Rose & Crown Pub', 'RESTAURANT', '90002086;entityType=restaurant', 'rosecrownpub', 28.370508, -81.551742),
    ('3f3ef6db-69de-418a-8861-f541309cdb01', 'Sommerfest', 'RESTAURANT', '90002154;entityType=restaurant', 'sommerfest', 28.368123, -81.546902),
    ('d4179c4c-eb08-4559-aa7c-f9802fda641b', 'Garden Grill Restaurant', 'RESTAURANT', '90002237;entityType=restaurant', 'gardengrillrestaurant', 28.374039, -81.552324),
    ('c63e29ac-f57f-4cd0-b998-799a2849dfa1', 'UK Beer Cart', 'RESTAURANT', '90002326;entityType=restaurant', 'ukbeercart', 28.370601, -81.551648),
    ('6e70f3fb-faab-41b1-8d26-b85d1c5cfa26', 'Entertainment at Canada Mill Stage', 'SHOW', '19036653;entityType=Entertainment', 'entertainmentatcanadamillstage', 28.371202, -81.551509),
    ('195fac06-ab2f-4655-8af7-b27adcdad54e', 'La Poutinerie', 'RESTAURANT', '412635828;entityType=restaurant', NULL, 28.371749, -81.550556),
    ('9053240b-7f7f-44fe-970b-bd7956cd5d4f', 'Project Tomorrow: Inventing the Wonders of the Future', 'ATTRACTION', '220239;entityType=Attraction', 'projecttomorrowinventingthewondersofthefuture', 28.37476, -81.549401),
    ('35ed719b-f7f0-488f-8346-4fbf8055d373', 'Disney and Pixar Short Film Festival', 'ATTRACTION', '18269694;entityType=Attraction', 'disneyandpixarshortfilmfestival', 28.37263, -81.55115),
    ('8d7ccdb1-a22b-4e26-8dc8-65b1938ed5f0', 'Frozen Ever After', 'ATTRACTION', '18375495;entityType=Attraction', 'frozeneverafter', 28.370745, -81.54653),
    ('4f0df9e7-d4c1-45b5-93e2-4a7bc92547b0', 'American Heritage Gallery', 'ATTRACTION', '26421;entityType=Attraction', 'americanheritagegallery', 28.367517, -81.549469),
    ('3d8f8f8f-f984-4d2e-8dea-5a79432bdf05', 'Advanced Training Lab', 'ATTRACTION', '3831;entityType=Attraction', 'advancedtraininglab', 28.374185, -81.547072),
    ('00666fe9-7774-4b53-9fb7-3d333f8aa503', 'Impressions de France', 'ATTRACTION', '80010145;entityType=Attraction', 'impressionsdefrance', 28.368864, -81.552978),
    ('57acb522-a6fc-4aa4-a80e-21f21f317250', 'Turtle Talk With Crush', 'ATTRACTION', '62992;entityType=Attraction', 'turtletalkwithcrush', 28.375255, -81.551047),
    ('ee070d46-6a64-41c0-9f12-69dcfcca10a0', 'Reflections of China', 'ATTRACTION', '80010180;entityType=Attraction', 'reflectionsofchina', 28.369791, -81.546381),
    ('480fde8f-fe58-4bfb-b3ab-052a39d4db7c', 'Spaceship Earth', 'ATTRACTION', '80010191;entityType=Attraction', 'spaceshipearth', 28.375583, -81.549401),
    ('3ace01d1-15fc-4fbb-99e4-81a696cb2d05', 'Kidcot Fun Stops', 'ATTRACTION', '91245;entityType=Attraction', 'kidcotfunstops', 28.36806, -81.547068),
    ('0e673d4b-eee4-4735-ab65-be39bcd28d11', 'Fife & Drum Tavern', 'RESTAURANT', '248784;entityType=restaurant', 'fifedrumtavern', 28.367929, -81.549122),
    ('db1bb4b3-36ff-40d7-bc65-45667eeb8aed', 'Spice Road Table Bar', 'RESTAURANT', '412012969;entityType=restaurant', NULL, 28.368468, -81.551645),
    ('07dbeaea-85fa-45f2-872f-02f9e7510419', 'Gallery of Arts and History', 'ATTRACTION', '80010137;entityType=Attraction', 'galleryofartsandhistory', 28.368236, -81.551612),
    ('0f40274d-420a-425a-9377-29fd6e49484f', 'House of the Whispering Willows', 'ATTRACTION', '160914;entityType=Attraction', 'houseofthewhisperingwillows', 28.36999, -81.546334),
    ('dae68dee-dfba-4128-b594-6aa12add1070', 'Journey of Water, Inspired by Moana', 'ATTRACTION', '411794307;entityType=Attraction', NULL, 28.374691, -81.550378),
    ('8c8cd77d-97f6-4309-b285-42aad90e9f15', 'Beauty and the Beast Sing-Along', 'ATTRACTION', '19463785;entityType=Attraction', 'beautyandthebeastsingalong', 28.368864, -81.552978),
    ('18c533d6-a395-4ae4-9488-80fce9c497fe', 'Palais du Cinéma', 'ATTRACTION', '19503896;entityType=Attraction', 'palaisducinma', 28.368864, -81.552978),
    ('6f1d3b25-42c9-4e99-9dce-6c20d7a5deea', 'Bijutsu-kan Gallery', 'ATTRACTION', '80069745;entityType=Attraction', 'bijutsukangallery', 28.367309, -81.550525),
    ('61fb49f8-e62f-4e1c-ae0e-8ab9929037bc', 'Canada Far and Wide in Circle-Vision 360', 'ATTRACTION', '80010174;entityType=Attraction', 'canadafarandwideincirclevision360', 28.371694, -81.55196),
    ('22f48b73-01df-460e-8969-9eb2b4ae836c', 'Gran Fiesta Tour Starring The Three Caballeros', 'ATTRACTION', '207395;entityType=Attraction', 'granfiestatourstarringthethreecaballeros', 28.371649, -81.547368),
    ('33bd3bad-6803-4c5e-97ac-f7e31261a604', 'Meet Anna and Elsa at Royal Sommerhus', 'SHOW', '17564219;entityType=Entertainment', 'meetannaandelsaatroyalsommerhus', 28.37097, -81.547134),
    ('c5f6c7e4-d5cd-4d71-8e02-57d8bb43b3ba', 'Voices of Liberty', 'SHOW', '80010879;entityType=Entertainment', 'voicesofliberty', 28.367595, -81.549387),
    ('7969166f-feef-4350-b26e-6a6c745528f4', 'SeaBase Aquarium', 'ATTRACTION', '80010184;entityType=Attraction', 'seabase', 28.375098, -81.551211),
    ('8e1a9a60-9311-4f79-b6a8-1b5172e4f7c9', 'Entertainment at Germany Gazebo', 'SHOW', '19242311;entityType=Entertainment', NULL, 28.368651, -81.546584),
    ('99087d9a-4380-4ab6-b088-20816e233c6f', 'Meet Asha Near World Showcase Plaza', 'SHOW', '412026226;entityType=Entertainment', NULL, 28.3718773852161, -81.5488533162313),
    ('296d164a-8b9a-49d3-a285-637b86731260', 'Matsuriza', 'SHOW', '80010865;entityType=Entertainment', 'matsuriza', 28.36786, -81.550389),
    ('2ebce841-be26-42e3-a552-393dc995cfe8', 'Meet Pluto Near EPCOT Main Entrance', 'SHOW', '18416876;entityType=Entertainment', NULL, 28.375567, -81.549695),
    ('67612787-fbd3-44b7-869f-123f55d78584', 'Meet Beloved Disney Pals at Mickey & Friends', 'SHOW', '412126613;entityType=Entertainment', NULL, 28.373898, -81.549914),
    ('5b6475ad-4e9a-4793-b841-501aa382c9c0', 'Mission: SPACE', 'ATTRACTION', '80010173;entityType=Attraction', 'missionspace', 28.373927, -81.547156),
    ('25ec84ef-112f-424d-9fe0-5fc1fa9620a9', 'Block & Hans', 'RESTAURANT', '17561004;entityType=restaurant', 'blockhans', 28.367977, -81.549929),
    ('e3549451-b284-453d-9c31-e3b1207abd79', 'Guardians of the Galaxy: Cosmic Rewind', 'ATTRACTION', '411499845;entityType=Attraction', NULL, 28.3749021961781, -81.5478397673417),
    ('802b79b0-6491-434d-b4b5-145387d62172', 'Tutto Gusto Wine Cellar', 'RESTAURANT', '16526362;entityType=restaurant', 'tuttogustowinecellar', 28.367506, -81.548144),
    ('67186665-6756-4c29-9010-6efc222b2d9b', 'Yorkshire County Fish Shop', 'RESTAURANT', '90002416;entityType=restaurant', 'yorkshirecountyfishshop', 28.370281, -81.551772),
    ('8f353879-d6ac-4211-9352-4029efb47c18', 'Living with the Land', 'ATTRACTION', '80010161;entityType=Attraction', 'livingwiththeland', 28.374245, -81.552301),
    ('3e5f26ee-c02d-47fd-891e-5e4479073444', 'ImageWorks - The "What If" Labs', 'ATTRACTION', '80010144;entityType=Attraction', 'imageworksthewhatiflabs', 28.372774, -81.551121),
    ('81b15dfd-cf6a-466f-be59-3dd65d2a2807', 'Soarin'' Across America', 'ATTRACTION', '412577054;entityType=Attraction', 'soarinaroundtheworld', 28.373592, -81.552248),
    ('3dbf1ff2-eee0-44a9-8cd9-22bf920e81e9', 'Luminous The Symphony of Us', 'SHOW', '412008998;entityType=Entertainment', NULL, 28.3697559273453, -81.5471178955173),
    ('a70b81bf-2934-433c-9723-afb2f24112bf', 'Meet Figment Inside ImageWorks', 'SHOW', '411994369;entityType=Entertainment', NULL, 28.372769, -81.55128),
    ('41aba635-48e4-43bf-9bb1-3b811b5705d0', 'Rose & Crown Pub Musician', 'SHOW', '17490262;entityType=Entertainment', 'epcotpianist', 28.370467, -81.551677),
    ('5d3bdec3-8484-4aca-b192-e9735a41a316', 'Meet One of the Three Caballeros in Mexico', 'SHOW', '387139;entityType=Entertainment', NULL, 28.371185, -81.547297),
    ('83fed9d1-c25f-497c-ab8e-21e4dd7ce655', 'Sergio', 'SHOW', '80010873;entityType=Entertainment', 'sergio', 28.36787, -81.548184),
    ('fd8afd63-0cb5-4f77-b47b-fb277f12d9f8', '¡Celebración Encanto!', 'SHOW', '412126654;entityType=Entertainment', NULL, 28.373539, -81.549749),
    ('76eadac1-cdfa-45e5-a25c-54ed4c3a604f', 'Marimba de las Américas', 'SHOW', '19277873;entityType=Entertainment', 'marimbadelasamricas', 28.371511, -81.547426),
    ('001b099f-4db8-4843-8c1e-852e0e8fc2df', 'Viva Mexico', 'SHOW', '209984;entityType=Entertainment', 'vivamexico', 28.3716573, -81.54719744),
    ('e9c1bff6-c9c1-4275-8f3d-44226f0fdfbb', 'Meet Princess Aurora in France', 'SHOW', '15574092;entityType=Entertainment', NULL, 28.36922, -81.55286),
    ('0c7097cb-8b29-4257-9e9a-a11ed59ceb46', 'GoofyCore at CommuniCore Hall', 'SHOW', '412380330;entityType=Entertainment', NULL, 28.3736876589442, -81.550320679552),
    ('302d424d-3c56-40e7-9785-fba2f62e5854', 'GRAB-N-GOOF', 'RESTAURANT', '19277840;entityType=restaurant', 'outdoorkitchenthecitrusblossom', 28.3736946934633, -81.54990394851295),
    ('d3461b18-2d07-4c21-97a3-6c28fca94678', 'Pizza al Taglio', 'RESTAURANT', '18448091;entityType=restaurant', NULL, 28.367506, -81.548144),
    ('15107c34-65a3-473c-aaeb-655b508f529d', 'Space 220 Lounge', 'RESTAURANT', '19634138;entityType=restaurant', NULL, 28.373777, -81.547056),
    ('74f13ee5-8e10-41a7-a19d-38e9c9582652', 'Tangierine Café: Flavors of the Medina', 'RESTAURANT', '90002205;entityType=restaurant', 'tangierinecaf', 28.368301, -81.551841),
    ('0b543ab9-d6f2-4614-bc2c-c7c088d9a582', 'Crêpes À Emporter by La Crêperie de Paris', 'RESTAURANT', '19633239;entityType=restaurant', NULL, 28.368536, -81.553597),
    ('95ab66f4-4e47-4f76-875f-45ae70831e2f', 'GEO-82', 'RESTAURANT', '412297708;entityType=restaurant', NULL, 28.37466514737089, -81.5496073600167),
    ('17d51899-7d6d-4cd7-93bb-4064a47d501b', 'Teppan Edo', 'RESTAURANT', '221625;entityType=restaurant', 'teppanedo', 28.367674, -81.550701),
    ('4807262a-ad16-4d43-a0d7-64b24603ef36', 'Chefs de France', 'RESTAURANT', '90001373;entityType=restaurant', 'chefsdefrance', 28.368954, -81.552639),
    ('3206e3a6-cbc3-4960-9700-163764bc47d6', 'Le Cellier Steakhouse', 'RESTAURANT', '90001798;entityType=restaurant', 'lecelliersteakhouse', 28.371657, -81.551512),
    ('6ecdbfc8-85c2-436d-893b-6db0f437b74a', 'Rose & Crown Dining Room', 'RESTAURANT', '90002084;entityType=restaurant', 'rosecrowndiningroom', 28.370508, -81.551684),
    ('1cf38b60-d075-495b-a92f-5a6a59d9e3db', 'Les Vins des Chefs de France', 'RESTAURANT', '90002394;entityType=restaurant', 'lesvinsdeschefsdefrance', 28.369018, -81.552363),
    ('dbf4a977-a7b5-41db-a9b7-ecad65f9aa0f', 'Spice Road Table', 'RESTAURANT', '17720675;entityType=restaurant', 'spiceroadtable', 28.368468, -81.551645),
    ('e14e439d-d1aa-4f3a-90e9-60c524bd0b5a', 'Tutto Italia Ristorante', 'RESTAURANT', '220739;entityType=restaurant', 'tuttoitaliaristorante', 28.367627, -81.548052),
    ('48e7f9f2-ddc3-4ced-8d11-a5cd968085c2', 'Shiki-Sai: Sushi Izakaya', 'RESTAURANT', '221626;entityType=restaurant', 'tokyodining', 28.367709, -81.550701),
    ('e8dccc86-cfb4-44c3-9a90-e95b88edbd21', 'Nine Dragons Restaurant', 'RESTAURANT', '90001985;entityType=restaurant', 'ninedragonsrestaurant', 28.370056, -81.546688),
    ('07263f57-0431-4da2-a8b6-77d2965a6f83', 'San Angel Inn Restaurante', 'RESTAURANT', '90002100;entityType=restaurant', 'sanangelinnrestaurante', 28.371612, -81.547258),
    ('c7444c22-4b35-4a9e-9cca-56ecc05376cc', 'Connections Eatery', 'RESTAURANT', '19635791;entityType=restaurant', NULL, 28.3743400792775, -81.5484700507225),
    ('85352291-58dd-4dd9-86d3-cba21cebb684', 'Karamell-Küche', 'RESTAURANT', '19624456;entityType=restaurant', NULL, 28.368364, -81.546953),
    ('b83b6dc9-9573-4e15-ab00-9ed8a2334770', 'Via Napoli Ristorante e Pizzeria', 'RESTAURANT', '15525574;entityType=restaurant', 'vianapoliristoranteepizzeria', 28.367354, -81.548192),
    ('419df435-6213-4d65-b0fc-8c0ad8379e11', 'Choza de Margarita', 'RESTAURANT', '18463740;entityType=restaurant', 'chozademargarita', 28.371548, -81.547713),
    ('58404f45-7e74-4c0c-b037-b903fa1066d2', 'Refreshment Outpost', 'RESTAURANT', '90001409;entityType=restaurant', 'refreshmentoutpost', 28.369237, -81.546334),
    ('ce284609-9d86-444e-af5a-6c0adb68b0aa', 'Regal Eagle Smokehouse: Craft Drafts & Barbecue', 'RESTAURANT', '90001809;entityType=restaurant', 'regaleaglesmokehousecraftdraftsbarbecue', 28.367579, -81.549003),
    ('9cc8afdb-8e45-436f-96e5-72323d933423', 'Swirled Showcase', 'RESTAURANT', '411940745;entityType=restaurant', NULL, 28.371784, -81.550404),
    ('cf307ccb-8750-4cb9-ae54-d48bc9b34e2c', 'Shiki-Sai Fireworks Dining Package', 'RESTAURANT', '412759581;entityType=restaurant', NULL, 28.367709, -81.550701),
    ('e48629ab-939f-4fe0-9e6a-6ad29b8added', 'Command Performance', 'SHOW', '411702927;entityType=Entertainment', NULL, 28.370535, -81.55249),
    ('ea730d0c-7723-429d-89a4-9e76f053f5ac', 'Mariachi Cobre', 'SHOW', '19322758;entityType=Entertainment', 'mariachicobre', 28.371511, -81.547426),
    ('d6bb186c-382f-4ae6-bc76-fde8f141ed69', 'Eat to the Beat Concert Series Presented by Enterprise® at EPCOT International Food & Wine Festival', 'SHOW', '230077;entityType=Entertainment', NULL, 28.36832, -81.549429),
    ('344a6a81-2383-4d35-9ec3-93f5c3f033fe', 'Funnel Cake', 'RESTAURANT', '90001577;entityType=restaurant', 'funnelcake', 28.367975939223648, -81.55003115823622),
    ('f3bb21e6-e843-4c31-834f-b87f60c2ab3e', 'Living with the Land – Glimmering Greenhouses', 'ATTRACTION', '412010036;entityType=Attraction', NULL, 28.374245, -81.552301);

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
FROM epcot_import i
JOIN locations l ON l.location_name = 'EPCOT'
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

-- Verify EPCOT activity counts after import.
SELECT a.entity_type, COUNT(*) AS activity_count
FROM activities a
JOIN locations l ON l.location_id = a.location_id
WHERE l.location_name = 'EPCOT'
GROUP BY a.entity_type
ORDER BY a.entity_type;
