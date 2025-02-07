CREATE TABLE user_interactions (
    user_id varchar(10),
    event varchar(15),
    event_date DATE,
    interaction_type varchar(15),
    game_id varchar(10),
    event_time TIME
);

INSERT INTO user_interactions 
VALUES
('abc', 'game_start', '2024-01-01', null, 'ab0000', '10:00:00'),
('def', 'game_start', '2024-01-01', null, 'ab0000', '10:00:00'),
('def', 'send_emoji', '2024-01-01', 'emoji1', 'ab0000', '10:03:20'),
('def', 'send_message', '2024-01-01', 'preloaded_quick', 'ab0000', '10:03:49'),
('abc', 'send_gift', '2024-01-01', 'gift1', 'ab0000', '10:04:40'),
('abc', 'game_end', '2024-01-01', NULL, 'ab0000', '10:10:00'),
('def', 'game_end', '2024-01-01', NULL, 'ab0000', '10:10:00'),
('abc', 'game_start', '2024-01-01', null, 'ab9999', '10:00:00'),
('def', 'game_start', '2024-01-01', null, 'ab9999', '10:00:00'),
('abc', 'send_message', '2024-01-01', 'custom_typed', 'ab9999', '10:02:43'),
('abc', 'send_gift', '2024-01-01', 'gift1', 'ab9999', '10:04:40'),
('abc', 'game_end', '2024-01-01', NULL, 'ab9999', '10:10:00'),
('def', 'game_end', '2024-01-01', NULL, 'ab9999', '10:10:00'),
('abc', 'game_start', '2024-01-01', null, 'ab1111', '10:00:00'),
('def', 'game_start', '2024-01-01', null, 'ab1111', '10:00:00'),
('abc', 'game_end', '2024-01-01', NULL, 'ab1111', '10:10:00'),
('def', 'game_end', '2024-01-01', NULL, 'ab1111', '10:10:00'),
('abc', 'game_start', '2024-01-01', null, 'ab1234', '10:00:00'),
('def', 'game_start', '2024-01-01', null, 'ab1234', '10:00:00'),
('abc', 'send_message', '2024-01-01', 'custom_typed', 'ab1234', '10:02:43'),
('def', 'send_emoji', '2024-01-01', 'emoji1', 'ab1234', '10:03:20'),
('def', 'send_message', '2024-01-01', 'preloaded_quick', 'ab1234', '10:03:49'),
('abc', 'send_gift', '2024-01-01', 'gift1', 'ab1234', '10:04:40'),
('abc', 'game_end', '2024-01-01', NULL, 'ab1234', '10:10:00'),
('def', 'game_end', '2024-01-01', NULL, 'ab1234', '10:10:00');


/*Question:
Identify the game_type
1. No Social Interaction(No messages or gifts between gamers in the game)
2. One Sided Interaction(Messages or gifts sent by only one player in the game)
3. Both sided Interaction without custom_typed message
4. Both Sided Interaction with custom_types_message from atleast one player
*/
select * from user_interactions

select game_id,case when count(interaction_type) = 0 then 'No Social Interaction'
                    when count(distinct case when interaction_type is not null then user_id end)=1 then 'One Sided Interaction'
					when count(distinct case when interaction_type is not null then user_id end)=2 and 
					     count(distinct case when interaction_type = 'custom_typed' then user_id end) = 0
						 then 'Both sided interaction without custom_typed messages'
				    when count(distinct case when interaction_type is not null then user_id end)=2 and
					     count(distinct case when interaction_type = 'custom_typed' then user_id end) >=1
						 then 'Both sided interaction with custom_types_messages from at least one player'
end as game_type
from user_interactions
group by game_id

/* Explanation:
Step1 : In a game_id..when count(interaction_type) = 0 then we can say that there's
        'No Social Interaction in the game
Step2 : If count of user_id where interaction_type is not null = 1 then it is
        'One Sided Interaction'
Step3 : If count of user_id where interaction_type is not null = 2 and 
        count of user_id where interaction_type = custom_type is 0 
		then it is 'Both sided interaction without custom_typed message'
Step4 : If count of user_id where interaction_type is not null = 2 and 
        count of user_id where interaction_type = custom_type is >= 1
		then it is 'Both sided interaction with atleast one custom_typed message'