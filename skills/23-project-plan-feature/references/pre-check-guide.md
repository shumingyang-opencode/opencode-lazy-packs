# Pre/Post Check Guide — Analysis Docs Audit

## Pre-Check (Before Planning)
1. Run `codebase-memory-mcp index_repository` (mode=full, persistence=true)
2. Use `get_architecture` + `search_graph` to discover code structure
3. Cross-reference against analysis docs
4. If inconsistencies found: STOP and fix docs first

## Post-Check (After Implementation)
1. Re-run `codebase-memory-mcp index_repository`
2. Check for new classes/modules not in analysis docs
3. Request updates to analysis docs as needed
