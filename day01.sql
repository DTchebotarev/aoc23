with data as (
SELECT
word,
row_number() over (order by 1) as word_number,
len(word) as word_length
from ( VALUES
  ('two65eightbkgqcsn91qxkfvg'),
-- skip the rest of the input
  ('195one')
) AS t(word)
), exploded as (
select
word_number,
word,
word_length,
t.value as character,
t.index as character_number,
t.*,
try_to_number(iff(character != 'e', character::string, null)) as numeric_value_pt_1,
substr(word, 0, character_number + 1) as numeric_word_start_pt_2,
substr(word, character_number + 1, word_length) as numeric_word_end_pt_2,
case 
  when numeric_word_start_pt_2 like '%one%' then 1
  when numeric_word_start_pt_2 like '%two%' then 2
  when numeric_word_start_pt_2 like '%three%' then 3
  when numeric_word_start_pt_2 like '%four%' then 4
  when numeric_word_start_pt_2 like '%five%' then 5
  when numeric_word_start_pt_2 like '%six%' then 6
  when numeric_word_start_pt_2 like '%seven%' then 7
  when numeric_word_start_pt_2 like '%eight%' then 8
  when numeric_word_start_pt_2 like '%nine%' then 9
end as numeric_value_start_pt_2,
case 
  when numeric_word_end_pt_2 like '%one%' then 1
  when numeric_word_end_pt_2 like '%two%' then 2
  when numeric_word_end_pt_2 like '%three%' then 3
  when numeric_word_end_pt_2 like '%four%' then 4
  when numeric_word_end_pt_2 like '%five%' then 5
  when numeric_word_end_pt_2 like '%six%' then 6
  when numeric_word_end_pt_2 like '%seven%' then 7
  when numeric_word_end_pt_2 like '%eight%' then 8
  when numeric_word_end_pt_2 like '%nine%' then 9
end as numeric_value_end_pt_2
from data,
lateral flatten(regexp_extract_all(word, '.{1}')) as t
)
-- select * from exploded
, words as (
select 
word_number,
any_value(word) as word,
(
  min_by(numeric_value_pt_1, numeric_value_pt_1 * 0 + character_number)::string ||
  max_by(numeric_value_pt_1, numeric_value_pt_1 * 0 + character_number)::string
)::number as value_pt_1,
(
  min_by(coalesce(numeric_value_start_pt_2,numeric_value_pt_1), coalesce(numeric_value_start_pt_2,numeric_value_pt_1) * 0 + character_number)::string ||
  max_by(coalesce(numeric_value_end_pt_2,numeric_value_pt_1), coalesce(numeric_value_end_pt_2,numeric_value_pt_1) * 0 + character_number)::string
)::number as value_pt_2
from exploded
group by 1
)
select sum(value_pt_1) as pt_1, sum(value_pt_2) as pt_2 from words
order by word_number


