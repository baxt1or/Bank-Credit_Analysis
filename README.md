# Проект SQL анализа кредитов

## Обзор

Этот проект направлен на анализ поведения клиентов в кредитовании с использованием различных демографических и кредитных метрик. Цель — получить инсайты о сегментах клиентов, паттернах погашения кредитов и кредитном поведении для принятия обоснованных решений в финансовой сфере.

## Структура

Анализ включает два основных направления:

1. **Демографический анализ**

   - Анализ распределения по возрасту
   - Анализ распределения по полу
   - Анализ уровня образования

2. **Анализ кредитного поведения**
   - Доходы и сумма кредита
   - Поведение по погашению кредита
   - Дефолты по должностям

## SQL запросы

### 1. Демографический анализ

- **Анализ распределения по возрасту:**
  - Классификация клиентов по возрастным группам: «молодые», «взрослые», «пожилые».
  - Сумма и количество кредитов, просроченных кредитов в каждой группе.
- **Анализ распределения по полу:**
  - Общая сумма кредита по полу.
  - Средняя сумма кредита и количество просроченных кредитов по полу.
- **Анализ уровня образования:**
  - Общая сумма кредита по уровню образования.

### 2. Анализ кредитного поведения

- **Доходы и сумма кредита:**
  - Анализ средней суммы кредита для различных диапазонов доходов.
- **Поведение по погашению кредита:**

  - Суммарное количество просроченных кредитов по месяцам.

- **Дефолты по должностям:**
  - Средний доход и количество просроченных кредитов для различных должностей.

## Технологии

- **СУБД:** PostgreSQL
- **SQL:** Стандарт SQL для выполнения запросов.

## Использование

Для работы с этим проектом вам потребуется доступ к базе данных с таблицей кредитов. Все запросы написаны на SQL и могут быть выполнены в вашем SQL клиенте.

## Примечания

- Все запросы отсортированы по количеству или общей сумме.
- Ожидается, что таблица `credit` содержит поля, такие как: `client_id`, `age`, `gender`, `credit_sum`, `monthly_income`, `overdue_credit_count`, и другие данные клиентов.

## Лицензия

Этот проект лицензирован под MIT лицензией.
