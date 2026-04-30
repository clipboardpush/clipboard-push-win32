from pathlib import Path


config_cpp = Path("src/core/Config.cpp").read_text(encoding="utf-8")

expected = 'm_data.lan_timeout = j.value("lan_timeout", m_data.lan_timeout);'
if expected not in config_cpp:
    raise SystemExit("Config::Load() does not read lan_timeout from config.json")

print("Config::Load() reads lan_timeout")
