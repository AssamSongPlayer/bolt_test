/*
  # Database Functions for Music Player

  1. Functions
    - `increment_views` - Safely increment song view count
    - `increment_likes` - Safely increment song like count  
    - `decrement_likes` - Safely decrement song like count

  2. Security
    - Functions use atomic operations to prevent race conditions
    - Proper error handling for edge cases
*/

-- Function to increment views
CREATE OR REPLACE FUNCTION increment_views(song_file_id INTEGER)
RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE songs 
  SET views = views + 1 
  WHERE file_id = song_file_id;
END;
$$;

-- Function to increment likes
CREATE OR REPLACE FUNCTION increment_likes(song_file_id INTEGER)
RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE songs 
  SET likes = likes + 1 
  WHERE file_id = song_file_id;
END;
$$;

-- Function to decrement likes (with minimum of 0)
CREATE OR REPLACE FUNCTION decrement_likes(song_file_id INTEGER)
RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE songs 
  SET likes = GREATEST(likes - 1, 0)
  WHERE file_id = song_file_id;
END;
$$;