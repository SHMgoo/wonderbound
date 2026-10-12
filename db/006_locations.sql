
-- ============================================================
-- 006_locations.sql
-- WonderBound - Locations
-- ============================================================

CREATE TABLE locations (
    location_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    location_name VARCHAR(150) NOT NULL,

    location_type_id BIGINT NOT NULL,

    parent_location_id BIGINT,

    disney_id VARCHAR(100),

    description TEXT,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_locations_location_type
        FOREIGN KEY (location_type_id)
        REFERENCES location_types(location_type_id),

    CONSTRAINT fk_locations_parent
        FOREIGN KEY (parent_location_id)
        REFERENCES locations(location_id)
);

CREATE INDEX idx_locations_location_type
    ON locations(location_type_id);

CREATE INDEX idx_locations_parent
    ON locations(parent_location_id);
