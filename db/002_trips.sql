
CREATE TABLE public.trips (
    trip_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    trip_name VARCHAR(150) NOT NULL,
    description TEXT,

    start_date DATE,
    end_date DATE,

    created_by BIGINT NOT NULL,

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMPTZ,

    CONSTRAINT fk_trips_created_by
        FOREIGN KEY (created_by)
        REFERENCES public.users(user_id),

    CONSTRAINT chk_trips_dates
        CHECK (
            start_date IS NULL
            OR end_date IS NULL
            OR end_date >= start_date
        )
);

CREATE TRIGGER trg_trips_updated_at
BEFORE UPDATE ON public.trips
FOR EACH ROW
EXECUTE FUNCTION public.set_updated_at();
