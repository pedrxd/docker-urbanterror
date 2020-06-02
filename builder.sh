sudo docker buildx build --platform linux/amd64,linux/arm,linux/ppc64le,linux/arm64,linux/386 -t pedrxd/urbanterror:latest -t pedrxd/urbanterror:4.3.4 . --push

