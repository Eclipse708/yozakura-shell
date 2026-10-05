#!/usr/bin/env python3
"""Add the Yozakura scheme to Windows Terminal and point the Ubuntu profile at it.

Idempotent: re-running replaces the scheme and profile settings in place.
A timestamped backup of settings.json is written next to it first.
"""
import glob
import json
import shutil
import sys
import time
from pathlib import Path

HERE = Path(__file__).resolve().parent
FONT_FACE = "JetBrainsMono Nerd Font"
PROFILE_NAME = "Ubuntu"

candidates = glob.glob(
    "/mnt/c/Users/*/AppData/Local/Packages/Microsoft.WindowsTerminal_*/LocalState/settings.json"
)
if not candidates:
    sys.exit("Windows Terminal settings.json not found")
settings_path = Path(candidates[0])

scheme = json.loads((HERE / "yozakura.json").read_text(encoding="utf-8"))
raw = settings_path.read_text(encoding="utf-8-sig")
settings = json.loads(raw)

backup = settings_path.with_name(f"settings.json.bak-{time.strftime('%Y%m%d-%H%M%S')}")
shutil.copy2(settings_path, backup)

schemes = settings.setdefault("schemes", [])
schemes[:] = [s for s in schemes if s.get("name") != scheme["name"]]
schemes.append(scheme)

profiles = settings.setdefault("profiles", {}).setdefault("list", [])
target = next((p for p in profiles if p.get("name") == PROFILE_NAME), None)
if target is None:
    sys.exit(f"profile {PROFILE_NAME!r} not found")

target["colorScheme"] = scheme["name"]
target["font"] = {"face": FONT_FACE, "size": 11}
target["cursorShape"] = "bar"
target["padding"] = "12, 8, 12, 8"
target["intenseTextStyle"] = "bright"

settings_path.write_text(json.dumps(settings, indent=4, ensure_ascii=False) + "\n", encoding="utf-8")
print(f"updated {settings_path}\nbackup  {backup}")
