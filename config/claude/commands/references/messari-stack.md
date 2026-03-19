# Messari Stack Reference

## Repository Locations

| Layer | Repo | Path |
|-------|------|------|
| **Data** | dagster | `~/github/messari/dagster` |
| **API** | dwh-api-service | `~/github/messari/dwh-api-service` |
| **Frontend** | messari-web | `~/github/messari/messari-web` |

## Data Flow

```
dbt model (SQL) → Snowflake table → API catalog (YAML) → Frontend config (TypeScript)
```

1. **dbt model** defines the SQL that materializes a Snowflake table
2. **API catalog** (YAML) maps Snowflake columns to API fields
3. **Frontend** fetches from the API and renders charts/dashboards

---

## Naming Conventions (Cross-Repo Mapping)

### Timeseries

| Component | Pattern | Example |
|-----------|---------|---------|
| dbt model | `api__timeseries__<base_model_name>_<interval>.sql` | `api__timeseries__asset_1d.sql` |
| dbt location | `services/dbt/projects/dwh_api/models/api/timeseries/` | |
| Snowflake schema | `timeseries` (or `timeseries_<entity>`) | `timeseries_asset` |
| API catalog | `internal/domain/timeseries/catalog/<slug>.yaml` | `asset.yaml` |
| YAML key field | `base_model_name` | `asset` |
| Frontend metric ref | `catalogId` string in chart config | |

### Screener

| Component | Pattern | Example |
|-----------|---------|---------|
| dbt model | `api__screener_<entity>__<table_name>.sql` | `api__screener_asset__entity.sql` |
| dbt location | `services/dbt/projects/dwh_api/models/api/screener_<entity>/` | |
| Snowflake schema | `screener_<entity>` | `screener_asset` |
| API catalog | `internal/domain/screener/catalog/dataset/<entity>.yaml` | `asset.yaml` |
| YAML key fields | `database.schema`, `database.table` | |

### Direct (Custom Endpoints)

| Component | Pattern | Example |
|-----------|---------|---------|
| dbt model | `api__direct__<table_name>.sql` | `api__direct__home_assets_1d.sql` |
| dbt location | `services/dbt/projects/dwh_api/models/api/direct/` | |
| Snowflake schema | `direct` | |
| API catalog | `internal/domain/direct/catalog/<slug>.yaml` | `home-assets-1d.yaml` |

---

## Key File Locations

### dagster (dbt models)
```
services/dbt/projects/dwh_api/models/api/
├── timeseries/          # Timeseries API models
├── screener_asset/      # Asset screener models
├── screener_network/    # Network screener models
├── direct/              # Direct API models
└── ...
```

### dwh-api-service (API catalogs)
```
internal/domain/
├── timeseries/catalog/*.yaml       # Timeseries catalogs
├── screener/catalog/dataset/*.yaml # Screener catalogs
├── direct/catalog/*.yaml           # Direct endpoint catalogs
└── */handler/                      # HTTP handlers
```

### messari-web (frontend)
```
apps/web-app/src/
├── dashboards/
│   ├── modules/
│   │   ├── atomic-chart/    # Chart modules (timeseries, pie)
│   │   ├── kpi/             # KPI card modules
│   │   ├── heatmap/         # Heatmap modules
│   │   ├── leaderboard/     # Leaderboard modules
│   │   └── screen/          # Screener table modules
│   └── apis/                # Dashboard data fetching
├── common/atomic-charts/    # Shared chart components & hooks
└── ...

packages/
├── chart-engine/            # Core charting library (D3-based)
├── dwh-service/             # DWH API client
├── dwh-timeseries-service/  # Timeseries API client
└── timeframes/              # Timeframe constants & types
```

---

## API Catalog YAML Structures

