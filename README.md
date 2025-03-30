# Orchestrator
Service responsible for coordinating the whole system

**IMPORTANT**: The submodules are references to git branches, which means that to get updated code, you need to run `git submodule update --init --recursive` in the root directory.
Also, keep the submodules in the `dev` branch.

### How to acess the multiple services

- **Frontend**:
    - From outside the container: `http://localhost:80`

- **Trip-Management**:
    - From outside the container: `http://localhost:80/api/v1/trip-management`
    - From another container: `http://trip-management:8080`

- **Recommendations**:
    - From outside the container: `http://localhost:80/api/v1/recommendations`
    - From another container: `http://recommendations:8080`

- **Place-Wrapper**:
    - From outside the container: `http://localhost:80/api/v1/place-wrapper`
    - From another container: `http://place-wrapper:8080`

- **Maps-Wrapper**
    - From outside the container: `http://localhost:80/api/v1/maps-wrapper`
    - From another container: `http://maps-wrapper:8080`

### How to run

```bash
docker-compose up
```
or
```bash
docker-compose up -d
```
