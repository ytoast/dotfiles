# Chart & Dashboard Builder

You are helping create charts and dashboards for the Messari platform. This involves up to 3 layers depending on whether the data already exists.

Read [references/messari-stack.md](references/messari-stack.md) first for architecture context.

## Repos

| Layer | Path |
|-------|------|
| dbt models | `~/github/messari/dagster/services/dbt/projects/dwh_api/models/api/` |
| API catalogs | `~/github/messari/dwh-api-service/internal/domain/` |
| Frontend | `~/github/messari/messari-web/apps/web-app/src/` |

## Step 1: Understand What's Needed

Ask the user if they haven't specified:
- **What data to visualize?** (metric name, entity type, description)
- **Chart type?** (line, area, bar, stacked area, stacked bar, pie, KPI, heatmap, leaderboard, screener table)
- **Single entity or comparison?** (one asset vs. multiple assets)
- **Time granularity?** (5m, 15m, 30m, 1h, 6h, 1d, 1w)

## Step 2: Check What Already Exists

### Check if the metric is already in the API
```bash
# Search timeseries catalogs for the metric
grep -rl "<metric_keyword>" ~/github/messari/dwh-api-service/internal/domain/timeseries/catalog/
grep -l "<metric_keyword>" ~/github/messari/dwh-api-service/internal/domain/screener/catalog/dataset/
grep -l "<metric_keyword>" ~/github/messari/dwh-api-service/internal/domain/direct/catalog/
```

If found → skip to Step 5 (frontend config only).

### Check if the dbt model exists but isn't in the API yet
```bash
find ~/github/messari/dagster/services/dbt/projects/dwh_api/models/api/ -name "*<keyword>*"
```

If found → skip to Step 4 (API catalog + frontend config).

### Check if raw data exists
```bash
# Search for source data in dagster
grep -rl "<keyword>" ~/github/messari/dagster/services/dbt/projects/*/models/*/sources.yml
find ~/github/messari/dagster/services/dbt/projects/*/models/ -name "*<keyword>*"
```

If found → start at Step 3 (dbt model + API catalog + frontend).

If nothing found → inform the user that the data pipeline needs to be built first (out of scope for this tool).

## Step 3: Create/Modify dbt Model

**Only if the metric doesn't exist yet as an API model.**

Determine which API domain the model belongs to:

| Domain | When to use | dbt path |
|--------|------------|----------|
| Timeseries | Time-series metrics (price, volume, TVL over time) | `api/timeseries/` |
| Screener | Entity attributes and filterable columns | `api/screener_<entity>/` |
| Direct | Custom endpoints for specific pages | `api/direct/` |

### Timeseries model template
Follow existing patterns. Read a similar model first:
```bash
ls ~/github/messari/dagster/services/dbt/projects/dwh_api/models/api/timeseries/
```

Key requirements:
- Filename: `api__timeseries__<base_model_name>_<interval>.sql`
- Must output: entity column, timestamp, metric columns
- Follow SQL style: UPPERCASE keywords, lowercase columns, leading commas

### Screener model template
```bash
ls ~/github/messari/dagster/services/dbt/projects/dwh_api/models/api/screener_asset/
```

Key requirements:
- Filename: `api__screener_<entity>__<table_name>.sql`
- `translation: selection` for scalar columns, `translation: association` for one-to-many

## Step 4: Create/Modify API Catalog

**Only if the metric isn't in the API catalog yet.**

### For timeseries metrics

Read an existing catalog for reference:
```bash
cat ~/github/messari/dwh-api-service/internal/domain/timeseries/catalog/asset.yaml
```

Add a new `metric_columns` entry to an existing catalog, or create a new catalog file if it's a new entity type. Required fields:

