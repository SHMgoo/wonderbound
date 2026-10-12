
-- ============================================================
-- WonderBound
-- 008_activities.sql
-- Master Catalog of Disney Activities
-- ============================================================

BEGIN;

-- ============================================================
-- 1. CREATE ACTIVITIES TABLE
-- ============================================================

CREATE TABLE activities (
    activity_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    activity_name VARCHAR(255) NOT NULL,

    activity_category_id BIGINT NOT NULL
        REFERENCES activity_categories(activity_category_id),

    location_id BIGINT NOT NULL
        REFERENCES locations(location_id),

    themeparks_id UUID UNIQUE,

    source_external_id VARCHAR(100),

    entity_type VARCHAR(50),

    slug VARCHAR(255),

    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,

    description TEXT,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    -- Activity name cannot be blank
    CONSTRAINT activities_name_not_blank
        CHECK (LENGTH(TRIM(activity_name)) > 0),

    -- Valid latitude
    CONSTRAINT activities_latitude_valid
        CHECK (latitude BETWEEN -90 AND 90),

    -- Valid longitude
    CONSTRAINT activities_longitude_valid
        CHECK (longitude BETWEEN -180 AND 180),

    -- Latitude and longitude must be supplied together
    CONSTRAINT activities_coordinates_together
        CHECK (
            (latitude IS NULL AND longitude IS NULL)
            OR
            (latitude IS NOT NULL AND longitude IS NOT NULL)
        )
);

-- ============================================================
-- 2. CREATE INDEXES
-- ============================================================

CREATE INDEX idx_activities_category
    ON activities(activity_category_id);

CREATE INDEX idx_activities_location
    ON activities(location_id);

CREATE INDEX idx_activities_active
    ON activities(is_active);

-- ============================================================
-- 3. CREATE UPDATED_AT TRIGGER
-- Uses existing function from 001_users.sql
-- ============================================================

CREATE TRIGGER trg_activities_updated_at
BEFORE UPDATE ON activities
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();

-- ============================================================
-- 4. COMPLETE TRANSACTION
-- ============================================================

COMMIT;

-- ============================================================
-- 5. VERIFY TABLE
-- ============================================================

SELECT COUNT(*) AS total_activities
FROM activities;
