import json
import pytest
from unittest.mock import patch

## Integration tests 

def test_index_route(client):
    resp = client.get("/")
    assert resp.status_code == 200
    assert b"Bulbasaur" in resp.data

#Liveness
def test_health_endpoint(client):
    resp = client.get("/health")
    assert resp.status_code == 200
    assert resp.json == {"status": "ok"}

def test_pokemon_detail_route(client):
    resp = client.get("/charizard")
    assert resp.status_code == 200
    assert b"Charizard" in resp.data


## Unitary tests

def test_get_pokemon_redirect(client):
    resp = client.post("/get_pokemon", data={"pokemon": "Pikachu"}, follow_redirects=False)
    assert resp.status_code == 302
    assert "/pikachu" in resp.headers["Location"]

@patch('requests.get')
def test_pokemon_api_logic(mock_get, client):
    mock_get.return_value.json.return_value = {
        "name": "bulbasaur",
        "id": 1,
        "stats": [],
        "types": [],
        "sprites": {"front_default": "url_pika"},
        "weight": 69
    }
    mock_get.return_value.status_code = 200

    resp= client.get("/bulbasaur")
    assert resp.status_code == 200
    assert b"Bulbasaur" in resp.data