### Timeseries Catalog
```yaml
name: Asset
slug: asset
base_model_name: asset              # Maps to dbt: api__timeseries__asset_<interval>
schema: timeseries
entity_column_name: entity
entity_type: asset
intervals: [5m, 15m, 30m, 1h, 6h, 1d, 1w]
default_interval: 1d
offload:
  enabled: true
  retained_latest_chunks: 600
tier:
  view: unpaid
qualitative_columns:
  - id: Asset ID
    slug: id
    column_name: asset_id
    format: uuid
    type: string
metric_columns:
  - id: Close Price
    slug: close
    column_name: close_vwap
    time_bucket_aggregate_operation: mean
    format: currency
    type: float64
```

### Screener Catalog
```yaml
name: asset
key_column_name: asset_id
entity:
  schema: screener_asset
  model: entity
tier:
  view: unpaid
  export: lite
default_sort:
  column_id: Latest Circulating Marketcap
  direction: desc
models:
  - database:
      schema: screener_asset
      table: entity                 # Maps to dbt: api__screener_asset__entity
    translation: selection          # or "association" for one-to-many
    columns:
      - id: Asset ID
        column_type: field
        format: uuid
        type: string
        database:
          column_name: asset_id
```

### Direct Catalog
```yaml
name: Home Assets 1D
slug: home-assets-1d
database:
  schema: direct
  table: home_assets_1d             # Maps to dbt: api__direct__home_assets_1d
columns:
  - name: Price
    slug: price
    type: float64
    database:
      column: price
```

---

## Frontend Chart Types

### AtomicTimeseriesFormData (Dashboard Chart Config)
```typescript
type AtomicTimeseriesFormData = {
  title?: string;
  description?: string;
  footnote?: string;
  layers: Array<{
    axis: 'left' | 'right';
    dataset: 'asset' | 'project' | 'exchange' | 'network' | 'seriesless';
    entities: Array<string>;          // Entity IDs (UUIDs)
    layerType: 'line' | 'area' | 'bar';
    metric: string;                   // Metric slug from timeseries catalog
    networkIds?: Array<string>;
    seriesOrder: AtomicTimeseriesSeriesOrder;
    showAsPercentageOfTotal?: boolean;
  }>;
  visibleTimeframes: Array<PresetTimeframe>;  // '6H'|'12H'|'1D'|'1W'|'1M'|'3M'|'6M'|'YTD'|'1Y'|'3Y'|'5Y'|'ALL'
  defaultTimeframe: PresetTimeframe | null;
  colorPalette: Array<{ colorCode: string }>;
  leftAxis?: { minExtent: number | null; maxExtent: number | null };
  rightAxis?: { minExtent: number | null; maxExtent: number | null };
};
```

### Dashboard Module Types
```typescript
// KPI Module
{ type: 'kpi', dataset, catalogId, entityId?, aggregateOperation?, timeframe?, interval? }

// Screen Module (Screener Table)
{ type: 'screen', screenSlug, viewId?, pageSize, title, description? }

// Atomic Chart Module
{ type: 'atomicChart', chartConfig?, chartId?, source: 'library'|'chartId'|'json'|'builder' }

// Heatmap Module
{ type: 'heatmap', ... }

// Leaderboard Module
{ type: 'leaderboard', ... }
```

---

## Common Column Formats

| Format | Used in | Description |
|--------|---------|-------------|
| `uuid` | Screener, Timeseries | Entity ID |
| `string` | All | Text field |
| `currency` | Timeseries | USD values |
| `float64` | All | Decimal numbers |
| `int32` | Direct | Integer values |
| `entity_json` | Screener | JSON entity object |
| `entity_list` | Screener | Array of entity refs |
| `string_list` | Screener | Array of strings |
| `link_list` | Screener | Array of URL links |

## Aggregation Operations

| Operation | Context |
|-----------|---------|
| `time_bucket_aggregate_operation` | How to aggregate within a time bucket: `mean`, `sum`, `last`, `first`, `max`, `min` |
| `group_aggregate_operation` | How to aggregate across entities: `sum`, `mean`, `count`, `list` |
| `group_aggregate_operations` (screener) | Available aggs: `list`, `count`, `sum`, `mean`, `median`, `first`, `last`, `max`, `min` |
