from pathlib import Path
import json

import segno


ROOT = Path(__file__).resolve().parent
CONFIG = ROOT / "qr-config.json"
ASSETS = ROOT / "assets"


QR_TARGETS = {
    "u1_helper_url": ["field-photo-helper-qr", "field-photo-helper-u1-qr"],
    "e5_helper_url": ["field-photo-helper-e5-qr"],
}


def save_qr(url: str, stem: str) -> None:
    qr = segno.make(url, error="h")
    qr.save(ASSETS / f"{stem}.svg", scale=9, border=2, dark="#101820", light="#ffffff")
    qr.save(ASSETS / f"{stem}.png", scale=9, border=2, dark="#101820", light="#ffffff")
    print(f"QR generated for {stem}: {url}")


def main() -> None:
    config = json.loads(CONFIG.read_text(encoding="utf-8"))
    ASSETS.mkdir(exist_ok=True)

    for key, stems in QR_TARGETS.items():
        helper_url = config[key].strip()
        if not helper_url:
            raise SystemExit(f"qr-config.json {key} is empty")
        for stem in stems:
            save_qr(helper_url, stem)


if __name__ == "__main__":
    main()