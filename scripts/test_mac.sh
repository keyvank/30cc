#/bin/bash

# Check if the container exists and is running
if ! docker ps -a --filter "name=cc_tester" --format '{{.Names}}' | grep -q "cc_tester"; then
	docker run --name cc_tester -itd --platform linux/amd64 -v "$(pwd):/mnt" ubuntu
	docker exec cc_tester /bin/bash -c "apt update && apt install -y python3 make nasm build-essential libc6-dev"
else
	# If the container exists but is stopped, start it
	docker start cc_tester
fi

# Run the test script inside the container
docker exec cc_tester /bin/bash -c "cd /mnt && python3 scripts/test.py"
