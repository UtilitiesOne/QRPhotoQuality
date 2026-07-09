# QR Photo Quality

Static field photo helper for UtilitiesOne foremen and field technicians.

## Files

- `index.html`: phone-first photo helper.
- `flyer.html`: print-ready handout for foremen and technicians.
- `gallery.html`: marketing-facing photo gallery.
- `qr-config.json`: QR destination config.
- `make_assets.py`: regenerates the QR assets.
- `assets/field-photo-helper-qr.svg`: QR used in the flyer.
- `assets/field-photo-helper-qr.png`: PNG QR backup.

## How it works

The flyer avoids asking crews to change camera settings. The QR opens a simple photo helper. The helper uses the phone's native camera capture flow, then checks the selected photo for three common failure points:

- Low resolution
- Low light
- Blur

The helper asks for the division or brand, location, and photo type. It checks photo quality, queues photos, and submits them to Supabase Storage for the marketing team.

## Live URL

After GitHub Pages deploys, the helper should be available at:

`https://utilitiesone.github.io/QRPhotoQuality/`

The flyer is available at:

`https://utilitiesone.github.io/QRPhotoQuality/flyer.html`

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