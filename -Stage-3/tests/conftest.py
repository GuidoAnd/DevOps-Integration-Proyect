import pytest
import sys
from pathlib import Path

project_root = Path(__file__).parent.parent
sys.path.insert(0, str(project_root))

from app import create_app

@pytest.fixture
def app():
    _app = create_app()
    _app.config.update({
        "TESTING": True,
    })
    yield _app

@pytest.fixture
def client(app):
    return app.test_client()