#!/usr/bin/env bash
# Run only on a disposable Linux learning/CI host with Docker available.
set -Eeuo pipefail
cd "$(dirname "$0")/.."
project_dir="$PWD"
mkdir -p evidence
exec > >(tee evidence/verification.log) 2>&1
PS4='+ ${LINENO}: '
set -x
uname -srm
bash --version | head -n 1
git --version
docker --version
docker info
sandbox=$(mktemp -d)
prefix="e11-${GITHUB_RUN_ID:-$$}"
image="$prefix:local"
volume="$prefix-data"
web="$prefix-web"
bind="$prefix-bind"
data="$prefix-data"
ubuntu="$prefix-ubuntu"
cleanup() {
 docker rm -f "$web" "$bind" "$data" "$ubuntu" "$prefix-collision" >/dev/null 2>&1 || true
 docker volume rm "$volume" >/dev/null 2>&1 || true
}
trap cleanup EXIT
cd "$sandbox"
pwd
mkdir practice
ls -la
cd practice
touch empty.txt
printf 'terminal practice\n' > original.txt
cat original.txt
cp original.txt copied.txt
mv copied.txt renamed.txt
rm renamed.txt
mkdir permissions
chmod 600 original.txt
chmod 700 permissions
ls -ld original.txt permissions
chmod 644 original.txt
chmod 755 permissions
ls -ld original.txt permissions
# Observe a real, controlled permission failure; never invent troubleshooting.
printf '#!/bin/sh\necho permission-fixed\n' > execute.sh
chmod 644 execute.sh
if ./execute.sh; then echo 'ERROR: expected permission failure'; exit 1; fi
chmod 755 execute.sh
./execute.sh
cd "$project_dir"
docker run --rm hello-world
docker run -d --name "$ubuntu" ubuntu:24.04 sleep infinity
docker exec "$ubuntu" sh -c 'ls /; echo ubuntu-exec-ok'
docker inspect -f '{{.State.Running}}' "$ubuntu" | grep true
docker stop "$ubuntu"
docker inspect -f '{{.State.Running}}' "$ubuntu" | grep false
docker start "$ubuntu"
docker attach --help
python3 scripts/attach_demo.py "$prefix-attach"
# exec starts another process; attach joins the main process streams.
docker build -t "$image" .
docker images "$image"
docker run -d -p 127.0.0.1::80 --name "$web" "$image"
port=$(docker port "$web" 80/tcp | awk -F: '{print $NF}')
for attempt in $(seq 1 30); do
 if curl --fail -s "http://127.0.0.1:$port/" > "$sandbox/response.html"; then break; fi
 sleep 1
done
grep 'E1-1' "$sandbox/response.html"
cat "$sandbox/response.html"
# Reproduce host-port collision, then solve using a different allocated port.
if docker run -d --name "$prefix-collision" -p "127.0.0.1:$port:80" "$image"; then
 echo 'PORT_CONFLICT_PLATFORM_VARIATION: Docker Desktop accepted the duplicate request.'
 docker inspect -f '{{json .NetworkSettings.Ports}}' "$prefix-collision"
 docker rm -f "$prefix-collision"
else
 echo PORT_CONFLICT_REJECTED
fi
cp -r site "$sandbox/site"
docker run -d -p 127.0.0.1::80 --name "$bind" --mount "type=bind,src=$sandbox/site,dst=/usr/share/nginx/html,readonly" "$image"
bind_port=$(docker port "$bind" 80/tcp | awk -F: '{print $NF}')
curl --fail --retry 10 --retry-all-errors --retry-connrefused --retry-delay 1 "http://127.0.0.1:$bind_port/"
printf '<h1>E1-1 bind mount updated</h1>\n' > "$sandbox/site/index.html"
curl --fail "http://127.0.0.1:$bind_port/" | grep 'bind mount updated'
docker volume create "$volume"
docker run -d --name "$data" --mount "type=volume,src=$volume,dst=/data" ubuntu:24.04 sleep infinity
docker exec "$data" sh -c 'echo E1-1-persistent > /data/proof.txt; cat /data/proof.txt'
docker rm -f "$data"
docker run -d --name "$data" --mount "type=volume,src=$volume,dst=/data" ubuntu:24.04 sleep infinity
docker exec "$data" cat /data/proof.txt | grep E1-1-persistent
docker ps -a
docker logs "$web"
docker stats --no-stream "$web"
for attempt in $(seq 1 20); do
 health=$(docker inspect -f '{{.State.Health.Status}}' "$web")
 if [ "$health" = healthy ]; then break; fi
 sleep 1
done
[ "$health" = healthy ]
echo HEALTHCHECK_PASS
# Isolated git configuration: do not print the user's global configuration.
git -C "$sandbox" init -b main
git -C "$sandbox" config user.name 'E1-1 CI Learner'
git -C "$sandbox" config user.email 'learner@example.invalid'
git -C "$sandbox" config init.defaultBranch main
git -C "$sandbox" config --local --list
git -C "$sandbox" add practice
git -C "$sandbox" commit -m 'Practice terminal and permissions'
git -C "$sandbox" log -1 --oneline
set +x
printf '\nVERIFICATION_PASS: CLI, permissions, Docker, HTTP, bind mount, persistence, Git\n'
