## Запуск проекта (Docker Compose)

Для запуска:
`docker compose up -d`

## Отчёт о проверках (на 8 баллов)

**1. Проверка сохранения счетчика (Volume):**
Выполнено несколько запросов на увеличение счетчика:
`curl -fsS -X POST http://127.0.0.1:8080/increment`
Ответ: `{"greeting": "Hello, Docker!", "count": 4, "hostname": "af172d955af5", "storage": "redis"}`

Проект остановлен без удаления volume (`docker compose down`), затем запущен заново (`docker compose up -d`).
Запрос `curl -fsS http://127.0.0.1:8080/`  вернул сохраненное:
`{"greeting": "Hello, Docker!", "count": 4, "hostname": "8386c1a0d254", "storage": "redis"}`

**2. Проверка отключения Redis:**
Остановлена редиска: `docker compose stop redis`
Запрос readyz (`curl -I -X POST http://127.0.0.1:8080/increment`) возвращает HTTP 503:
`HTTP/1.0 503 Service Unavailable`

**3. Проверка восстановления Redis:**
Запущена редиска: `docker compose start redis`
После восстановления редиски запрос `curl -fsS http://127.0.0.1:8080/` успешно вернул старое:
`{"greeting": "Hello, Docker!", "count": 4, "hostname": "8386c1a0d254", "storage": "redis"}`
Следующий запрос `POST /increment` увеличил счетчик:
`{"greeting": "Hello, Docker!", "count": 5, "hostname": "8386c1a0d254", "storage": "redis"}`