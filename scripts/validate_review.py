import json
from pathlib import Path
from openapi_spec_validator import validate_spec

root = Path(__file__).resolve().parents[1] / "docs"
api = json.loads((root / "openapi.yaml").read_text())
validate_spec(api)
states = json.loads((root / "contracts/state-machines.json").read_text())
schemas = api["components"]["schemas"]
for key, schema, prop in [("execution","ChildRun","status"),("financial","ChildRun","financial_status"),("parent","Run","status")]:
    graph = states[key]
    assert set(graph) == set(schemas[schema]["properties"][prop]["enum"]), key
    assert all(dest in graph for edges in graph.values() for dest in edges), key
    if key != "parent":
        assert set(states["terminal_"+key]) == {k for k,v in graph.items() if not v}, key
rows = json.loads((root / "contracts/traceability.json").read_text())
assert len({r["id"] for r in rows}) == len(rows)
assert len({r["test"] for r in rows}) == len(rows)
for row in rows:
    assert row["id"] in (root / row["source"]).read_text(), row["id"]
    assert row["criterion"].strip() and 2 <= row["issue"] <= 18
print(f"OpenAPI, state graphs and {len(rows)} traceability rows validated")
