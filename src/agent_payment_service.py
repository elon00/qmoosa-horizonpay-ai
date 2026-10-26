# -*- coding: utf-8 -*-
import hashlib
import time
import json

class HorizonPaymentAgent:
    def __init__(self, agent_id: str, spend_limit: float):
        self.agent_id = agent_id
        self.spend_limit = spend_limit
        self.total_spent = 0.0

    def authorize_x402_payment(self, service_url: str, required_amount: float) -> dict:
        if self.total_spent + required_amount > self.spend_limit:
            return {"status": "REJECTED", "reason": "Exceeds spend limit"}
        
        self.total_spent += required_amount
        tx_hash = hashlib.sha256(f"{self.agent_id}:{service_url}:{time.time()}".encode()).hexdigest()
        receipt = {
            "status": "APPROVED",
            "agent_id": self.agent_id,
            "service_url": service_url,
            "amount_paid": required_amount,
            "currency": "USDT",
            "chain": "HashKey Chain",
            "tx_hash": f"0x{tx_hash}",
            "timestamp": int(time.time())
        }
        return receipt

if __name__ == "__main__":
    agent = HorizonPaymentAgent("agent_hashkey_alpha", 500.0)
    res = agent.authorize_x402_payment("https://api.qmoosa.io/v1/inference", 2.50)
    print("Agent Payment Receipt:", json.dumps(res, indent=2))
