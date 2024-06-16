-- MySQL dump 10.13  Distrib 8.0.33, for Linux (x86_64)
--
-- Host: std-mysql    Database: std_2475_exam
-- ------------------------------------------------------
-- Server version	5.7.26-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alembic_version`
--

LOCK TABLES `alembic_version` WRITE;
/*!40000 ALTER TABLE `alembic_version` DISABLE KEYS */;
INSERT INTO `alembic_version` VALUES ('7821c5dd3363');
/*!40000 ALTER TABLE `alembic_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_genres`
--

DROP TABLE IF EXISTS `book_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_genres` (
  `book_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL,
  PRIMARY KEY (`book_id`,`genre_id`),
  KEY `fk_book_genres_genre_id_genres` (`genre_id`),
  CONSTRAINT `fk_book_genres_book_id_books` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`),
  CONSTRAINT `fk_book_genres_genre_id_genres` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_genres`
--

LOCK TABLES `book_genres` WRITE;
/*!40000 ALTER TABLE `book_genres` DISABLE KEYS */;
INSERT INTO `book_genres` VALUES (6,1),(8,1),(9,1),(10,1),(12,1),(13,1),(19,1),(3,2),(11,2),(3,5),(4,5),(7,5),(4,6),(18,7),(19,7);
/*!40000 ALTER TABLE `book_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `short_desc` text NOT NULL,
  `year` int(11) NOT NULL,
  `publisher` varchar(200) NOT NULL,
  `author` varchar(200) NOT NULL,
  `pages` int(11) NOT NULL,
  `cover_id` varchar(100) NOT NULL,
  `rating_sum` int(11) NOT NULL,
  `rating_num` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_books_cover_id_covers` (`cover_id`),
  CONSTRAINT `fk_books_cover_id_covers` FOREIGN KEY (`cover_id`) REFERENCES `covers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (3,'Прокляты и убиты','Прокляты и убиты — роман Виктора Астафьева, описывающий события Великой Отечественной войны. Новобранец Лёшка Шестаков познал все тяготы жизни в подготовительном лагере — голод, болезни, невыносимые условия, жестокость и самодурство командующих. Герою удалось выжить, освоить специальность связиста и даже получить два ордена. Но впереди главное испытание — роковая высота Сто, которую советским бойцам предстоит взять ценой огромных потерь. Чтение книги погрузит читателей во фронтовую атмосферу и покажет, как тяжело далась русскому народу победа.',2023,'АСТ','Виктор Астафьев',800,'b45f797f-1dd0-4fd5-8d33-0ef8bd9e8d65',10,2),(4,'Идеалы христианской жизни','Книга «Идеалы христианской жизни»  об этом, она  воплощение самых заветных идей и упований автора. «Идеалы христианской жизни  это идеалы христианского счастья... Это счастье тем исключительно, что оно совершенно не зависит от тех внешних обстоятельств, из которых складывается счастье мирское». Здесь читатель найдет все лучшее, что отличает творчество писателя  яркое, образное слово, прекрасный стиль и, вместе с тем,  обращение к самым глубоким пластам жизни христианской души.',2019,'Православное издательство \"Сатисъ\"','Поселянин Евгений Николаевич',631,'24d66f87-2655-47f2-bf52-acd23a94ed06',0,0),(6,'Книга1','пвичва',111,'авыау','фуымыфувкм',111,'dd5aa365-05c7-4f3e-aac4-f730a091b7ca',0,0),(7,'Книга2','амиыаим кап фык',111,'авыау','фуымыфувкм',111,'dd5aa365-05c7-4f3e-aac4-f730a091b7ca',0,0),(8,'Книга3','саеьбнгл огнал',111,'авыау','фуымыфувкм',111,'55622c63-074c-41b4-b71e-6e6a1e0d9403',0,0),(9,'Книга4','твчкпеаитвчекир',111,'авыау','фуымыфувкм',111,'eaaf7dea-c408-43ea-bb91-7f832b086556',0,0),(10,'Книга5','ы пекп ыкп ы',111,'авыау','фуымыфувкм',111,'5002a652-c3a2-47f6-95fe-93891f30c0e6',0,0),(11,'Книга6',' цкпыукер вуен рукпркеп куые',111,'авыау','фуымыфувкм',111,'a7acf0fe-a16c-4cf0-b41f-8a677f7a951b',0,0),(12,'Книга7',' пывекп выек врке',111,'авыау','фуымыфувкм',111,'2ac0e54a-4477-4560-9ad5-ce4d88228a5c',0,0),(13,'Книга8',' ург ук5ргценрц у45',111,'авыау','фуымыфувкм',111,'34e12ab5-9276-4db4-bc18-8a8440803095',0,0),(18,'Американские боги','Классика фэнтези. Один из** лучших** романов Нила Геймана. Премия «Хьюго» за лучший роман. Премия «Небьюла» за лучший роман.\r\n\r\n> «Оригинально, захватывающе и бесконечно изобретательно». — Джордж Р.Р. Мартин\r\n\r\nТени мотать в тюрьме три долгих года, но он терпелив. Дома, в родном городке Игл-Пойнт, Индиана, его ждут любимая жена Лора и шанс начать жизнь с чистого листа. \r\nДо освобождения остается всего несколько дней, когда случается трагедия: автокатастрофа забирает жизнь Лоры. Теперь Тени некуда спешить и незачем жить — можно вечно гнить за решеткой.\r\nНо тут в его жизнь врывается мистер Среда — обаятельный аферист, который, кажется, знает о прошлом Тени куда больше, чем он сам. Тень заинтригован и поступает к незнакомцу на службу. Пройдет время, и он поймет, что ввязался в смертельно опасную битву — битву за душу Америки.',2024,' АСТ','Гейман Нил',704,'cafa4c7d-0855-46ff-aaf4-13bbc5edd091',9,2),(19,'Система «Спаси-себя-сам» для Главного Злодея','Ло Бинхэ – плод любви повелителя демонов и женщины из мира людей. Обретя власть над мирами обоих родителей (а заодно получив гарем из сотен жён), он стал величайшим героем… в *дрянной серии веб-новелл*!\r\nТак считал Шэнь Юань, заканчивая читать последнюю главу «Пути гордого бессмертного демона». Но когда приступ ярости от бездарности этой писанины приводит к его внезапной смерти, обозленный читатель перерождается в мире так взбесившего его романа! Да ещё в теле учителя юного Ло Бинхэ – прекрасного, но бессердечного Шэнь Цинцю! И если сюжет будет развиваться как положено, однажды коварного наставника постигнет ужасная кара за козни, учиненные маленькому герою…\r\nТеперь новый Шэнь Цинцю твёрдо намерен завоевать расположение Ло Бинхэ до того, как тот завершит своё восхождение к вершинам власти. А иначе придётся узнать на своей шкуре, какая незавидная участь ждёт главных злодеев!',2024,' Эксмо','Мосян Тунсю',416,'2f705341-949a-4581-9089-892e40aadbcd',7,2);
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `covers`
--

DROP TABLE IF EXISTS `covers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `covers` (
  `id` varchar(100) NOT NULL,
  `file_name` varchar(100) NOT NULL,
  `mime_type` varchar(100) NOT NULL,
  `md5_hash` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_covers_md5_hash` (`md5_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `covers`
--

LOCK TABLES `covers` WRITE;
/*!40000 ALTER TABLE `covers` DISABLE KEYS */;
INSERT INTO `covers` VALUES ('24d66f87-2655-47f2-bf52-acd23a94ed06','6658910465.webp','image/webp','f54b4081f07855713264e68a785d419e'),('2ac0e54a-4477-4560-9ad5-ce4d88228a5c','1623966176_xHKl0aRzD-4.jpg','image/jpeg','06953cfa1ac2848b3088422f25f278dc'),('2f705341-949a-4581-9089-892e40aadbcd','018eeddc-a0d9-75ae-8755-580bd0e1b8ab.webp','image/webp','281d39c976ed74f048547e162020dc52'),('34e12ab5-9276-4db4-bc18-8a8440803095','Samyj-urodlivyj-spyashhij-kot-v-YAponii-2.jpg','image/jpeg','04295571a2e18e39ca881b26e236a79d'),('5002a652-c3a2-47f6-95fe-93891f30c0e6','1433786905_424750850.jpg','image/jpeg','38b503ebb8fee2586b452c3e4fc7f6ef'),('55622c63-074c-41b4-b71e-6e6a1e0d9403','2828262672.jpg','image/jpeg','2721dd27c0a8fa324943c8ec39e51b1d'),('5d3918fd-b2f5-44dd-adff-abd3e65365ea','ea10f4c5603f31d7daef5eb950c80dd5.jpg','image/jpeg','68318d182f9be205ef7f2a1853f387e3'),('6089d26e-74d0-4026-a6fb-2177c430ac5a','gif','image/gif','539fe7d20e2fa699ef13cd81c4efe4de'),('8d7eac1d-ac53-46b8-b649-5d9dcf91889c','e84641a7277b9939f3f90f78498e4825.jpg','image/jpeg','171cfcbd9514f2ace5409124f91ee8d9'),('a7acf0fe-a16c-4cf0-b41f-8a677f7a951b','5b1749928c32a80a523d17af47992d24.jpg','image/jpeg','edf1da923c17b9671d2f747e597d1750'),('b45f797f-1dd0-4fd5-8d33-0ef8bd9e8d65','okkkb16vxr4-204x300.jpg','image/jpeg','a059323eddd1357a73e045e67c62ea5d'),('cafa4c7d-0855-46ff-aaf4-13bbc5edd091','018fafbe-4e4b-7a74-a7c6-40d34c924e8d.webp','image/webp','87f34dd26fb5454079eb0798dc0939d7'),('dd5aa365-05c7-4f3e-aac4-f730a091b7ca','1676678009_gagaru-club-p-milie-shchechki-pinterest-31.jpg','image/jpeg','c26b86f76a5fc493a5778a75777c55b3'),('eaaf7dea-c408-43ea-bb91-7f832b086556','f070932e-68eb-4ac3-ab7f-6516e56bc2ee-scaled.jpg','image/jpeg','505f3c4ea94609a67ac2f5ef6c2a32d6');
/*!40000 ALTER TABLE `covers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_genres_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
INSERT INTO `genres` VALUES (3,'Детектив'),(2,'Драма'),(5,'Классика'),(1,'Комедия'),(6,'Религия'),(4,'Фантастика'),(7,'Фэнтези');
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `book_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `text` text NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_reviews_book_id_books` (`book_id`),
  KEY `fk_reviews_user_id_users` (`user_id`),
  CONSTRAINT `fk_reviews_book_id_books` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_reviews_user_id_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (4,18,2,5,'Благодаря этой книги я влюбилась в творчество автора безоговорочно!\r\nЗдесь и дорожная история путешествия, и моя любимая скандинавская мифология, и в принципе это все мифологически потустороннее, что проникает в наш мир из древности. Когда я встречала это на страницах романа, у меня складывалось ощущение, будто Нил взял все мои мечты из детства о том, что бы я хотела прочитать и вложил в эту книгу. Роман безумно важен для современной литературы и я искренне рекомендую всем его прочитать!','2024-06-16 09:54:49'),(5,3,2,5,'Не знаешь что такое война? Хочешь узнать? Прочитай \"Прокляты и убиты\".\r\nБольшинство книг описывают войну в красивых красках, что тебе самому хочется туда попасть. Эта книга не про прелести войны, а про ее ужасы: грязь, мерзость, вши, смерть, голод, болезни, разочарование, потеря веры. Но это ещё цветочки. Ведь борьба идёт не\r\nтолько на фронте, но ещё и между собой. Какая борьба - это предстоит вам узнать уже самим. Смогут ли люди преодолеть себя и победить настоящего врага?\r\nИногда хочется просто перестать читать и бросить эту книгу в топку. Но не делаешь этого. Собираешься духом и продолжаешь читать.\r\nВ книге много жизней, чьи судьбы особо даже не связаны. А их смерть никак не вызывает сожаления, так как вокруг лежит больше 20 тыс. сотоварищей. А это же мог быть я, - думает солдат. Вот и весь разговор. Все что их объединяет - это война. Поэтому во время чтения ни к кому не привязываешься. Во всех героях есть и темные и светлые начала, которые они используют в сюжете.\r\nРоман описывает не только нашего бойца, но и заходит с другой стороны - со стороны немецкого солдата, которого эта война уже поперек горла и все что происходит вокруг уже кажется им бессмысленным. Единственное их желание - выжить, хотя и этот мотив их уже не сильно интересует, так как они уже на грани срыва.\r\nКнига напоминает разоблачение культа Сталина. Произведение Виктора Астафьева - разоблачение красоты ВОВ.','2024-06-16 10:01:05'),(6,3,1,5,'Отличная книга о событиях Великой Отечественной войны. Очень сильный роман. \"Окопная правда\" показанная глазами молодых 18-летних ребят. Книга написана шикарным языком, читается очень легко. После прочтения стала моей настольной книгой о войне','2024-06-16 10:03:15'),(7,19,2,3,'Если честно, то из всех работ Мосян Тунсю данная новелла понравилась мне меньше остальных. Может, дело в том, что к второму главному герою я не питаю любви( если точнее, он мне вообще не нравится и читать про него было тяжко), а может в том, что сам сюжет не понравился. Однако, хочется отметить, что как комедийное произведение книга действительно отличная: шутки, события и герои и впрямь вызывают улыбку на лице.','2024-06-16 10:11:51'),(8,19,3,4,'Читала систему ещё в электронном варианте очень давно и никак не ожидала, что у нас могут выпустить это чудо. По сравнению с остальными двумя произведениями Мосян эта книга заметно уступает: сюжет прописан не так хорошо, герои недостаточно раскрыты. Но, тем не менее, у меня это произведение вызывает только тёплые чувства, будто ему совершенно не нужно быть хорошо написанным, книга Мосян в любом варианте ощущается как что-то родное и приятно знакомое.','2024-06-16 10:15:07'),(9,18,3,4,'Интересное произведение. Мне дико понравился главный герой. **Тень** - это именно тот человек, который приятен тебе от начала и до конца. Человек, который держит свое слово, который предан до конца, который честен перед собой и перед другими. Он очень правильный, но без ощущения перебора и какой-то дотошности. Тень ван лав.\r\n\r\nОтносительно самого произведения. По моему ощущению, громадный плюс книги в отсутствии *\"элемента Стивена Кинга\"*, который заключается в желании автора пихать магию везде и всюду. Хотя смысл книги очень даже благоволит магии, и можно было бы при желании устроить Хоггвартс на выезде. Супер лайк Нилу Гейману, что он это не сделал. Боги в данном произведении - практически люди. Мне нравится, когда обычные повседневные вещи они делают обычно и повседневно. В этом и есть какой-то сюр. Если бы Заря Утренняя наливала кофе для Тени мановением пальца - я бы даже не дочитала книгу наверное. Хотя против магии как таковой я не имею ничего против, для меня просто важна ее логика и уместность. Тут уместно, например, налить кофе без магии.\r\n\r\nНемного в растерянности от финала. У меня почему-то такое чувство было, что финал должен был поразить меня своей многоходовочкой. Многоходовочка была, поражения не было.','2024-06-16 11:51:18');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Администратор','Суперпользователь, имеет полный доступ к системе.'),(2,'Модератор','Может редактировать данные книг и проводить модерацию рецензий.'),(3,'Пользователь','Может оставлять рецензии.');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(100) NOT NULL,
  `password_hash` varchar(200) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_users_login` (`login`),
  KEY `fk_users_role_id_roles` (`role_id`),
  CONSTRAINT `fk_users_role_id_roles` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'user','scrypt:32768:8:1$lOhkHAk0RQxb8SRE$825d24dd5faed85f428aae7e23ea8d9e386914d6734520a02011568003dcbabf7213c7e6efd7a54d853dafde7710305c45179b3dd13037d472020bbbdc2a2880','Иванов','Олег',NULL,3),(2,'admin','scrypt:32768:8:1$CT2TzUqit90EB8mU$58944e88061543b5055370f18026a6748039425554524f789dad9369301cc8abca43c137b77ba9f500241b7d681349197a1f6a14e399ac17a2df70dd612e6724','Иванов','Олег',NULL,1),(3,'mod','scrypt:32768:8:1$FReQqnUTv5f5KVv1$139e749836f77becc7f508a73bc5500db8ab084a3fe698744ef3313282e76cd4fdc04e972ce53ff5de686f6d0e4f5ba0ce96d0e694c37c3ee194928a68827737','Иванов','Олег',NULL,2);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-16 14:23:49
