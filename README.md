# QR Photo Quality

Static field photo helper for UtilitiesOne foremen and field technicians.

## Files

- `index.html`: phone-first photo helper.
- `flyer.html`: print-ready handout for foremen and technicians.
- `qr-config.json`: QR destination config.
- `make_assets.py`: regenerates the QR assets.
- `assets/field-photo-helper-qr.svg`: QR used in the flyer.
- `assets/field-photo-helper-qr.png`: PNG QR backup.

## How it works

The flyer avoids asking crews to change camera settings. The QR opens a simple photo helper. The helper uses the phone's native camera capture flow, then checks the selected photo for three common failure points:

- Low resolution
- Low light
- Blur

The helper does not upload photos. It asks for the division or brand, checks photo quality, and gives a save/share action so the workflow can be connected later to the company's normal marketing, campaign, or social content process.

## Live URL

After GitHub Pages deploys, the helper should be available at:

`https://utilitiesone.github.io/QRPhotoQuality/`

The flyer is available at:

`https://utilitiesone.github.io/QRPhotoQuality/flyer.html`

## Updating the QR

1. Edit `qr-config.json`.
2. Run `python make_assets.py`.
3. Commit the regenerated files under `assets/`.

## Field rule

Every job should have at least three usable photos:

1. Wide: full site context.
2. Medium: actual work area.
3. Close-up: finished detail, label, damage, connection, or issue.