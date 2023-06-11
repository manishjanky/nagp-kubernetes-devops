USE nagp-k8;
DROP TABLE IF EXISTS movies;

CREATE TABLE movies (
  movie_id INT NOT NULL AUTO_INCREMENT,
  title VARCHAR(1000) DEFAULT NULL,
  budget INT DEFAULT NULL,
  homepage VARCHAR(1000) DEFAULT NULL,
  overview VARCHAR(1000) DEFAULT NULL,
  popularity DECIMAL(12,6) DEFAULT NULL,
  release_date DATE DEFAULT NULL,
  revenue BIGINT(20) DEFAULT NULL,
  runtime INT DEFAULT NULL,
  movie_status VARCHAR(50) DEFAULT NULL,
  tagline VARCHAR(1000) DEFAULT NULL,
  vote_average DECIMAL(4,2) DEFAULT NULL,
  vote_count INT DEFAULT NULL,
  CONSTRAINT pk_movie PRIMARY KEY (movie_id)
);


INSERT INTO movies (movie_id, title, budget, homepage, overview, popularity, release_date, revenue, runtime, movie_status, tagline, vote_average, vote_count)
VALUES
(5,'Four Rooms',4000000,'','It\'s Ted the Bellhop\'s first night on the job...and the hotel\'s very unusual guests are about to place him in some outrageous predicaments. It seems that this evening\'s room service is serving up one unbelievable happening after another.',22.876230,'1995-12-09',4300000,98,'Released','Twelve outrageous guests. Four scandalous requests. And one lone bellhop, in his first day on the job, who\'s in for the wildest New year\'s Eve of his life.',6.50,530),
(11,'Star Wars',11000000,'http://www.starwars.com/films/star-wars-episode-iv-a-new-hope','Princess Leia is captured and held hostage by the evil Imperial forces in their effort to take over the galactic Empire. Venturesome Luke Skywalker and dashing captain Han Solo team together with the loveable robot duo R2-D2 and C-3PO to rescue the beautiful princess and restore peace and justice in the Empire.',126.393695,'1977-05-25',775398007,121,'Released','A long time ago in a galaxy far, far away...',8.10,6624),
(12,'Finding Nemo',94000000,'http://movies.disney.com/finding-nemo','Nemo, an adventurous young clownfish, is unexpectedly taken from his Great Barrier Reef home to a dentist\'s office aquarium. It\'s up to his worrisome father Marlin and a friendly but forgetful fish Dory to bring Nemo home -- meeting vegetarian sharks, surfer dude turtles, hypnotic jellyfish, hungry seagulls, and more along the way.',85.688789,'2003-05-30',940335536,100,'Released','There are 3.7 trillion fish in the ocean, they\'re looking for one.',7.60,6122),
(13,'Forrest Gump',55000000,'','A man with a low IQ has accomplished great things in his life and been present during significant historic events - in each case, far exceeding what anyone imagined he could do. Yet, despite all the things he has attained, his one true love eludes him. \'Forrest Gump\' is the story of a man who rose above his challenges, and who proved that determination, courage, and love are more important than ability.',138.133331,'1994-07-06',677945399,142,'Released','The world will never be the same, once you\'ve seen it through the eyes of Forrest Gump.',8.20,7927),
(14,'American Beauty',15000000,'http://www.dreamworks.com/ab/','Lester Burnham, a depressed suburban father in a mid-life crisis, decides to turn his hectic life around after developing an infatuation with his daughter\'s attractive friend.',80.878605,'1999-09-15',356296601,122,'Released','Look closer.',7.90,3313),
(16,'Dancer in the Dark',12800000,'','Selma, a Czech immigrant on the verge of blindness, struggles to make ends meet for herself and her son, who has inherited the same genetic disorder and will suffer the same fate without an expensive operation. When life gets too difficult, Selma learns to cope through her love of musicals, escaping life\'s troubles - even if just for a moment - by dreaming up little numbers to the rhythmic beats of her surroundings.',22.022228,'2000-05-17',40031879,140,'Released','You don\'t need eyes to see.',7.60,377),
(18,'The Fifth Element',90000000,'','In 2257, a taxi driver is unintentionally given the task of saving a young girl who is part of the key that will ensure the survival of humanity.',109.528572,'1997-05-07',263920180,126,'Released','There is no future without it.',7.30,3885),
(19,'Metropolis',92620000,'','In a futuristic city sharply divided between the working class and the city planners, the son of the city\'s mastermind falls in love with a working class prophet who predicts the coming of a savior to mediate their differences.',32.351527,'1927-01-10',650422,153,'Released','There can be no understanding between the hands and the brain unless the heart acts as mediator.',8.00,657),
(20,'My Life Without Me',0,'http://www.clubcultura.com/clubcine/clubcineastas/isabelcoixet/mividasinmi/index.htm','A Pedro Almodovar production in which a fatally ill mother with only two months to live creates a list of things she wants to do before she dies with out telling her family of her illness.',7.958831,'2003-03-07',9726954,106,'Released','',7.20,77),
(22,'Pirates of the Caribbean: The Curse of the Black Pearl',140000000,'http://disney.go.com/disneyvideos/liveaction/pirates/main_site/main.html','Jack Sparrow, a freewheeling 17th-century pirate who roams the Caribbean Sea, butts heads with a rival pirate bent on pillaging the village of Port Royal. When the governor\'s daughter is kidnapped, Sparrow decides to help the girl\'s love save her. But their seafaring mission is hardly simple.',271.972889,'2003-07-09',655011224,143,'Released','Prepare to be blown out of the water.',7.50,6985);

COMMIT;