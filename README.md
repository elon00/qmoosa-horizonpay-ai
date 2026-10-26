# QMOOSA HorizonPay AI ($QHPA)
[![CI/CD Pipeline](https://github.com/elon00/qmoosa-horizonpay-ai/actions/workflows/ci-cd-pipeline.yml/badge.svg)](https://github.com/elon00/qmoosa-horizonpay-ai/actions/workflows/ci-cd-pipeline.yml)
[![Reality Check](https://img.shields.io/badge/Reality%20Check-100%2F100%20GENUINE%20GREEN-emerald.svg)](tests/reality_check_harness.py)
[![Hackathon](https://img.shields.io/badge/Hackathon-HashKey%20Chain%20Horizon%20Hackathon-blue.svg)]()
[![PQC Standard](https://img.shields.io/badge/NIST-FIPS%20203%2F204-purple.svg)]()

> **Autonomous AI-agent payments, stablecoin settlement, x402 monetized APIs, treasury authorization and transaction monitoring.**

---

## 🏆 Hackathon Profile
- **Target Event:** HashKey Chain Horizon Hackathon
- **Track:** AI Agent Trading & Agent Payments / A2A Settlement
- **Deadline:** November 1, 2026 at 21:30 IST
- **Prize Pool:** 10,000 USDT
- **Blockchain:** HashKey Chain (EVM)

---

## 🚀 Key Features
- **64-bit Conway State Engine:** Deterministic cellular automaton state machine running 10,000 cycles in zero-dependency Rust.
- **Native Smart Contract:** `HorizonPayEscrow.sol` optimized for HashKey Chain (EVM).
- **Agentic Service & x402 Gateway:** Autonomous Python payment client in `src/agent_payment_service.py`.
- **Interactive QUX Launchpad:** Full-stack responsive HTML5 dashboard with Conway visualizer and Web4 QR generation in `index.html`.
- **Model Context Protocol (MCP):** 2 native tools exposed via `mcp.json`.

---

## 🧪 Testing & Verification
```bash
# Run 5-Gate Reality Check Test Harness
python tests/reality_check_harness.py

# Run Full Unit & Integrity Test Suite
python -m unittest tests/test_suite.py
```
