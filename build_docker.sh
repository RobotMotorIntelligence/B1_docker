docker build -t b1_dev --platform linux/amd64 --build-arg SSH_PRIVATE_KEY="$(cat ~/.ssh/id_ed25519)" --build-arg SSH_PUBLIC_KEY="$(cat ~/.ssh/id_ed25519.pub)" .