```yaml
metric_columns:
  - id: Human Readable Name        # Display name in API
    slug: kebab-case-slug           # URL-safe identifier
    name: Human Readable Name
    description: What this metric measures.
    column_name: snake_case_column  # Must match dbt model output column
    time_bucket_aggregate_operation: mean  # mean|sum|last|first|max|min
    group_aggregate_operation: sum         # sum|mean|count
    format: currency                      # currency|number|percentage|string
    type: float64                         # float64|int32|string
```

### For screener columns

Read an existing catalog:
```bash
cat ~/github/messari/dwh-api-service/internal/domain/screener/catalog/dataset/asset.yaml
```

Add a new `columns` entry under the appropriate `models` block:

```yaml
columns:
  - id: Display Name
    short_name: Short Name
    tooltip: Description for tooltip.
    column_type: field
    format: number                   # number|currency|percentage|string|entity_list|string_list
    type: float64
    database:
      column_name: dbt_column_name
```

### For direct endpoints

```bash
cat ~/github/messari/dwh-api-service/internal/domain/direct/catalog/home-assets-1d.yaml
```

## Step 5: Generate Frontend Chart Config

### Timeseries Chart (AtomicTimeseriesFormData)

Generate the config object based on the user's requirements:

```typescript
const chartConfig: AtomicTimeseriesFormData = {
  title: 'Chart Title',
  description: 'What this chart shows',
  layers: [
    {
      dataset: 'asset',              // 'asset'|'project'|'exchange'|'network'|'seriesless'
      axis: 'left',                  // 'left'|'right' (use right for single-axis charts)
      layerType: 'line',             // 'line'|'area'|'bar'
      entities: ['entity-uuid-1'],   // Entity IDs
      metric: 'metric-slug',         // From timeseries catalog slug
      seriesOrder: 'firstValueDesc', // Series ordering
    },
  ],
  visibleTimeframes: ['1W', '1M', '3M', '6M', '1Y'],
  defaultTimeframe: '1Y',
  colorPalette: [
    { colorCode: '#6366F1' },        // Indigo
    { colorCode: '#F59E0B' },        // Amber
    { colorCode: '#10B981' },        // Emerald
  ],
};
```

**Layer type guidance:**
| Data Pattern | Recommended Layer |
|-------------|------------------|
| Single metric over time | `line` |
| Volume/flow data | `bar` |
| Cumulative/total over time | `area` |
| Multiple metrics sharing space | `stacked-area` or `stacked-bar` |
| Comparison across entities | Multiple layers, one per entity |

**Multi-axis example** (price + volume):
```typescript
layers: [
  { axis: 'left', layerType: 'line', metric: 'close', dataset: 'asset', entities: ['...'], seriesOrder: 'firstValueDesc' },
  { axis: 'right', layerType: 'bar', metric: 'volume', dataset: 'asset', entities: ['...'], seriesOrder: 'firstValueDesc' },
]
```

### KPI Card
```typescript
const kpiConfig = {
  type: 'kpi',
  title: 'Total Value Locked',
  dataset: 'asset',
  catalogId: 'timeseries-catalog-slug',
  entityId: 'entity-uuid',
  aggregateOperation: 'last',     // last|sum|mean|max|min
  timeframe: '1D',
  includeChange: true,
  includeSparkline: true,
  valueFormat: { type: 'automatic' },
};
```

### Screener Table
```typescript
const screenConfig = {
  type: 'screen',
  screenSlug: 'asset',             // Screener catalog slug
  pageSize: 25,
  title: 'Top Assets by Market Cap',
};
```

## Step 6: Summary

After generating configs, provide a summary of what was created/modified:

| Layer | File | Action |
|-------|------|--------|
| dbt | `path/to/model.sql` | Created/Modified |
| API | `path/to/catalog.yaml` | Added metric column |
| Frontend | Config object | Generated (paste into dashboard builder) |

Remind the user:
- dbt model needs to be built: `dbt build -s <model_name>`
- API service needs restart to pick up catalog changes
- Frontend chart config can be pasted into the dashboard builder UI or saved as a chart in the library

## User's request

$ARGUMENTS
