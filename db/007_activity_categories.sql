
-- ============================================================
-- 007_activity_categories.sql
-- Wonderbound - Activity Categories
-- ============================================================
CREATE TABLE activity_categories (
    activity_category_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    category_name VARCHAR(100) NOT NULL UNIQUE,

    description TEXT,

    display_order INTEGER NOT NULL DEFAULT 0,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);
