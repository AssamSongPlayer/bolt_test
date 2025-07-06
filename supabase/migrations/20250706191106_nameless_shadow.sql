/*
  # Add Database Functions for Views and Likes

  1. Functions
    - `increment_views` - Safely increment song views
    - `increment_likes` - Safely increment song likes  
    - `decrement_likes` - Safely decrement song likes

  2. Security
    - Functions are secure and prevent negative values
    - Proper error handling for non-existent songs
*/

-- Function to increment views
CREATE OR REPLACE FUNCTION increment_views(song_file_id INTEGER)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  UPDATE songs 
  SET views = views + 1 
  WHERE file_id = song_file_id;
  
  IF NOT FOUND THEN
    RAISE EXCEPTION 'Song with file_id % not found', song_file_id;
  END IF;
END;
$$;

-- Function to increment likes
CREATE OR REPLACE FUNCTION increment_likes(song_file_id INTEGER)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  UPDATE songs 
  SET likes = likes + 1 
  WHERE file_id = song_file_id;
  
  IF NOT FOUND THEN
    RAISE EXCEPTION 'Song with file_id % not found', song_file_id;
  END IF;
END;
$$;

-- Function to decrement likes (with safety check)
CREATE OR REPLACE FUNCTION decrement_likes(song_file_id INTEGER)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  UPDATE songs 
  SET likes = GREATEST(0, likes - 1)
  WHERE file_id = song_file_id;
  
  IF NOT FOUND THEN
    RAISE EXCEPTION 'Song with file_id % not found', song_file_id;
  END IF;
END;
$$;