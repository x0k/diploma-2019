# Инструментарий для представления комплексных расписаний на базе веб-платформы

Добрый день, представляю вам доклад на тему "Инструментарий для представления комплексных расписаний на базе веб-платформы".

Для начала разберемся в основных понятиях упомянутых в теме доклада

# Основные понятия

## Комплексное расписание

Можно выделить два типа расписаний:
* Периодические - расписания, действия которых повторяются через конкретный промежуток времени (период)
* Непериодические - расписания, в которых отсутствуют требования обязательного повторения событий, через заданный промежуток времени

В теории пересечение данных множеств должно быть пустым множеством, но на практике это не так и можно выделить третий тип расписаний – комплексные

Давайте рассмотрим пример

## Комплексное расписание

Знакомая картина?

Данное расписание пытается быть периодическим, но определенных обстоятельств получается это *rewrite*

## Веб-платформа

В данном случае под веб-платформой понимаются устройства реализующие стандарты веб-технологий.

Это:
* ПК
* Мобильные устройства
* Сервера с средой исполнения JS кода

Ориентация на данную платформу имеет следующие последствия:

В качестве преимуществ:
* Распространенность - *rewrite*
* Кроссплатформенность - код будет работать практически где угодно
* Опыт разработки

Из недостатков:
* Производительность - относительно нативных приложений, производительность ниже
* Ограниченность среды исполнения кода - опять же относительно нативных приложений, количество доступных возможностей ниже

## Представление расписания

Вернемся к расписанию.

Очевидно, что данный формат не является оптимальным для восприятия, давайте попробуем его изменить

## Представление расписания

Можно подумать, предыдущее представление несет гораздо больше информации и сравнивать данные представления некорректно

Однако на 26 ноября 2018 года для студента подгруппы «А», представления имеют одинаковую ценность

Далее будем иметь ввиду под представлением расписания - выборку необходимой информации из существующего расписания

# Наивный подход

Можно попробовать решить данную задачу в лоб, что и было сделано мной некоторое время назад

## Модель данных

Мы рассматриваем расписание как периодическое, но с исключениями. Таким образом следующую модель данных

## Ввод данных

Интерфейс ввода данных для одного дня, все заполняется вручную на основе табличного расписания

## Интерфейс приложения

Отлично. Почему же данный подход наивный, если все работает?

Процесс эксплуатации. Точнее процесс создания расписания для такого приложения - большой труд. Вносить правки при изменении расписания - практически невозможно.

# Что такое расписание?

По сути расписание – это упорядоченная по времени информация о предстоящих событиях

Тогда мы можем представить расписание в виде функции определенной на временной прямой и возвращающую информацию о текущем событии

Остается лишь вычислить данную функцию и использовать ее для отображения расписания

# Представление расписания

## Генерация функции

Не самый простой процесс.

Слева представлены входные данные. Событие с атрибутами
* предмет: предмет
* тип: лаб
* преподаватель: преподаватель
* комната: 251
* дни недели: пн, ср
* звонки 6, 7 (временные периоды 6 и 7 пар)

Справа - функция созданная на основе этих данных для вычисления состояния атрибута комната

Логическое выражение, если день или пн или ср и звонок 6 или 7, то атрибут кабинет принимает значение 251

## Временной интервал

Также для представления расписания необходимо сгенерировать временной интервал, на котором будет вычислена функция расписания.

Это важная часть т. к. временной интервал это не только начальная и конечная точки, но и шаг итерации временного промежутка на различных уровнях.

Например, если заметить, что все минутные значения звонков кратны 10, то выставив шаг итерации в уровне минут на 10, мы уменьшим количество вычислений необходимых для представления в 10 раз.

Также можно исключить конкретные даты - выходные и праздники

## Генератор событий

Далее вступает в работу генератор событий.

Он выстраивает функции вычисления состояния атрибута события согласно их зависимостям, затем последовательно применяет их, добавляя состояние атрибута к начальному значению.

По окончанию получается объект описывающий состояние расписания.

## Группировщик событий

Даже с выставление минутного шага в 10, генератор событий 8 раз сообщит о состоянии одной пары.

Для объединения одинаковых состояний с различными датами применяется группировщик.

Он производит объединение на основе сравнения атрибутов события и временного промежутка между ними

# Применение

Уже говорилось, что данная библиотека может использоваться практически где угодно, но основная причина появления данного инструментария - использование его в SPA для представления расписаний