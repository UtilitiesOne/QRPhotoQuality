# QR Photo Quality

Static field photo helper for UtilitiesOne foremen and field technicians.

## Files

- `index.html`: phone-first photo helper.
- `flyer.html`: U1 print-ready pocket flyer source.
- `flyer-print.pdf`: U1 printable pocket flyer PDF.
- `flyer-e5.html`: E5 print-ready pocket flyer source.
- `flyer-e5-print.pdf`: E5 printable pocket flyer PDF.
- `gallery.html`: marketing-facing photo gallery.
- `qr-config.json`: U1 and E5 QR destination config.
- `make_assets.py`: regenerates the QR assets.
- `assets/field-photo-helper-u1-qr.svg`: U1 QR used in the U1 flyer.
- `assets/field-photo-helper-e5-qr.svg`: E5 QR used in the E5 flyer.

## How it works

The printed flyer avoids asking crews to change camera settings. The QR opens the photo helper directly. The helper uses the phone's native camera capture flow, then checks the selected photo for three common failure points:

- Low resolution
- Low light
- Blur

The U1 helper asks for the U1 division, location, and photo type. The E5 helper locks the division to E5 so E5 foremen and technicians do not need to choose from the U1 division list. Both helpers check photo quality, queue photos, and submit them to the same Supabase Storage bucket and metadata table for the marketing team.

## Live URL

After GitHub Pages deploys, the U1 helper should be available at:

`https://utilitiesone.github.io/QRPhotoQuality/`

The E5 helper should be available at:

`https://utilitiesone.github.io/QRPhotoQuality/e5.html`

The U1 printable flyer PDF is available at:

`https://utilitiesone.github.io/QRPhotoQuality/flyer-print.pdf`

The E5 printable flyer PDF is available at:

`https://utilitiesone.github.io/QRPhotoQuality/flyer-e5-print.pdf`

The marketing gallery is available at:

`https://utilitiesone.github.io/QRPhotoQuality/gallery.html`

## Updating the QR

1. Edit `qr-config.json`.
2. Run `python make_assets.py`.
3. Commit the regenerated files under `assets/`.

## Supabase setup

Run `supabase-setup.sql` in the Supabase SQL Editor before using the submit button. It creates:

- Storage bucket: `field-photos`, organized as `division/location/photo-type/file`
- Metadata table: `photo_submissions`
- Public insert policy for photo uploads
- Public insert policy for metadata rows

Run `supabase-gallery-access.sql` after `supabase-setup.sql` if the marketing gallery should read submitted photos without opening Supabase directly. It adds read policies for metadata and signed image links.

The public helper and gallery use the Supabase publishable key. Do not put a secret key in this repository.

## Field rule

Every site should have at least three usable marketing photos:

1. Wide: full site context, crew scale, equipment, and surroundings.
2. Medium: crew, equipment, materials, or active work from a useful angle.
3. Close-up: a clean detail that makes the work look professional and easy to understand.