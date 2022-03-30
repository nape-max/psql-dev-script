#!/bin/bash

countExistsHabrPgContainer="$(docker ps -a | grep habr-pg-13.3 | wc -l)"

if [ "$1" == "create" ]; then
	if [ $countExistsHabrPgContainer -eq 0 ]; then
		echo "Starting PostgreSQL on port 5432 and volume inside '~/my.d/elixir/postgres-data'..."
		docker run --name habr-pg-13.3 -p 5432:5432 -v ~/my.d/elixir/postgres-data:/var/lib/postgresql/data:z -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=elixir_realtime_dev -d postgres:13.3
	else
		echo "PostgreSQL container already exists. Use it or delete before start (use 'delete' command instead)."
	fi
elif [ "$1" == "delete" ]; then
	if [ $countExistsHabrPgContainer -gt 0 ]; then
		echo "Stopping and deleting PostgreSQL container..."
		docker stop habr-pg-13.3 && \
		docker rm habr-pg-13.3
	else
		echo "PostgreSQL container already stopped."
	fi
else
	echo "Unknown command. Use 'create' or 'delete'."
fi
