
-- ============================================================
-- WonderBound
-- 003_trip_participants.sql
--
-- Connects registered users to trips.
-- Supports multiple owners and regular participants.
-- ============================================================

CREATE TABLE public.trip_participants (
    trip_participant_id BIGINT
        GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    trip_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,

    role VARCHAR(20) NOT NULL DEFAULT 'participant',

    joined_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_trip_participants_trip
        FOREIGN KEY (trip_id)
        REFERENCES public.trips(trip_id),

    CONSTRAINT fk_trip_participants_user
        FOREIGN KEY (user_id)
        REFERENCES public.users(user_id),

    CONSTRAINT uq_trip_participants_trip_user
        UNIQUE (trip_id, user_id),

    CONSTRAINT chk_trip_participants_role
        CHECK (role IN ('owner', 'participant'))
);


-- Automatically update updated_at whenever
-- a participant record changes.

CREATE TRIGGER trg_trip_participants_updated_at
BEFORE UPDATE ON public.trip_participants
FOR EACH ROW
EXECUTE FUNCTION public.set_updated_at();
