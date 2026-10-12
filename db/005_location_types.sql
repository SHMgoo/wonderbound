
-- WonderBound: 005_location_types.sql

CREATE TABLE public.location_types (
    location_type_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    type_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER trg_location_types_updated_at
BEFORE UPDATE ON public.location_types
FOR EACH ROW
EXECUTE FUNCTION public.set_updated_at();
  
-- WonderBound: 005_location_types.sql

CREATE TABLE public.location_types (
    location_type_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    type_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER trg_location_types_updated_at
BEFORE UPDATE ON public.location_types
FOR EACH ROW
EXECUTE FUNCTION public.set_updated_at();
  