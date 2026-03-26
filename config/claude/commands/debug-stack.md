# Debug Messari Stack

You are debugging an issue that spans the Messari data stack: **dbt → API → Frontend**.

Read [references/messari-stack.md](references/messari-stack.md) first to understand the architecture and naming conventions.

## Execution Rules

- Do NOT launch Explore agents or broad codebase searches.
- Use Grep and Glob tools directly with the specific keyword from the user's request.
- If `$ARGUMENTS` is empty or does not contain a specific metric/entity/page name, ask the user before searching.
- If you must use Agent tools for deeper exploration, set `model: "sonnet"`.

## Search Strategy

1. Start with direct Grep/Glob using the keyword — this covers 90% of cases.
2. Only if direct search finds nothing, widen the search ONE layer at a time.
3. Never search all 3 repos simultaneously with broad patterns.

## Repos

| Layer | Path |
|-------|------|
| dbt models | `~/github/messari/dagster/services/dbt/projects/dwh_api/models/api/` |
| API catalogs | `~/github/messari/dwh-api-service/internal/domain/` |
| Frontend | `~/github/messari/messari-web/apps/web-app/src/` |

## Step 1: Classify the Issue

Ask the user if they haven't specified:
- **What's the symptom?** (missing data, wrong values, chart not rendering, API error, etc.)
- **Where is it observed?** (frontend chart, API response, Snowflake query, dbt build)
- **What metric/entity/page is affected?**

| Symptom | Likely Layer | Start Here |
|---------|-------------|------------|
| Chart shows no data | Frontend → API → dbt | Frontend config, then API catalog |
| Wrong values in chart | dbt → API | dbt model SQL, then aggregation config |
| API returns error/empty | API → dbt | API catalog YAML, then Snowflake table |
| Missing metric in catalog | API → dbt | Check if dbt model exists |
| dbt build fails | dbt | Use `/dbt-debug` instead |
| Column missing/wrong type | dbt → API | dbt model output, then catalog mapping |
| Metric available but not in UI | Frontend | Chart config or timeseries catalog fetch |

## Step 2: Trace the Data Path

Given a metric name, entity, or page — trace through all three layers using targeted searches:

### 2a. Find the dbt model
Use Glob: `**/*<keyword>*` in `~/github/messari/dagster/services/dbt/projects/dwh_api/models/api/`

Read the matching model SQL. Check:
- What columns does it output?
- What's the grain (one row per what)?
- Are there filters, joins, or CTEs that could drop data?
- Does it reference upstream models that might be broken?

### 2b. Find the API catalog
Use Grep for `<keyword>` across these paths (run in parallel):
- `~/github/messari/dwh-api-service/internal/domain/timeseries/catalog/`
- `~/github/messari/dwh-api-service/internal/domain/screener/catalog/`
- `~/github/messari/dwh-api-service/internal/domain/direct/catalog/`

Read the matching catalog YAML. Check:
- Does `base_model_name` / `database.table` match the dbt model name?
- Are `column_name` fields correct (match dbt output columns)?
- Are `type`, `format`, and aggregation operations correct?
- Is the metric in `metric_columns` (timeseries) or `columns` (screener/direct)?
- Is the tier/permissions blocking access?

### 2c. Find the frontend config
Use Grep for `<keyword>` across these paths (run in parallel):
- `~/github/messari/messari-web/apps/web-app/src/dashboards/`
- `~/github/messari/messari-web/apps/web-app/src/common/atomic-charts/`

Check:
- Is the metric slug correct (matches API catalog `slug` field)?
- Is the correct `dataset` (entity type) being used?
- Are `entities` populated with valid IDs?
- Is the `layerType` appropriate for the data?
- Are timeframes and intervals valid?

## Step 3: Common Cross-Layer Issues

### Naming Mismatch
The most common issue. Verify the chain:
```
dbt model filename → base_model_name in YAML → metric slug in frontend
```
- dbt: `api__timeseries__network_metrics_superchain_1d.sql`
- YAML: `base_model_name: network_metrics_superchain`
- Frontend: references the catalog by slug

### Aggregation Mismatch
API catalog aggregation settings affect how data appears:
- `time_bucket_aggregate_operation: mean` vs `sum` vs `last` — wrong choice = wrong values
- `group_aggregate_operation` — affects multi-entity queries

### Column Type Mismatch
- dbt outputs `VARCHAR` but catalog expects `float64` → API error or NULL
- dbt outputs `DOUBLE` but catalog has `type: string` → wrong display

### Missing Data
Trace backwards:
1. **Frontend**: Is the API call being made? Check network tab.
2. **API**: Query Snowflake directly — does the table have data?
   ```sql
   SELECT * FROM <schema>.<table> LIMIT 10;
   ```
3. **dbt**: Does the model build? Is upstream data populated?

### Interval Mismatch
- dbt model exists for `1d` but not `1h` — catalog lists `1h` as available → empty response
- Check which interval models exist with Glob: `*<name>*` in the timeseries directory

## Step 4: Fix

After identifying the layer and issue:

| Issue Location | Fix |
|---------------|-----|
| dbt model | Edit SQL in dagster repo, rebuild with `dbt build -s <model>` |
| API catalog | Edit YAML in dwh-api-service repo |
| Frontend config | Edit TypeScript in messari-web repo |
| Multiple layers | Fix bottom-up: dbt → API → frontend |

## Step 5: Verify

1. **dbt**: `dbt show -s <model> --limit 10` — confirm correct output
2. **API**: Test with curl or check `DUMP_SQL=true` mode in dwh-api-service
3. **Frontend**: Check browser network tab and rendered chart

## User's request

$ARGUMENTS
