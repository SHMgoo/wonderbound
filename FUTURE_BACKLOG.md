# Future Enhancements & Research Backlog

**Project:** Disney Trip Planner (Wonderbound)  
**Document:** FUTURE_BACKLOG.md  
**Status:** Living Document

## 1. Purpose

This document tracks potential future enhancements, external data sources, technical improvements, and research topics for the Disney Trip Planner application.

Items in this backlog are ideas for future consideration, not approved development requirements.

As the project evolves, items may be researched, prioritized, moved into active development, or removed.

## 2. Backlog Status Definitions

- **Idea** — A potential enhancement or research topic that has not been evaluated.
- **Research Needed** — Requires investigation before a decision can be made.
- **Under Review** — Currently being evaluated.
- **Approved** — Selected for future development.
- **Deferred** — Considered but postponed.
- **Closed** — Completed, rejected, or no longer relevant.

## 3. External Data Sources & API Research

### FUT-001 — Evaluate Rope Drop News API

**Status:** Research Needed  
**Category:** External Data / API  
**Priority:** Low

**Description:**

Investigate the Rope Drop News public API as a supplemental source of Disney World operational data.

**Research Topics:**
- Live attraction wait times.
- Ride closures and operational status.
- Lightning Lane availability and pricing.
- Crowd predictions and historical trends.
- API usage limits, licensing, and attribution requirements.
- Ability to associate returned attractions with ThemeParks.wiki entity IDs.

**Reference:** https://ropedropnews.com/developers

**Decision Needed:** Determine whether this API provides enough additional value to justify integrating a second data source.

### FUT-002 — Evaluate Thrill Data

**Status:** Research Needed  
**Category:** External Data / API  
**Priority:** Low

**Description:**

Investigate Thrill Data as a potential source of Disney World historical and operational information.

**Research Topics:**
- Whether a public or licensed developer API is available.
- Historical attraction wait times.
- Lightning Lane information.
- Dining reservation data.
- Crowd and attendance trends.
- Terms governing data access and reuse.

**Reference:** https://www.thrill-data.com/

**Decision Needed:** Determine whether Thrill Data offers an appropriate and permitted method of accessing data programmatically.

### FUT-003 — Evaluate ThemeParks.wiki Inventory Coverage

**Status:** Research Needed  
**Category:** External Data / API  
**Priority:** Medium

**Description:**

Determine how completely ThemeParks.wiki can populate the Disney Trip Planner's initial inventory.

**Research Topics:**
- Attraction inventory across all four Walt Disney World theme parks.
- Restaurants and dining locations.
- Shows and entertainment.
- Special events.
- Resort and hotel information.
- Shops and retail locations.
- Availability of stable identifiers and useful metadata.
- Data caching, storage, and redistribution restrictions.

**Reference:** https://api.themeparks.wiki/

**Decision Needed:** Identify inventory gaps requiring additional sources or manual data maintenance.

### FUT-004 — Research Additional Disney Data Sources

**Status:** Idea  
**Category:** External Data / API  
**Priority:** Low

**Description:**

Identify additional reliable data sources for Disney World information not covered by the primary API.

**Research Topics:**
- Official Disney website data and permitted access methods.
- Dining menus and restaurant descriptions.
- Attraction descriptions and images.
- Resort amenities.
- Seasonal entertainment and special events.
- Data freshness and licensing.

**Decision Needed:** Determine which additional sources, if any, are appropriate for the application.

## 4. Potential Application Enhancements

### FUT-005 — Live Attraction Information

**Status:** Idea  
**Category:** Application Feature  
**Priority:** Low

**Description:**

Display current operational information for attractions already stored in the application's inventory.

**Potential Features:**
- Current wait times.
- Attraction open/closed status.
- Lightning Lane information.
- Last updated timestamp.

**Dependencies:** Availability of a suitable operational data API.

### FUT-006 — Crowd and Historical Trends

**Status:** Idea  
**Category:** Application Feature  
**Priority:** Low

**Description:**

Investigate displaying historical attraction trends or park crowd information to assist with trip planning.

**Potential Features:**
- Historical wait-time comparisons.
- Predicted crowd levels.
- Best times to experience attractions.
- Attraction reliability trends.

**Dependencies:** Reliable historical data and appropriate usage permissions.

### FUT-007 — Dining Availability Integration

**Status:** Idea  
**Category:** Application Feature  
**Priority:** Low

**Description:**

Investigate whether dining reservation availability can be incorporated into the application.

**Research Topics:**
- Availability of authorized reservation data sources.
- Restaurant matching and identifiers.
- Reservation links.
- Data refresh requirements.
- Access restrictions.

**Decision Needed:** Determine whether dining availability integration is practical and permitted.

## 5. Technical Improvements

### FUT-008 — Multi-Source Data Integration

**Status:** Idea  
**Category:** Architecture  
**Priority:** Low

**Description:**

Evaluate an architecture that supports multiple external Disney data providers without tying the application directly to one provider's response structure.

**Research Topics:**
- Standardized internal data models.
- Provider-specific integration services.
- External ID mapping.
- Scheduled data refreshes.
- Handling conflicting or unavailable data.
- Error handling and fallback behavior.

**Decision Needed:** Determine whether additional abstraction is justified as new data sources are introduced.

## 6. Backlog Maintenance

New ideas should be added using the next available FUT identifier.

Each item should include:

- **ID and Title**
- **Status**
- **Category**
- **Priority**
- **Description**
- **Research Topics or Potential Features**
- **Dependencies**, when applicable
- **Decision Needed**, when applicable

Review this backlog periodically as the application develops.

Items approved for implementation should be transferred into the active development plan or GitHub Issues, with a reference retained here when useful.

---

**Last Updated:** October 12, 2026