"""Verify Docker attach/detach behavior with a real pseudo-terminal."""
from __future__ import annotations

import os
import pty
import select
import subprocess
import sys
import time


def main() -> None:
    """Attach, detach with Ctrl+P Ctrl+Q, then verify exec and main exit."""
    name = sys.argv[1]
    subprocess.run(["docker", "run", "-dit", "--name", name,
                    "ubuntu:24.04", "bash"], check=True)
    master, slave = pty.openpty()
    process = subprocess.Popen(["docker", "attach", name], stdin=slave,
                               stdout=slave, stderr=slave)
    os.close(slave)
    try:
        time.sleep(0.5)
        os.write(master, b"echo ATTACH_CONNECTED\n")
        transcript = bytearray()
        deadline = time.monotonic() + 8
        while time.monotonic() < deadline:
            if select.select([master], [], [], 0.3)[0]:
                transcript.extend(os.read(master, 4096))
                if b"ATTACH_CONNECTED" in transcript:
                    break
        print(transcript.decode(errors="replace"))
        if b"ATTACH_CONNECTED" not in transcript:
            raise RuntimeError("No attach response")
        os.write(master, b"\x10\x11")
        process.wait(timeout=10)
        state = subprocess.check_output([
            "docker", "inspect", "-f", "{{.State.Running}}", name], text=True)
        assert state.strip() == "true", "Detach stopped the container"
        print("DETACH_PASS: main bash remains running")
        subprocess.run(["docker", "exec", name, "bash", "-c",
                        "echo EXEC_CHILD_EXIT; exit 0"], check=True)
        state = subprocess.check_output([
            "docker", "inspect", "-f", "{{.State.Running}}", name], text=True)
        assert state.strip() == "true", "exec exit stopped main bash"
        subprocess.run(["docker", "stop", name], check=True)
        print("ATTACH_EXEC_PASS: detach and child exit preserve main process")
    finally:
        if process.poll() is None:
            process.terminate()
        os.close(master)
        subprocess.run(["docker", "rm", "-f", name], check=False)


if __name__ == "__main__":
    main()
