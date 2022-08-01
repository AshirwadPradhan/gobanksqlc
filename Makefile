postgres:
	docker run --name postgres12 -p 5432:5432 -e POSTGRES_PASSWORD=secret -d postgres:12-alpine
createdb:
	docker exec -it postgres12 createdb --username=postgres --owner=postgres gobank
dropdb:
	docker exec -it postgres12 dropdb gobank
stop:
	docker stop postgres12
remove-db:
	docker rm postgres12
migrate-up:
	migrate -path db/migration -database "postgresql://postgres:secret@localhost:5432/gobank?sslmode=disable" -verbose up
migrate-down:
	migrate -path db/migration -database "postgresql://postgres:secret@localhost:5432/gobank?sslmode=disable" -verbose -f down

.PHONY: postgres createdb start dropdb stop remove-db migrate-up migrate-down