# Мониторинг 0.1

[http://monitoring.mgup.local](http://monitoring.mgup.local)

Система для сбора сведений в рамках мониторинга штатной структуры университета 
печати имени Ивана Фёдорова.

## Оценка схожести должностных обязанностей

Для оценки схожести должностных обязанностей сотрудников система использует 
расширение smlar для PostgreSQL. При оценке используется мера 
[TF-IDF](http://ru.wikipedia.org/wiki/TF-IDF). Для хранения частот употребления 
слов будет использоваться дополнительная таблица `text_stat`.

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

Для настройки расширения, параметры по-умолчанию можно добавить 
в `postgresql.conf`:
```ini
smlar.threshold = 0.8
smlar.type = tfidf
smlar.stattable = text_stat
```

Либо устанавливать/изменять их через SQL-запросы:
```postgresql
SELECT set_smlar_limit(0.8);
SET smlar.type = "tfidf";
SET smlar.stattable = "text_stat";
```

Для непосредственного использования расширения, в рабочей базе данных выполняем:
```postgresql
CREATE EXTENSION smlar;
```

Кроме того, для удобной работы с данными нам понадобится дополнительная функция:
```postgresql
CREATE OR REPLACE FUNCTION array_to_col(anyarray)
RETURNS SETOF anyelement AS
$$
    SELECT $1[n]
    FROM generate_series(1, array_upper($1, 1) - array_lower($1, 1) + 1) AS n;
$$ LANGUAGE SQL RETURNS NULL ON NULL INPUT IMMUTABLE;
```

### Исходные данные для анализа

При поиске сотрудников со схожими должностными обязанностями
анализируются вектора, составленные из объединения должностных обязанностей 
и результатов работы сотрудника. Для удобства эти данные выведены в виде
отдельного представления:
```postgresql
CREATE OR REPLACE VIEW employee_duties AS 
 SELECT employees.id AS employee_id, 
        assignments.id AS assignment_id, 
        setweight(to_tsvector(COALESCE(string_agg(assignments.task, ' '::text), ''::text)), 'A'::"char") 
          || setweight(to_tsvector(COALESCE(string_agg(results.details, ' '::text), ''::text)), 'B'::"char") AS duties
  FROM assignments
  LEFT JOIN results ON results.assignment_id = assignments.id
  JOIN instructions ON instructions.id = assignments.instruction_id
  JOIN employees ON employees.id = instructions.employee_id
  GROUP BY employees.id, assignments.id;
```

### Таблица для хранения частот употребления слов

Вспомогательная таблица будет хранить слова и частоты их употребления.
Она используется smlar для вычисления TF-IDF меры схожести двух текстов.

```postgresql
CREATE TABLE text_stat (
  value   text UNIQUE,
  ndoc    int4 NOT NULL CHECK (ndoc > 0)
);
```

В ней хранятся пары (СЛОВО, КОЛИЧЕСТВО УПОТРЕБЛЕНИЙ). Кроме того, в ней должна 
находиться пара (NULL, КОЛИЧЕСТВО ПРОАНАЛИЗИРОВАННЫХ ДОКУМЕНТОВ).

Заполнение таблицы:
```postgresql
INSERT INTO text_stat (
    SELECT
    	q.w,
		count(*)
	FROM
		(SELECT array_to_col(tsvector2textarray(duties)) AS w FROM employee_duties WHERE duties IS NOT NULL)  AS q
	GROUP BY w
);
INSERT INTO text_stat VALUES (NULL, (SELECT count(*) FROM employee_duties));
```

### Пример вычисления схожих должностных обязанностей

```postgresql
SELECT 
    d1.employee_id, 
	d1.assignment_id, 
	d2.employee_id, 
	d2.assignment_id, 
	tsvector2textarray(d1.duties), 
	tsvector2textarray(d2.duties),
	smlar(tsvector2textarray(d1.duties), tsvector2textarray(d2.duties)) AS similarity 
FROM employee_duties AS d1, employee_duties AS d2 
WHERE d1.assignment_id != d2.assignment_id 
ORDER BY similarity DESC;
```
