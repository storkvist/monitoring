# Мониторинг 0.1

[http://monitoring.mgup.local](http://monitoring.mgup.local)

Система для сбора сведений в рамках мониторинга штатной структуры университета
печати имени Ивана Фёдорова.

## Оценка схожести должностных обязанностей

Для оценки схожести должностных обязанностей сотрудников система использует
расширение smlar для PostgreSQL (git://sigaev.ru/smlar).

### Установка smlar

Для установки smlar на сервере могут понадобиться дополнительные пакеты
(например, `postgresql-server-dev-9.2`). После установки необходимых пакетов:
```bash
git clone git://sigaev.ru/smlar
cd smlar
export USE_PGXS=1
make
make install
```

Далее для использования расширения, в необходимой базе данных выполняем:
```sql
CREATE EXTENSION smlar;
```

Кроме того, для удобной работы с данными нам понадобится дополнительная функция:
```sql
CREATE OR REPLACE FUNCTION array_to_col(anyarray)
RETURNS SETOF anyelement AS
$$
    SELECT $1[n]
    FROM generate_series(1, array_upper($1, 1) - array_lower($1, 1) + 1) AS n;
$$ LANGUAGE SQL RETURNS NULL ON NULL INPUT IMMUTABLE;
```