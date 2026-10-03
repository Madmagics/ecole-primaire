# Themes du vocabulaire d'anglais sans ordre naturel (mots ranges par ordre alphabetique francais dans chaque theme).
def _l(s):
    return [x.strip() for x in s.split(',') if x.strip()]


THEMES_LIBRES = [
    ('animaux_ferme', 'Les animaux de la maison et de la ferme', _l(
        'cat, dog, mouse, mice, rabbit, rabbits, fish, bird, birds, hamster, parrot, horse, horses, cow, cows, pig, pigs, '
        'sheep, duck, ducks, frog, frogs, hen, chicken, rooster, goat, donkey, turkey, cats, dogs, goose')),
    ('animaux_sauvages', 'Les animaux sauvages', _l(
        'lion, lions, tiger, tigers, elephant, elephants, monkey, monkeys, bear, bears, polar bear, snake, snakes, '
        'giraffe, zebra, kangaroo, crocodile, wolf, fox, deer, camel, hedgehog, squirrel, lizard, frog, frogs, turtle, '
        'tortoise, penguin, eagle, owl, peacock, swan, bat')),
    ('animaux_mer', 'Les animaux de la mer', _l('whale, dolphin, shark, octopus, crab, seal')),
    ('petites_betes', 'Les petites bêtes', _l('ant, bee, butterfly, spider, snail, fly, ladybird, worm')),
    ('adj_taille', 'La taille, le poids, la vitesse', _l(
        'big, small, tall, short, long, heavy, light, fast, slow, strong, weak, wide, narrow, high, low')),
    ('adj_etat', "L'âge, l'état, la difficulté", _l(
        'old, young, new, clean, dirty, full, empty, easy, difficult, hot, cold, rich, poor, cheap, expensive, loud, quiet')),
    ('comp_plus', 'Plus ... que', []),
    ('comp_moins', 'Moins ... que', []),
    ('comp_aussi', 'Aussi ... que', []),
    ('comparatifs', 'Le comparatif (plus ...)', []),
    ('superlatifs', 'Le superlatif (le plus ...)', []),
    ('demonstratifs', 'This, that, these, those', []),
    ('ecole_objets', "Les affaires d'école", _l(
        'pencil, pencils, pen, rubber, rubbers, ruler, rulers, schoolbag, bag, book, books, notebook, glue, scissors, '
        'pencil sharpener, calculator, binder, stapler, marker, map, computer')),
    ('ecole_classe', "Dans l'école", _l(
        'chair, table, blackboard, teacher, playground, canteen, timetable, homework, classroom, desk')),
    ('ecole_matieres', 'Les matières', _l('english, maths, art, music, pe, science, history, geography, french')),
    ('emotions', 'Comment je me sens', _l('happy, sad, angry, scared, tired, hungry, thirsty, surprised, sick, bored')),
    ('caractere', 'Le caractère', _l('nice, funny, brave, shy, clever, busy, noisy, quiet, kind, lazy')),
    ('sports', 'Les sports et les loisirs', _l(
        'football, rugby, tennis, basketball, volleyball, golf, judo, swimming, cycling, running, climbing, skating, '
        'skiing, gymnastics, horse riding, fishing, dancing, drawing, reading, singing, chess')),
    ('instruments', 'Les instruments de musique', _l('piano, guitar, violin, drum, drums, flute, trumpet, harp')),
    ('jouets', 'Les jouets', _l('ball, doll, kite, puzzle, robot, blocks, teddy bear, skipping rope, spinning top')),
    ('metiers', 'Les métiers', _l(
        'actor, architect, baker, butcher, cashier, cook, dentist, doctor, driver, electrician, engineer, farmer, '
        'firefighter, hairdresser, journalist, judge, lawyer, mechanic, musician, nurse, painter, pilot, plumber, '
        'police officer, postman, sailor, scientist, singer, soldier, vet, waiter, writer, teacher')),
    ('pieces', 'Les pièces de la maison', _l(
        'bedroom, kitchen, bathroom, living room, garden, garage, cellar, attic')),
    ('maison', 'La maison', _l('door, window, wall, floor, ceiling, roof, stairs')),
    ('meubles', 'Les meubles et les objets', _l(
        'bed, sofa, fridge, oven, sink, bowl, cup, glass, plate, fork, knife, spoon, pot, frying pan')),
    ('meteo', "Le temps qu'il fait", _l(
        'sunny, rainy, windy, cloudy, snowy, foggy, sun, rain, wind, cloud, snow, fog, frost, ice, storm, thunder, '
        'lightning')),
    ('ciel', 'Le ciel', _l('sky, moon, star')),
    ('paysages', 'Les paysages', _l(
        'beach, sea, river, lake, mountain, hill, valley, island, desert, volcano, forest, sand, stone')),
    ('plantes', 'Les plantes', _l('tree, flower, leaf, branch, root, seed, grass')),
    ('fruits', 'Les fruits', _l(
        'apple, apples, banana, bananas, cherry, grape, lemon, peach, pear, pineapple, strawberry, watermelon')),
    ('legumes', 'Les légumes', _l('carrot, potato, tomato, onion, mushroom, salad')),
    ('repas', 'Les repas', _l('breakfast, lunch, dinner, snack')),
    ('aliments', 'Les autres aliments', _l(
        'bread, butter, cake, cakes, cereal, cheese, chocolate, cookie, cream, egg, eggs, honey, jam, juice, meat, milk, '
        'pasta, pepper, rice, fish, salt, sandwich, soup, sugar, water, yogurt')),
    ('pays', 'Les pays', _l('france, england, spain, italy, germany, ireland, canada, scotland, wales, japan, china')),
    ('nationalites', 'Les nationalités et les langues', _l(
        'french, english, spanish, italian, german, irish, scottish, welsh, greek, russian, swedish, swiss, indian, '
        'mexican, japanese, chinese, brazilian, portuguese, australian, belgian, american, canadian')),
    ('politesse', 'Être poli', _l("hello, goodbye, please, thank you, sorry, welcome, you're welcome, yes, no")),
    ('consignes', 'Les consignes', _l('listen, look, stop')),
    ('question_mots', 'Les mots pour poser une question', _l('who, what, where, when, why, how')),
    ('positions', 'Où est-ce ?', _l('in, on, under, behind, in front of, next to, between')),
    ('verbes', 'Les verbes', []),
    ('vetements', 'Les vêtements', _l(
        'coat, jacket, jumper, sweater, shirt, dress, trousers, tie, belt, hat, scarf, gloves, socks, shoes, pyjamas')),
    ('lieux', 'Les lieux de la ville', _l(
        'park, beach, shop, market, station, airport, hospital, library, museum, church, castle, hotel, zoo, farm, '
        'swimming pool, town hall, bridge, street, city, village')),
    ('transports', 'Les transports', _l(
        'car, bus, train, plane, boat, ship, sailboat, bike, motorbike, scooter, taxi, truck, tractor, helicopter, '
        'rocket, on foot')),
    ('voyage', 'Le voyage', _l('passport, suitcase, ticket')),
]
