from pathlib import Path
import json

import segno


ROOT = Path(__file__).resolve().parent
CONFIG = ROOT / "qr-config.json"
ASSETS = ROOT / "assets"


def main() -> None:
    config = json.loads(CONFIG.read_text(encoding="utf-8"))
    helper_url = config["helper_url"].strip()
    if not helper_url:
        raise SystemExit("qr-config.json helper_url is empty")

    ASSETS.mkdir(exist_ok=True)
    qr = segno.make(helper_url, error="h")
    qr.save(ASSETS / "field-photo-helper-qr.svg", scale=9, border=2, dark="#101820", light="#ffffff")
    qr.save(ASSETS / "field-photo-helper-qr.png", scale=9, border=2, dark="#101820", light="#ffffff")
    print(f"QR generated for: {helper_url}")


if __name__ == "__main__":
    main()
