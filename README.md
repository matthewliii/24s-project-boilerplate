# MixMaven

Our project aims to simplify and organize the large amounts of music files that DJs have. Our mission is to reduce the hassle of digging through and looking for files to play a song and inspire creativity.

# Team Members:

Cody Chan, Chris Le, Brighton Le, Matthew Li, Justin Wee

## How to setup and start the containers

**Important** - you need Docker Desktop installed

1. Clone this repository.
1. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL.
1. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the a non-root user named webapp.
1. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.
1. Build the images with `docker compose build`
1. Start the containers with `docker compose up`. To run in detached mode, run `docker compose up -d`.
