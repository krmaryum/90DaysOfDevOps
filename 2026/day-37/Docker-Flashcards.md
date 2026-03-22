#  Docker Flashcards

## Basics

Q: What is docker run?\
A: create + start container

Q: What is docker ps?\
A: list running containers

Q: What is docker ps -a?\
A: list all containers

---

## Modes

Q: What does -it do?\
A: interactive terminal

Q: What does -d do?\
A: run in background

Q: What does -p 8080:80 mean?\
A: host 8080 → container 80

---

## Images

Q: How to download image?\
A: docker pull

Q: How to list images?\
A: docker images

Q: How to remove image?\
A: docker rmi

---

## Volumes

Q: Why use volumes?\
A: persist data

Q: Bind mount vs volume?\
A: local vs Docker-managed

---

## Networking

Q: How containers communicate?\
A: same network via name

---

## Compose

Q: docker-compose up?\
A: start services

Q: down vs down -v?\
A: -v removes volumes

---

## Debugging

Q: View logs?\
A: docker logs

Q: Enter container?\
A: docker exec -it

---

## Cleanup

Q: Check disk usage?\
A: docker system df

Q: Clean system?\
A: docker system prune

---

## Danger

Q: Remove all containers?\
A: docker rm $(docker ps -qa)

Q: Remove all images?\
A: docker rmi $(docker images -q)

---

💡 Rule: If you can answer these fast → you actually know Docker