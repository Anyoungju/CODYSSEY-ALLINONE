"""Unit tests for Codyssey login target selection."""

from __future__ import annotations

import sys
import unittest
from pathlib import Path


SCRIPTS_DIR = Path(__file__).resolve().parents[1] / "scripts"
sys.path.insert(0, str(SCRIPTS_DIR))

from login_codyssey import (  # noqa: E402
    is_login_tab, is_authenticated_tab, select_session_target, wait_for_login_form,
)


class ReadyClient:
    """Minimal client that verifies the readiness function is invoked."""

    def evaluate(self, expression: str) -> bool:
        return expression.strip().endswith("()")


class SelectSessionTargetTests(unittest.TestCase):
    def test_daejeon_login_is_supported(self) -> None:
        self.assertTrue(is_login_tab({
            "type": "page", "url": "https://ams.codyssey.kr/daejeon/loginForm",
        }))

    def test_similar_untrusted_login_host_is_rejected(self) -> None:
        self.assertFalse(is_login_tab({
            "type": "page", "url": "https://ams.codyssey.kr.evil.test/daejeon/loginForm",
        }))

    def test_login_url_is_not_authenticated(self) -> None:
        self.assertFalse(is_authenticated_tab({
            "type": "page", "url": "https://usr.codyssey.kr/daejeon/loginForm",
        }))

    def test_wait_for_login_form_invokes_readiness_function(self) -> None:
        wait_for_login_form(ReadyClient(), timeout=0.1)  # type: ignore[arg-type]

    def test_prefers_authenticated_tab_over_login_form(self) -> None:
        login = {
            "type": "page",
            "url": "https://codyssey.kr/loginForm",
            "id": "login",
        }
        authenticated = {
            "type": "page",
            "url": "https://usr.codyssey.kr/main/",
            "id": "authenticated",
        }

        state, target = select_session_target([login, authenticated]) or (None, None)

        self.assertEqual(state, "authenticated")
        self.assertEqual(target, authenticated)

    def test_uses_login_form_when_no_authenticated_tab_exists(self) -> None:
        login = {
            "type": "page",
            "url": "https://codyssey.kr/loginForm",
            "id": "login",
        }

        self.assertEqual(select_session_target([login]), ("login", login))

    def test_returns_none_for_unrelated_tabs(self) -> None:
        self.assertIsNone(
            select_session_target(
                [{"type": "page", "url": "https://example.com/", "id": "other"}]
            )
        )


if __name__ == "__main__":
    unittest.main()
