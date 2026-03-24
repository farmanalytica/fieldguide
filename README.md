# Field Guide 2.0

Field Guide is a QGIS plugin for map point capture, polygon-based sampling, CSV and GPX exchange, temporary point-layer creation, Google Maps route opening, and mobile-friendly PDF field reports.

Version 2.0 expands the plugin from point capture into a fuller field workflow with polygon feature sampling, density-based sampling, selected-mark deletion, GPS export, temporary layer output, and improved spatial distribution methods.

## Highlights

- Capture points directly on the map with numbered markers and WGS84 storage.
- Delete a selected mark from the session list, remove the last mark, or clear the full session.
- Add manual WGS84 coordinates with validation.
- Export and import CSV point lists.
- Export GPS-compatible GPX waypoint files for handheld devices such as Garmin units.
- Add the current marks to the QGIS project as a temporary point layer.
- Open ordered Google Maps routes with automatic chunking for longer sessions.
- Generate PDF reports with canvas snapshot, route links, and per-point mobile links.
- Generate marks inside polygon features with fixed counts or density by area.

## Sampling In 2.0

Field Guide 2.0 adds polygon feature sampling for field and soil workflows.

- `Fixed marks per feature` supports `1` to `50` marks.
- `1` mark per feature uses the feature centroid.
- Multi-point sampling can use:
  - `Spread optimized`
  - `Systematic grid`
  - `Zigzag transect`
- `Density by area` lets you define rules such as `1 mark per hectare` or `1 mark per 3 hectares`.
- Density mode resolves the mark count per feature from polygon area and still falls back to the centroid when the result is a single mark.

These methods were tuned to improve internal spacing, respect feature shape, and produce more practical field layouts.

## Main Features

### Capture points on the map

1. Open the plugin.
2. Enable capture mode.
3. Click the map to add points.
4. Each point is stored in WGS84 and shown with marker + numeric label.

### Manage the live session

- `Delete selected mark` removes the selected entry from the session list.
- `Remove last mark` removes only the most recent mark.
- `Clear marks` removes all markers, labels, and stored coordinates.

### Add coordinates manually

1. Fill in `Latitude` and `Longitude`.
2. Click `Add coordinate`.
3. The plugin validates:
   - latitude between `-90` and `90`
   - longitude between `-180` and `180`

### Generate marks from polygon features

1. Select a polygon layer in the `Capture` section.
2. Choose the sampling quantity mode:
   - `Fixed marks per feature`
   - `Density by area`
3. For fixed counts, choose the number of marks from `1` to `50`.
4. For density mode, choose the hectares-per-mark rule, such as `1.0 ha` or `3.0 ha`.
5. For a single mark, the plugin uses the centroid.
6. For multi-point results, choose one distribution method:
   - `Spread optimized`: stronger spatial spread inside irregular polygons.
   - `Systematic grid`: more even, orientation-aware spacing.
   - `Zigzag transect`: field-style serpentine pattern guided by feature size and shape.
7. Append to or replace the current session list.

### CSV and GPX export

- Exported CSV columns:
  - `order`
  - `longitude`
  - `latitude`
- Import expects `longitude` and `latitude` headers.
- Decimal values with `.` or `,` are accepted.
- GPX export writes WGS84 waypoints with short portable names like `FG001`.
- When 2 or more points exist, GPX export also includes an ordered route section.

### Add temporary point layer

- `Add Temporary Layer` creates a memory point layer directly in the current QGIS project.
- The layer geometry uses the current project CRS for convenient map work.
- Each feature includes:
  - `order`
  - `name`
  - `longitude`
  - `latitude`
- Repeated exports create unique layer names instead of overwriting earlier temporary layers.

### PDF generation

The generated PDF includes:

- current canvas snapshot
- Google Maps route links
- numbered point list
- large per-point mobile links

### Google Maps route opening

- Opens all captured points as ordered stops.
- Splits longer routes into smaller chunks for better compatibility.

## Project Structure

- `__init__.py`: plugin entrypoint.
- `guia_de_campo.py`: lifecycle and QGIS integration.
- `guia_de_campo_dialog.py`: main UI.
- `guia_de_campo_service.py`: actions, validation, sampling, routes, and export logic.
- `modules/canvas_marker_tool.py`: canvas markers, labels, and point state.
- `modules/map_tools.py`: map utility helpers.
- `modules/pdf/`: PDF generation pipeline.
- `metadata.txt`: QGIS Plugin Manager metadata.

## Runtime Requirements

- QGIS 3.x with embedded Python.
- Must run inside the QGIS environment.

## Local Development

1. Copy or clone the plugin into the QGIS plugins directory.
2. Common Windows path:
   `C:\Users\<usuario>\AppData\Roaming\QGIS\QGIS3\profiles\default\python\plugins\fieldguide`
3. Restart QGIS or use Plugin Reloader.
4. Enable the plugin from `Plugins > Manage and Install Plugins`.

## Changelog

### 2.0

- Added polygon feature sampling with configurable marks per feature.
- Added density-based polygon sampling using hectares-per-mark rules.
- Added centroid, spread-optimized, systematic grid, and zigzag transect methods.
- Added selected-mark deletion from the session list.
- Added GPX export for GPS handheld compatibility.
- Added temporary point-layer export directly into the current QGIS project.
- Improved spatial distribution behavior for zigzag and grid sampling.
- Refined Portuguese UI wording.
- Updated documentation, metadata, and website content.

### 1.0

- Initial release with point capture, CSV import/export, route opening, and PDF generation.
