
-- ============================================================
-- WonderBound
-- 004_trip_invitations.sql
--
-- Stores invitations to join individual trips.
-- Preserves invitation history.
-- ============================================================

CREATE TABLE public.trip_invitations (

    invitation_id BIGINT
        GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    trip_id BIGINT NOT NULL,
    invited_email VARCHAR(255) NOT NULL,
    invited_by BIGINT NOT NULL,

    status VARCHAR(20) NOT NULL DEFAULT 'pending',

    invitation_token_hash TEXT NOT NULL UNIQUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMPTZ NOT NULL
        DEFAULT (CURRENT_TIMESTAMP + INTERVAL '7 days'),

    responded_at TIMESTAMPTZ,
    expiration_notified_at TIMESTAMPTZ,

    CONSTRAINT fk_trip_invitations_trip
        FOREIGN KEY (trip_id)
        REFERENCES public.trips(trip_id),

    CONSTRAINT fk_trip_invitations_invited_by
        FOREIGN KEY (invited_by)
        REFERENCES public.users(user_id),

    CONSTRAINT chk_trip_invitations_status
        CHECK (
            status IN (
                'pending',
                'accepted',
                'declined',
                'expired',
                'canceled'
            )
        ),

    CONSTRAINT chk_trip_invitations_email
        CHECK (LENGTH(TRIM(invited_email)) > 0),

    CONSTRAINT chk_trip_invitations_expiration
        CHECK (expires_at > created_at)
);


-- Prevent duplicate pending invitations
-- for the same email address and trip.

CREATE UNIQUE INDEX uq_trip_invitations_pending
ON public.trip_invitations (
    trip_id,
    LOWER(TRIM(invited_email))
)
WHERE status = 'pending';


-- Help scheduled processes find pending
-- invitations that have expired.

CREATE INDEX idx_trip_invitations_expiration
ON public.trip_invitations (expires_at)
WHERE status = 'pending';
