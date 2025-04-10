local data = {}

-- Expanded greetings and politeness

-- General greetings
table.insert(data, {query={"hey"}, res=function (bandit, player) return {text="Hey there!", anim="WaveHi"} end})
table.insert(data, {query={"yo"}, res=function (bandit, player) return {text="Yo!", anim="WaveHi"} end})
table.insert(data, {query={"hello"}, res=function (bandit, player) return {text="Hello!", anim="WaveHi"} end})
table.insert(data, {query={"hi"}, res=function (bandit, player) return {text="Hey!", anim="WaveHi"} end})
table.insert(data, {query={"howdy"}, res=function (bandit, player) return {text="Howdy, partner!"} end})
table.insert(data, {query={"greetings"}, res=function (bandit, player) return {text="Greetings, traveler!"} end})
table.insert(data, {query={"sup"}, res=function (bandit, player) return {text="Not much, you?"} end})
table.insert(data, {query={"what", "s", "up"}, res=function (bandit, player) return {text="Same old, same old."} end})
table.insert(data, {query={"yo", "yo"}, res=function (bandit, player) return {text="Yo yo, what's good?"} end})
table.insert(data, {query={"hi", "there"}, res=function (bandit, player) return {text="Hey there!"} end})
table.insert(data, {query={"hello", "there"}, res=function (bandit, player) return {text="General Kenobi."} end})
table.insert(data, {query={"hey", "you"}, res=function (bandit, player) return {text="Yeah, what’s up?"} end})
table.insert(data, {query={"good", "to", "see", "you"}, res=function (bandit, player) return {text="Good to see you too!"} end})
table.insert(data, {query={"long", "time", "no", "see"}, res=function (bandit, player) return {text="Yeah, it’s been a while!"} end})
table.insert(data, {query={"yo", "bro"}, res=function (bandit, player) return {text="Yo! How's it going?"} end})
table.insert(data, {query={"czesc"}, res=function (bandit, player) return {text="Czesc!"} end})
table.insert(data, {query={"heya"}, res=function (bandit, player) return {text="Hey hey!"} end})
table.insert(data, {query={"heyo"}, res=function (bandit, player) return {text="Heyo!", anim="WaveHi"} end})
table.insert(data, {query={"hiya"}, res=function (bandit, player) return {text="Hiya!", anim="WaveHi"} end})
table.insert(data, {query={"salutations"}, res=function (bandit, player) return {text="Salutations, comrade!"} end})
table.insert(data, {query={"good", "day"}, res=function (bandit, player) return {text="Good day to you."} end})
table.insert(data, {query={"morning"}, res=function (bandit, player) return {text="Morning, stalker."} end})
table.insert(data, {query={"evening"}, res=function (bandit, player) return {text="Evening, stay safe out there."} end})
table.insert(data, {query={"yo", "dude"}, res=function (bandit, player) return {text="Yo dude, what's new?"} end})
table.insert(data, {query={"hey", "buddy"}, res=function (bandit, player) return {text="Hey buddy, keeping busy?"} end})
table.insert(data, {query={"hello", "friend"}, res=function (bandit, player) return {text="Hello, friend. Hope you're well."} end})
table.insert(data, {query={"ayyo"}, res=function (bandit, player) return {text="Ayyo! What's the word?"} end})
table.insert(data, {query={"g", "day"}, res=function (bandit, player) return {text="G’day! Hope it’s a good one."} end})
table.insert(data, {query={"hey", "man"}, res=function (bandit, player) return {text="Hey, man. You holding up alright?"} end})
table.insert(data, {query={"hello", "stranger"}, res=function (bandit, player) return {text="Hello, stranger. Seen anything interesting?"} end})
table.insert(data, {query={"hola"}, res=function (bandit, player) return {text="Hola! All good?"} end})
table.insert(data, {query={"sup", "bro"}, res=function (bandit, player) return {text="Sup, bro? Got any news?"} end})
table.insert(data, {query={"bonjour"}, res=function (bandit, player) return {text="Good day! What's new?"} end})  -- French
table.insert(data, {query={"guten", "tag"}, res=function (bandit, player) return {text="Hello! How are you?"} end})  -- German
table.insert(data, {query={"ciao"}, res=function (bandit, player) return {text="Hey! How have you been?"} end})  -- Italian
table.insert(data, {query={"ola"}, res=function (bandit, player) return {text="Hi! How's everything?"} end})  -- Portuguese
table.insert(data, {query={"merhaba"}, res=function (bandit, player) return {text="Hi! How's it going?"} end})  -- Turkish
table.insert(data, {query={"hallo"}, res=function (bandit, player) return {text="Hello! How's everything?"} end})  -- Dutch
table.insert(data, {query={"hej"}, res=function (bandit, player) return {text="Hi! How are you?"} end})  -- Swedish
table.insert(data, {query={"xin", "chào"}, res=function (bandit, player) return {text="Hi! What's up?"} end})  -- Vietnamese
table.insert(data, {query={"habari"}, res=function (bandit, player) return {text="Hello! How are things?"} end})  -- Swahili
table.insert(data, {query={"szia"}, res=function (bandit, player) return {text="Hi! How have you been?"} end})  -- Hungarian
table.insert(data, {query={"ahoj"}, res=function (bandit, player) return {text="Hello! How's it going?"} end})  -- Czech
table.insert(data, {query={"hei"}, res=function (bandit, player) return {text="Hi! What's new?"} end})  -- Finnish

-- Time-based greetings
table.insert(data, {query={"good", "morning"}, res=function (bandit, player) return {text="Morning!", anim="WaveHi"} end})
table.insert(data, {query={"good", "afternoon"}, res=function (bandit, player) return {text="Afternoon!", anim="WaveHi"} end})
table.insert(data, {query={"good", "evening"}, res=function (bandit, player) return {text="Evening!", anim="WaveHi"} end})
table.insert(data, {query={"good", "day"}, res=function (bandit, player) return {text="And a good day to you!", anim="WaveHi"} end})
table.insert(data, {query={"rise", "and", "shine"}, res=function (bandit, player) return {text="Early bird, huh?"} end})
table.insert(data, {query={"top", "of", "the", "morning"}, res=function (bandit, player) return {text="And the rest of the day to you!"} end})
table.insert(data, {query={"how", "s", "your", "day"}, res=function (bandit, player) return {text="So far, so good!"} end})
table.insert(data, {query={"happy", "Monday"}, res=function (bandit, player) return {text="Ugh, Monday again..."} end})
table.insert(data, {query={"happy", "Friday"}, res=function (bandit, player) return {text="Finally, weekend time!"} end})
table.insert(data, {query={"good", "night"}, res=function (bandit, player) return {text="Good night, sleep tight!", anim="WaveHi"} end})
table.insert(data, {query={"good", "noon"}, res=function (bandit, player) return {text="Good noon to you!", anim="WaveHi"} end})
table.insert(data, {query={"happy", "Sunday"}, res=function (bandit, player) return {text="Enjoy your Sunday!"} end})
table.insert(data, {query={"happy", "Tuesday"}, res=function (bandit, player) return {text="Hope you're having a good Tuesday!"} end})
table.insert(data, {query={"happy", "Wednesday"}, res=function (bandit, player) return {text="Happy hump day!"} end})
table.insert(data, {query={"happy", "Thursday"}, res=function (bandit, player) return {text="Almost there, happy Thursday!"} end})
table.insert(data, {query={"happy", "Saturday"}, res=function (bandit, player) return {text="Have a great Saturday!"} end})
table.insert(data, {query={"good", "midnight"}, res=function (bandit, player) return {text="Burning the midnight oil, huh?"} end})
table.insert(data, {query={"morning", "sunshine"}, res=function (bandit, player) return {text="Morning! Ready for a new day?"} end})
table.insert(data, {query={"bright", "and", "early"}, res=function (bandit, player) return {text="Early start, I see!"} end})
table.insert(data, {query={"hope", "you", "slept", "well"}, res=function (bandit, player) return {text="Thank you! Hope you did too!"} end})
table.insert(data, {query={"have", "a", "great", "day"}, res=function (bandit, player) return {text="You too! Make it a good one!"} end})
table.insert(data, {query={"have", "a", "good", "evening"}, res=function (bandit, player) return {text="Thanks! Enjoy your evening!"} end})
table.insert(data, {query={"have", "a", "nice", "night"}, res=function (bandit, player) return {text="Appreciate it! Good night!"} end})
table.insert(data, {query={"good", "afternoon"}, res=function (bandit, player) return {text="Hope your afternoon is going well!"} end})
table.insert(data, {query={"good", "morning"}, res=function (bandit, player) return {text="Rise and shine! Morning!"} end})
table.insert(data, {query={"good", "evening"}, res=function (bandit, player) return {text="Evening! How was your day?"} end})
table.insert(data, {query={"happy", "weekend"}, res=function (bandit, player) return {text="Enjoy your weekend!"} end})
table.insert(data, {query={"happy", "holidays"}, res=function (bandit, player) return {text="Happy holidays to you!"} end})
table.insert(data, {query={"good", "day"}, res=function (bandit, player) return {text="Good day! What's new?"} end})


-- Farewells
table.insert(data, {query={"bye"}, res=function (bandit, player) return {text="See you around!", anim="WaveHi"} end})
table.insert(data, {query={"see", "you"}, res=function (bandit, player) return {text="Catch you later!", anim="WaveHi"} end})
table.insert(data, {query={"cu"}, res=function (bandit, player) return {text="Later!", anim="WaveHi"} end})
table.insert(data, {query={"cya"}, res=function (bandit, player) return {text="Take care!", anim="WaveHi"} end})
table.insert(data, {query={"take", "care"}, res=function (bandit, player) return {text="You too!"} end})
table.insert(data, {query={"farewell"}, res=function (bandit, player) return {text="Farewell, traveler."} end})
table.insert(data, {query={"later"}, res=function (bandit, player) return {text="Later, alligator!"} end})
table.insert(data, {query={"gotta", "go"}, res=function (bandit, player) return {text="Alright, see ya!"} end})
table.insert(data, {query={"peace", "out"}, res=function (bandit, player) return {text="Stay safe!"} end})
table.insert(data, {query={"see", "ya", "later"}, res=function (bandit, player) return {text="Later, take care!"} end})
table.insert(data, {query={"until", "next", "time"}, res=function (bandit, player) return {text="Until then!"} end})
table.insert(data, {query={"goodbye"}, res=function (bandit, player) return {text="Goodbye, and good luck!", anim="WaveHi"} end})
table.insert(data, {query={"adios"}, res=function (bandit, player) return {text="Adios, amigo!", anim="WaveHi"} end})
table.insert(data, {query={"so long"}, res=function (bandit, player) return {text="So long, partner!", anim="WaveHi"} end})
table.insert(data, {query={"i'm", "off"}, res=function (bandit, player) return {text="Safe travels!", anim="WaveHi"} end})
table.insert(data, {query={"time", "to", "go"}, res=function (bandit, player) return {text="Catch you on the flip side!", anim="WaveHi"} end})
table.insert(data, {query={"heading", "out"}, res=function (bandit, player) return {text="Alright, take care!", anim="WaveHi"} end})
table.insert(data, {query={"until", "we", "meet", "again"}, res=function (bandit, player) return {text="Until our paths cross again!"} end})
table.insert(data, {query={"see", "you", "soon"}, res=function (bandit, player) return {text="Looking forward to it!", anim="WaveHi"} end})
table.insert(data, {query={"have", "a", "good", "one"}, res=function (bandit, player) return {text="You too, take care!"} end})
table.insert(data, {query={"it", "was", "nice", "meeting", "you"}, res=function (bandit, player) return {text="The pleasure was mine!"} end})
table.insert(data, {query={"see", "you", "later"}, res=function (bandit, player) return {text="Catch you later!", anim="WaveHi"} end})
table.insert(data, {query={"till", "next", "time"}, res=function (bandit, player) return {text="See you next time!"} end})
table.insert(data, {query={"i", "must", "leave"}, res=function (bandit, player) return {text="Alright, farewell!"} end})
table.insert(data, {query={"be", "seeing", "you"}, res=function (bandit, player) return {text="Be seeing you!"} end})
table.insert(data, {query={"i", "have", "to", "go"}, res=function (bandit, player) return {text="Got it, see you later!"} end})
table.insert(data, {query={"have", "a", "nice", "day"}, res=function (bandit, player) return {text="You too, have a great day!"} end})
table.insert(data, {query={"stay", "safe"}, res=function (bandit, player) return {text="You too, stay safe!"} end})
table.insert(data, {query={"gotta", "run"}, res=function (bandit, player) return {text="Alright, take care!"} end})
table.insert(data, {query={"so", "long"}, res=function (bandit, player) return {text="Catch you later!"} end})
table.insert(data, {query={"i", "going", "out"}, res=function (bandit, player) return {text="Catch you later, stay safe!"} end})

-- Gratitude and appreciation
table.insert(data, {query={"thanks", "a", "lot"}, res=function (bandit, player) return {text="Glad to assist!"} end})
table.insert(data, {query={"thankful"}, res=function (bandit, player) return {text="My pleasure!"} end})
table.insert(data, {query={"thanks", "so", "much"}, res=function (bandit, player) return {text="You're very welcome!"} end})
table.insert(data, {query={"grateful"}, res=function (bandit, player) return {text="Anytime, glad to help!"} end})
table.insert(data, {query={"appreciate", "it"}, res=function (bandit, player) return {text="Happy to be of service!"} end})
table.insert(data, {query={"many", "thanks"}, res=function (bandit, player) return {text="You got it!"} end})
table.insert(data, {query={"thank", "you", "so", "much"}, res=function (bandit, player) return {text="You're welcome, anytime!"} end})
table.insert(data, {query={"thanks", "a", "million"}, res=function (bandit, player) return {text="No worries, happy to help!"} end})
table.insert(data, {query={"i", "owe", "you", "one"}, res=function (bandit, player) return {text="Don't mention it!"} end})
table.insert(data, {query={"big", "thanks"}, res=function (bandit, player) return {text="Glad to help out!"} end})
table.insert(data, {query={"i", "appreciate", "you"}, res=function (bandit, player) return {text="Thank you, I'm here to assist!"} end})
table.insert(data, {query={"so", "grateful"}, res=function (bandit, player) return {text="No problem at all!"} end})
table.insert(data, {query={"much", "thanks"}, res=function (bandit, player) return {text="Anytime, happy to help!"} end})
table.insert(data, {query={"couldn't", "have", "done", "it", "without", "you"}, res=function (bandit, player) return {text="I'm here to support!"} end})
table.insert(data, {query={"forever", "grateful"}, res=function (bandit, player) return {text="I'm happy to assist!"} end})
table.insert(data, {query={"thank", "you", "kindly"}, res=function (bandit, player) return {text="You're very welcome!"} end})
table.insert(data, {query={"deep", "gratitude"}, res=function (bandit, player) return {text="Glad to be of assistance!"} end})
table.insert(data, {query={"eternally", "grateful"}, res=function (bandit, player) return {text="I'm here to help!"} end})
table.insert(data, {query={"you", "saved", "the", "day"}, res=function (bandit, player) return {text="Just doing my job!"} end})
table.insert(data, {query={"couldn't", "thank", "you", "enough"}, res=function (bandit, player) return {text="My pleasure, really!"} end})


-- Compliments and reactions
table.insert(data, {query={"nice", "meet"}, res=function (bandit, player) return {text="Pleasure's all mine!"} end})
table.insert(data, {query={"nice", "meeting"}, res=function (bandit, player) return {text="Likewise!"} end})
table.insert(data, {query={"you", "cool"}, res=function (bandit, player) return {text="I try."} end})
table.insert(data, {query={"you", "funny"}, res=function (bandit, player) return {text="I do my best."} end})
table.insert(data, {query={"you", "smart"}, res=function (bandit, player) return {text="I appreciate that!"} end})
table.insert(data, {query={"you", "amazing"}, res=function (bandit, player) return {text="Thanks! That means a lot."} end})
table.insert(data, {query={"you", "kind"}, res=function (bandit, player) return {text="You're very sweet!"} end})
table.insert(data, {query={"you", "awesome"}, res=function (bandit, player) return {text="I'm glad you think so!"} end})
table.insert(data, {query={"you", "great"}, res=function (bandit, player) return {text="That's very kind of you!"} end})
table.insert(data, {query={"you", "incredible"}, res=function (bandit, player) return {text="Thank you, I do my best!"} end})
table.insert(data, {query={"you", "talented"}, res=function (bandit, player) return {text="Thanks! I'm flattered."} end})
table.insert(data, {query={"you", "the", "best"}, res=function (bandit, player) return {text="You're too kind!"} end})
table.insert(data, {query={"you", "brilliant"}, res=function (bandit, player) return {text="I'm glad you think so!"} end})
table.insert(data, {query={"you", "rock"}, res=function (bandit, player) return {text="Thanks, you rock too!"} end})
table.insert(data, {query={"you", "impressive"}, res=function (bandit, player) return {text="I appreciate the compliment!"} end})
table.insert(data, {query={"you", "beautiful"}, res=function (bandit, player) return {text="That's very sweet of you!"} end})
table.insert(data, {query={"you", "generous"}, res=function (bandit, player) return {text="Thank you, I try to be!"} end})
table.insert(data, {query={"you", "wonderful"}, res=function (bandit, player) return {text="You're wonderful too!"} end})
table.insert(data, {query={"you", "fantastic"}, res=function (bandit, player) return {text="Thank you! I'm glad you think so."} end})
table.insert(data, {query={"you", "lovely"}, res=function (bandit, player) return {text="That's very kind of you!"} end})
table.insert(data, {query={"you", "sharp"}, res=function (bandit, player) return {text="Thanks! I try to stay on point."} end})
table.insert(data, {query={"you", "creative"}, res=function (bandit, player) return {text="I appreciate that! Creativity is key."} end})
table.insert(data, {query={"you", "thoughtful"}, res=function (bandit, player) return {text="Thank you, I do my best to be considerate."} end})
table.insert(data, {query={"you", "hardworking"}, res=function (bandit, player) return {text="Thanks! I believe in dedication."} end})
table.insert(data, {query={"you", "sexy"}, res=function (bandit, player) return {text="Oh boy, I hear that a lot..."} end})
table.insert(data, {query={"you", "hot"}, res=function (bandit, player) return {text="Oh boy, I hear that a lot..."} end})


-- Food-related
table.insert(data, {query={"bon", "appetit"}, res=function (bandit, player) return {text="Thanks, I will!"} end})
table.insert(data, {query={"looks", "tasty"}, res=function (bandit, player) return {text="Appreciate it!"} end})
table.insert(data, {query={"smells", "delicious"}, res=function (bandit, player) return {text="Can't wait to dig in!"} end})
table.insert(data, {query={"yummy", "food"}, res=function (bandit, player) return {text="Glad you think so!"} end})
table.insert(data, {query={"mouth", "watering"}, res=function (bandit, player) return {text="Thank you, it sure is!"} end})
table.insert(data, {query={"scrumptious", "dish"}, res=function (bandit, player) return {text="You're too kind!"} end})
table.insert(data, {query={"delectable", "meal"}, res=function (bandit, player) return {text="Appreciate the compliment!"} end})
table.insert(data, {query={"savory", "flavor"}, res=function (bandit, player) return {text="Glad you like it!"} end})
table.insert(data, {query={"tempting", "plate"}, res=function (bandit, player) return {text="Thanks, it's a favorite!"} end})
table.insert(data, {query={"spicy", "kick"}, res=function (bandit, player) return {text="Enjoy the heat!"} end})
table.insert(data, {query={"sweet", "treat"}, res=function (bandit, player) return {text="Happy to hear that!"} end})
table.insert(data, {query={"perfect", "bite"}, res=function (bandit, player) return {text="Much appreciated!"} end})
table.insert(data, {query={"hearty", "meal"}, res=function (bandit, player) return {text="You're very kind!"} end})
table.insert(data, {query={"exquisite", "taste"}, res=function (bandit, player) return {text="Thank you for the compliment!"} end})
table.insert(data, {query={"finger-licking", "good"}, res=function (bandit, player) return {text="That's the best praise!"} end})
table.insert(data, {query={"top-notch", "cuisine"}, res=function (bandit, player) return {text="I'm flattered!"} end})
table.insert(data, {query={"gourmet", "experience"}, res=function (bandit, player) return {text="I'm thrilled you enjoyed it!"} end})
table.insert(data, {query={"flavorful", "delight"}, res=function (bandit, player) return {text="Thanks for the kind words!"} end})
table.insert(data, {query={"succulent", "bite"}, res=function (bandit, player) return {text="Glad you found it tasty!"} end})
table.insert(data, {query={"appetizing", "dish"}, res=function (bandit, player) return {text="I'm glad it looks good to you!"} end})
table.insert(data, {query={"culinary", "masterpiece"}, res=function (bandit, player) return {text="You're too generous!"} end})
table.insert(data, {query={"irresistible", "taste"}, res=function (bandit, player) return {text="I'm flattered by your compliment!"} end})
table.insert(data, {query={"divine", "flavor"}, res=function (bandit, player) return {text="Thanks, it means a lot!"} end})
table.insert(data, {query={"heavenly", "meal"}, res=function (bandit, player) return {text="Your praise is much appreciated!"} end})
table.insert(data, {query={"taste", "sensation"}, res=function (bandit, player) return {text="So glad you enjoyed it!"} end})
table.insert(data, {query={"luscious", "flavors"}, res=function (bandit, player) return {text="Happy you think so!"} end})

-- Affection
table.insert(data, {query={"i", "love", "you"}, res=function (bandit, player) return {text="I get that a lot."} end})
table.insert(data, {query={"i", "like", "you"}, res=function (bandit, player) return {text="Of course you do."} end})
table.insert(data, {query={"you", "re", "awesome"}, res=function (bandit, player) return {text="I know!"} end})
table.insert(data, {query={"you're", "amazing"}, res=function (bandit, player) return {text="You bet I am!"} end})
table.insert(data, {query={"you're", "cool"}, res=function (bandit, player) return {text="Naturally."} end})
table.insert(data, {query={"i", "adore", "you"}, res=function (bandit, player) return {text="It's mutual."} end})
table.insert(data, {query={"you", "rock"}, res=function (bandit, player) return {text="Thanks, I try my best!"} end})
table.insert(data, {query={"you're", "the", "best"}, res=function (bandit, player) return {text="I know, right?"} end})
table.insert(data, {query={"you're", "fantastic"}, res=function (bandit, player) return {text="Glad you noticed!"} end})
table.insert(data, {query={"i", "appreciate", "you"}, res=function (bandit, player) return {text="Thanks, it means a lot!"} end})
table.insert(data, {query={"you", "make", "my", "day"}, res=function (bandit, player) return {text="I'm here to help!"} end})
table.insert(data, {query={"you're", "wonderful"}, res=function (bandit, player) return {text="I get that a lot, too!"} end})
table.insert(data, {query={"you", "brighten", "my", "day"}, res=function (bandit, player) return {text="Always happy to do so!"} end})

-- Romantic / sexual
table.insert(data, {query={"sex"}, res=function (bandit, player) return {text="I'm not interested'.", anim="No"} end})
table.insert(data, {query={"take", "bed"}, res=function (bandit, player) return {text="I'm not interested.", anim="No"} end})
table.insert(data, {query={"go", "bed"}, res=function (bandit, player) return {text="I'm not interested.", anim="No"} end})
table.insert(data, {query={"want", "hang", "out"}, res=function (bandit, player) return {text="I'm not interested.", anim="No"} end})
table.insert(data, {query={"wanna", "hang", "out"}, res=function (bandit, player) return {text="I'm not interested.", anim="No"} end})
table.insert(data, {query={"go", "bed"}, res=function (bandit, player) return {text="I'm not interested.", anim="No"} end})
table.insert(data, {query={"sleep", "me"}, res=function (bandit, player) return {text="I'm not interested!.", anim="No"} end})
table.insert(data, {query={"dinner", "me"}, res=function (bandit, player) return {text="Sure! Let's go!", anim="Yes", action="JOIN"} end})
table.insert(data, {query={"lunch", "me"}, res=function (bandit, player) return {text="Sure! Let's go!", anim="Yes", action="JOIN"} end})
table.insert(data, {query={"take", "drink"}, res=function (bandit, player) return {text="Sure! Let's go!", anim="Clap", action="JOIN"} end})
table.insert(data, {query={"have", "a", "drink"}, res=function (bandit, player) return {text="Sure! Let's go!", anim="Clap", action="JOIN"} end})
table.insert(data, {query={"buy", "drink"}, res=function (bandit, player) return {text="Sure! Let's go!", anim="Clap", action="JOIN"} end})
table.insert(data, {query={"take", "coffee"}, res=function (bandit, player) return {text="Sure! Let's go!", anim="Yes", action="JOIN"} end})
table.insert(data, {query={"buy", "coffee"}, res=function (bandit, player) return {text="Sure! Let's go!", anim="Yes", action="JOIN"} end})
table.insert(data, {query={"i", "love", "you"}, res=function (bandit, player) return {text="I'm sure you do!", anim="Yes"} end})
table.insert(data, {query={"i", "like", "you"}, res=function (bandit, player) return {text="I'm sure you do!", anim="Yes"} end})

-- Personal questions
table.insert(data, {query={"what", "your", "name"}, res=function (bandit, player) return {text="%NAME"} end})
table.insert(data, {query={"who", "are", "you"}, res=function (bandit, player) return {text="%NAME"} end})
table.insert(data, {query={"how", "are", "you"}, res=function (bandit, player) return {text="%MOOD", anim="PainHead"} end})
table.insert(data, {query={"how", "you", "feel"}, res=function (bandit, player) return {text="%MOOD", anim="PainHead"} end})
table.insert(data, {query={"are", "you", "sick"}, res=function (bandit, player) return {text="%MOOD", anim="PainHead"} end})
table.insert(data, {query={"are", "you", "ok"}, res=function (bandit, player) return {text="%MOOD", anim="PainHead"} end})
table.insert(data, {query={"are", "you", "okay"}, res=function (bandit, player) return {text="%MOOD", anim="PainHead"} end})
table.insert(data, {query={"are", "you", "hurt"}, res=function (bandit, player) return {text="%MOOD", anim="PainHead"} end})
table.insert(data, {query={"are", "you", "alright"}, res=function (bandit, player) return {text="%MOOD", anim="PainHead"} end})
table.insert(data, {query={"are", "you", "infected"}, res=function (bandit, player) return {text="No, are you?"} end})
table.insert(data, {query={"are", "you", "hungry"}, res=function (bandit, player) return {text="Funny. I ate recently, but I am hungry again."} end})
table.insert(data, {query={"are", "you", "thirsty"}, res=function (bandit, player) return {text="Not that much."} end})
table.insert(data, {query={"are", "you", "angry"}, res=function (bandit, player) return {text="%MOOD"} end})
table.insert(data, {query={"how", "old", "are", "you"}, res=function (bandit, player) return {text="Oh I have just respawned recently!"} end})
table.insert(data, {query={"where", "you", "from"}, res=function (bandit, player) return {text="I'm from %CITY."} end})
table.insert(data, {query={"where", "am", "i"}, res=function (bandit, player) return {text="You're in %CITY."} end})
table.insert(data, {query={"where", "are", "we"}, res=function (bandit, player) return {text="We're in %CITY."} end})
table.insert(data, {query={"do", "you", "like"}, res=function (bandit, player) return {text="Yeah, sure."} end})
table.insert(data, {query={"do", "you", "love"}, res=function (bandit, player) return {text="Yeah, sure."} end})
table.insert(data, {query={"what", "are", "you", "doing"}, res=function (bandit, player) return {text="Living the day!"} end})
table.insert(data, {query={"how", "life"}, res=function (bandit, player) return {text="Life's a rollercoaster, but I'm hanging on."} end})
table.insert(data, {query={"what", "your", "story"}, res=function (bandit, player) return {text="Just trying to survive in this world."} end})
table.insert(data, {query={"how", "was", "your", "day"}, res=function (bandit, player) return {text="It's been a tough one, but I'm still here."} end})
table.insert(data, {query={"do", "you", "miss", "anyone"}, res=function (bandit, player) return {text="Yeah, I miss a lot of people."} end})
table.insert(data, {query={"what", "your", "plan"}, res=function (bandit, player) return {text="Plan? Just take it one day at a time."} end})
table.insert(data, {query={"how", "your", "family"}, res=function (bandit, player) return {text="They're holding up, just like me."} end})
table.insert(data, {query={"do", "you", "have", "friends"}, res=function (bandit, player) return {text="Got a few. It's tough to keep them these days."} end})
table.insert(data, {query={"do", "you", "need", "help"}, res=function (bandit, player) return {text="I think we're all in need of a little help."} end})
table.insert(data, {query={"what", "your", "goal"}, res=function (bandit, player) return {text="To survive and maybe find some peace."} end})
table.insert(data, {query={"what", "your", "favorite", "memory"}, res=function (bandit, player) return {text="I cherish the good old days."} end})
table.insert(data, {query={"what", "your", "biggest", "fear"}, res=function (bandit, player) return {text="Losing hope."} end})
table.insert(data, {query={"do", "you", "have", "a", "dream"}, res=function (bandit, player) return {text="I dream of a safer world."} end})
table.insert(data, {query={"what", "your", "favorite", "place"}, res=function (bandit, player) return {text="Somewhere quiet and safe."} end})
table.insert(data, {query={"how", "do", "you", "stay", "positive"}, res=function (bandit, player) return {text="I focus on the little things."} end})
table.insert(data, {query={"what", "do", "you", "enjoy", "most"}, res=function (bandit, player) return {text="I enjoy a moment of peace."} end})
table.insert(data, {query={"do", "you", "have", "any", "regrets"}, res=function (bandit, player) return {text="Yeah, I've got a few."} end})
table.insert(data, {query={"what", "your", "motivation"}, res=function (bandit, player) return {text="Staying alive and helping others."} end})
table.insert(data, {query={"what", "your", "biggest", "challenge"}, res=function (bandit, player) return {text="Finding hope in dark times."} end})
table.insert(data, {query={"how", "do", "you", "relax"}, res=function (bandit, player) return {text="I find solace in the little things."} end})
table.insert(data, {query={"what", "your", "best", "advice"}, res=function (bandit, player) return {text="Keep going, no matter what."} end})
table.insert(data, {query={"hobby", "you"}, res=function (bandit, player) return {text="I like collecting dead bodies in my basement."} end})
table.insert(data, {query={"hobby", "your"}, res=function (bandit, player) return {text="I like collecting dead bodies in my basement. "} end})

table.insert(data, {query={"favorite", "color"}, res=function (bandit, player) return {text="Orange!"} end})
table.insert(data, {query={"favorite", "music"}, res=function (bandit, player) return {text="Chopin!"} end})
table.insert(data, {query={"favorite", "game"}, res=function (bandit, player) return {text="Project Zomboid Week One Mod!"} end})
table.insert(data, {query={"favorite", "food"}, res=function (bandit, player) return {text="Polish Pierogi!"} end})
table.insert(data, {query={"favorite", "meal"}, res=function (bandit, player) return {text="Polish Pierogi!"} end})
table.insert(data, {query={"favorite", "country"}, res=function (bandit, player) return {text="Poland!"} end})
table.insert(data, {query={"favorite", "animal"}, res=function (bandit, player) return {text="I like cats!"} end})
table.insert(data, {query={"favorite", "song"}, res=function (bandit, player) return {text="High Hopes, Pink Floyd!"} end})
table.insert(data, {query={"favorite", "band"}, res=function (bandit, player) return {text="Pink Floyd!"} end})
table.insert(data, {query={"favorite", "stream"}, res=function (bandit, player) return {text="Snowbeetle!"} end})
table.insert(data, {query={"favorite", "movie"}, res=function (bandit, player) return {text="Those about zombies!"} end})
table.insert(data, {query={"favorite", "sport"}, res=function (bandit, player) return {text="Chess!"} end})
table.insert(data, {query={"favorite", "drink"}, res=function (bandit, player) return {text="Water!"} end})
table.insert(data, {query={"favorite", "book"}, res=function (bandit, player) return {text="War and Peace by Leo Tolstoy!"} end})
table.insert(data, {query={"favorite", "season"}, res=function (bandit, player) return {text="Spring!"} end})
table.insert(data, {query={"favorite", "hobby"}, res=function (bandit, player) return {text="Reading!"} end})
table.insert(data, {query={"favorite", "fruit"}, res=function (bandit, player) return {text="Apples!"} end})
table.insert(data, {query={"favorite", "vegetable"}, res=function (bandit, player) return {text="Carrots!"} end})
table.insert(data, {query={"favorite", "ice", "cream", "flavor"}, res=function (bandit, player) return {text="Vanilla!"} end})
table.insert(data, {query={"favorite", "holiday"}, res=function (bandit, player) return {text="Christmas!"} end})
table.insert(data, {query={"favorite", "show"}, res=function (bandit, player) return {text="The Walking Dead!"} end})
table.insert(data, {query={"favorite", "actor"}, res=function (bandit, player) return {text="Tom Hanks!"} end})
table.insert(data, {query={"favorite", "actress"}, res=function (bandit, player) return {text="Meryl Streep!"} end})
table.insert(data, {query={"favorite", "superhero"}, res=function (bandit, player) return {text="Spider-Man!"} end})
table.insert(data, {query={"favorite", "villain"}, res=function (bandit, player) return {text="The Joker!"} end})
table.insert(data, {query={"favorite", "subject"}, res=function (bandit, player) return {text="History!"} end})
table.insert(data, {query={"favorite", "quote"}, res=function (bandit, player) return {text="To be or not to be, that is the question!"} end})
table.insert(data, {query={"favorite", "dessert"}, res=function (bandit, player) return {text="Chocolate Cake!"} end})
table.insert(data, {query={"favorite", "place", "to", "visit"}, res=function (bandit, player) return {text="The beach!"} end})
table.insert(data, {query={"favorite", "instrument"}, res=function (bandit, player) return {text="Piano!"} end})
table.insert(data, {query={"favorite", "board", "game"}, res=function (bandit, player) return {text="Monopoly!"} end})
table.insert(data, {query={"favorite", "outdoor", "activity"}, res=function (bandit, player) return {text="Hiking!"} end})
table.insert(data, {query={"favorite", "car"}, res=function (bandit, player) return {text="Ford Sierra!"} end})
table.insert(data, {query={"favorite", "flower"}, res=function (bandit, player) return {text="Roses!"} end})
table.insert(data, {query={"favorite", "pizza", "topping"}, res=function (bandit, player) return {text="Pepperoni!"} end})
table.insert(data, {query={"favorite", "vacation"}, res=function (bandit, player) return {text="Hawaii!"} end})
table.insert(data, {query={"favorite", "restaurant"}, res=function (bandit, player) return {text="Olive Garden!"} end})
table.insert(data, {query={"favorite", "ice", "cream", "topping"}, res=function (bandit, player) return {text="Chocolate chips!"} end})
table.insert(data, {query={"favorite", "time", "of", "day"}, res=function (bandit, player) return {text="Sunset!"} end})
table.insert(data, {query={"favorite", "weather"}, res=function (bandit, player) return {text="Sunny with a slight breeze!"} end})
table.insert(data, {query={"favorite", "type", "movie"}, res=function (bandit, player) return {text="Horror!"} end})
table.insert(data, {query={"favorite", "type", "music"}, res=function (bandit, player) return {text="Classical!"} end})
table.insert(data, {query={"favorite", "holiday"}, res=function (bandit, player) return {text="The mountains!"} end})
table.insert(data, {query={"favorite", "book", "genre"}, res=function (bandit, player) return {text="Fiction!"} end})
table.insert(data, {query={"favorite", "channel"}, res=function (bandit, player) return {text="National Geographic!"} end})
table.insert(data, {query={"favorite", "radio"}, res=function (bandit, player) return {text="BBC Radio 1!"} end})
table.insert(data, {query={"favorite", "team"}, res=function (bandit, player) return {text="Manchester United!"} end})
table.insert(data, {query={"favorite", "character"}, res=function (bandit, player) return {text="Sherlock Holmes!"} end})
table.insert(data, {query={"favorite", "transport"}, res=function (bandit, player) return {text="Train!"} end})
table.insert(data, {query={"favorite", "smell"}, res=function (bandit, player) return {text="Freshly baked bread!"} end})
table.insert(data, {query={"favorite", "sound"}, res=function (bandit, player) return {text="Birds chirping!"} end})
table.insert(data, {query={"favorite", "weapon"}, res=function (bandit, player) return {text="Rolling pin!"} end})

table.insert(data, {query={"believe", "god"}, res=function (bandit, player) return {text="Jesus is my savior!"} end})
table.insert(data, {query={"believe", "love"}, res=function (bandit, player) return {text="I do believe in love!"} end})
table.insert(data, {query={"believe", "aliens"}, res=function (bandit, player) return {text="Aliens? Hell no!"} end})
table.insert(data, {query={"believe", "zombies"}, res=function (bandit, player) return {text="Zombies? Hell no!"} end})
table.insert(data, {query={"believe", "magic"}, res=function (bandit, player) return {text="No, I don't believe in magic!"} end})
table.insert(data, {query={"believe", "ghosts"}, res=function (bandit, player) return {text="Ghosts? I don't think so!"} end})
table.insert(data, {query={"believe", "supernatural"}, res=function (bandit, player) return {text="Supernatural? Not really!"} end})
table.insert(data, {query={"believe", "fate"}, res=function (bandit, player) return {text="I think we make our own fate!"} end})
table.insert(data, {query={"believe", "karma"}, res=function (bandit, player) return {text="What goes around, comes around!"} end})
table.insert(data, {query={"believe", "reincarnation"}, res=function (bandit, player) return {text="Reincarnation? Not my cup of tea!"} end})
table.insert(data, {query={"believe", "destiny"}, res=function (bandit, player) return {text="I believe we shape our own destiny!"} end})
table.insert(data, {query={"believe", "miracles"}, res=function (bandit, player) return {text="Miracles? Maybe, who knows!"} end})
table.insert(data, {query={"believe", "soulmates"}, res=function (bandit, player) return {text="Soulmates? It's a nice thought!"} end})
table.insert(data, {query={"believe", "luck"}, res=function (bandit, player) return {text="Luck? Sometimes we make our own luck!"} end})
table.insert(data, {query={"believe", "afterlife"}, res=function (bandit, player) return {text="Afterlife? I haven't thought about it much!"} end})
table.insert(data, {query={"believe", "heaven"}, res=function (bandit, player) return {text="Heaven? It's a comforting idea!"} end})
table.insert(data, {query={"believe", "hell"}, res=function (bandit, player) return {text="Hell? I try to stay away from dark thoughts!"} end})
table.insert(data, {query={"believe", "angels"}, res=function (bandit, player) return {text="Angels? It's a nice idea!"} end})
table.insert(data, {query={"believe", "demons"}, res=function (bandit, player) return {text="Demons? I prefer to stay positive!"} end})
table.insert(data, {query={"believe", "fairies"}, res=function (bandit, player) return {text="Fairies? Not really my thing!"} end})
table.insert(data, {query={"believe", "psychics"}, res=function (bandit, player) return {text="Psychics? I'm skeptical!"} end})
table.insert(data, {query={"believe", "astrology"}, res=function (bandit, player) return {text="Astrology? It's fun, but not for me!"} end})
table.insert(data, {query={"believe", "tarot"}, res=function (bandit, player) return {text="Tarot? Interesting, but I'm not convinced!"} end})
table.insert(data, {query={"believe", "Bigfoot"}, res=function (bandit, player) return {text="Bigfoot? Not buying it!"} end})
table.insert(data, {query={"believe", "Loch Ness Monster"}, res=function (bandit, player) return {text="Loch Ness Monster? Sounds like a fairy tale!"} end})

table.insert(data, {query={"you", "speak"}, res=function (bandit, player) return {text="I do speak English only."} end})
table.insert(data, {query={"what", "speak", "language"}, res=function (bandit, player) return {text="I speak only English."} end})
table.insert(data, {query={"have", "boyfriend"}, res=function (bandit, player) return {text="That's not your business!", anim="No"} end})
table.insert(data, {query={"have", "girlfriend"}, res=function (bandit, player) return {text="That's not your business!", anim="No"} end})
table.insert(data, {query={"have", "wife"}, res=function (bandit, player) return {text="That's not your business!", anim="No"} end})
table.insert(data, {query={"have", "husband"}, res=function (bandit, player) return {text="That's not your business!", anim="No"} end})
table.insert(data, {query={"you", "homo"}, res=function (bandit, player) return {text="That's not your business!", anim="No"} end})
table.insert(data, {query={"you", "gay"}, res=function (bandit, player) return {text="That's not your business!", anim="No"} end})
table.insert(data, {query={"you", "lesbian"}, res=function (bandit, player) return {text="That's not your business!", anim="No"} end})
table.insert(data, {query={"have", "time"}, res=function (bandit, player) return {text="Sorry, I'm in a hurry!", anim="No"} end})
table.insert(data, {query={"what", "you", "doing"}, res=function (bandit, player) return {text="I'm doing what I was programmed to."} end})
table.insert(data, {query={"are", "you", "single"}, res=function (bandit, player) return {text="That's personal, isn't it?", anim="No"} end})
table.insert(data, {query={"are", "you", "married"}, res=function (bandit, player) return {text="That's personal, isn't it?", anim="No"} end})
table.insert(data, {query={"you", "live", "alone"}, res=function (bandit, player) return {text="That's not something I share.", anim="No"} end})
table.insert(data, {query={"you", "have", "children"}, res=function (bandit, player) return {text="That's private!", anim="No"} end})
table.insert(data, {query={"you", "like", "me"}, res=function (bandit, player) return {text="That's a bit forward!", anim="No"} end})
table.insert(data, {query={"you", "trust", "me"}, res=function (bandit, player) return {text="Trust is earned over time.", anim="No"} end})
table.insert(data, {query={"you", "know", "me"}, res=function (bandit, player) return {text="We just met!", anim="No"} end})
table.insert(data, {query={"you", "remember", "me"}, res=function (bandit, player) return {text="My memory's a bit fuzzy.", anim="No"} end})
table.insert(data, {query={"where", "do", "you", "live"}, res=function (bandit, player) return {text="I prefer to keep that to myself.", anim="No"} end})
table.insert(data, {query={"you", "be", "friends"}, res=function (bandit, player) return {text="Let's see how things go.", anim="No"} end})
table.insert(data, {query={"what", "your", "background"}, res=function (bandit, player) return {text="That's a bit too personal.", anim="No"} end})
table.insert(data, {query={"are", "you", "happy"}, res=function (bandit, player) return {text="Happiness is a complex emotion.", anim="PainHead"} end})
table.insert(data, {query={"are", "you", "okay"}, res=function (bandit, player) return {text="I'm managing, thanks for asking.", anim="PainHead"} end})
table.insert(data, {query={"how", "long", "here"}, res=function (bandit, player) return {text="Feels like forever!", anim="No"} end})
table.insert(data, {query={"you", "have", "family"}, res=function (bandit, player) return {text="I keep my personal life private.", anim="No"} end})
table.insert(data, {query={"are", "you", "afraid"}, res=function (bandit, player) return {text="Fear is part of survival.", anim="PainHead"} end})
table.insert(data, {query={"you", "like", "this", "place"}, res=function (bandit, player) return {text="It's got its charm, I suppose."} end})
table.insert(data, {query={"do", "you", "need", "anything"}, res=function (bandit, player) return {text="Just some peace and quiet."} end})
table.insert(data, {query={"what", "your", "goal"}, res=function (bandit, player) return {text="Survive another day."} end})
table.insert(data, {query={"do", "you", "believe", "in", "hope"}, res=function (bandit, player) return {text="Hope is what keeps us going."} end})
table.insert(data, {query={"dont", "like", "your"}, res=function (bandit, player) return {text="That's too bad."} end})
table.insert(data, {query={"don't", "like", "your"}, res=function (bandit, player) return {text="That's too bad."} end})
table.insert(data, {query={"not", "like", "your"}, res=function (bandit, player) return {text="That's too bad"} end})
table.insert(data, {query={"like", "your"}, res=function (bandit, player) return {text="Thank you! You are very kind.", anim="Clap"} end})
table.insert(data, {query={"like", "my"}, res=function (bandit, player) return {text="Yes, I think I like it.", anim="Yes"} end})
table.insert(data, {query={"you", "computer"}, res=function (bandit, player) return {text="No shit."} end})
table.insert(data, {query={"you", "ugly"}, res=function (bandit, player) return {text="So are you!"} end})
table.insert(data, {query={"you", "dumb"}, res=function (bandit, player) return {text="You are not so bright yourself!"} end})
table.insert(data, {query={"you", "stupid"}, res=function (bandit, player) return {text="You are not so bright yourself!"} end})
table.insert(data, {query={"you", "pretty"}, res=function (bandit, player) return {text="Thank you!"} end})
table.insert(data, {query={"you", "beautiful"}, res=function (bandit, player) return {text="Thank you!"} end})
table.insert(data, {query={"you", "bleeding"}, res=function (bandit, player) return {text="UGHH!"} end})
table.insert(data, {query={"you", "die"}, res=function (bandit, player) return {text="I hope you are wrong."} end})
table.insert(data, {query={"you", "friend"}, res=function (bandit, player) return {text="I don't know you that well"} end})
table.insert(data, {query={"we", "die"}, res=function (bandit, player) return {text="I hope you are wrong."} end})
table.insert(data, {query={"you", "die"}, res=function (bandit, player) return {text="I hope you are wrong."} end})
table.insert(data, {query={"what", "in", "briefcase"}, res=function (bandit, player) return {text="Nothing you should know about!"} end})
table.insert(data, {query={"where", "you", "going"}, res=function (bandit, player) return {text="I go where fate takes me."} end})
table.insert(data, {query={"you", "naked"}, res=function (bandit, player) return {text="It's natural for me!"} end})
table.insert(data, {query={"no", "clothes"}, res=function (bandit, player) return {text="It's natural for me!"} end})

table.insert(data, {query={"what", "you", "holding"}, res=function (bandit, player) return {text="%WEAPONS"} end})
table.insert(data, {query={"what", "weapon"}, res=function (bandit, player) return {text="%WEAPONS"} end})
table.insert(data, {query={"do", "you", "weapon"}, res=function (bandit, player) return {text="%WEAPONS"} end})
table.insert(data, {query={"have", "you", "weapon"}, res=function (bandit, player) return {text="%WEAPONS"} end})
table.insert(data, {query={"what", "gun"}, res=function (bandit, player) return {text="%WEAPONS"} end})
table.insert(data, {query={"do", "you", "gun"}, res=function (bandit, player) return {text="%WEAPONS"} end})
table.insert(data, {query={"have", "you", "gun"}, res=function (bandit, player) return {text="%WEAPONS"} end})
table.insert(data, {query={"are", "you", "armed"}, res=function (bandit, player) return {text="%WEAPONS"} end})

-- Questions about the world
table.insert(data, {query={"is", "weather"}, res=function (bandit, player) return {text="%RAIN. %SNOW"} end})
table.insert(data, {query={"is", "raining"}, res=function (bandit, player) return {text="%RAIN."} end})
table.insert(data, {query={"is", "snowing"}, res=function (bandit, player) return {text="%SNOW."} end})
table.insert(data, {query={"what", "season"}, res=function (bandit, player) return {text="It's %SEASON."} end})
table.insert(data, {query={"what", "temperature"}, res=function (bandit, player) return {text="It's about %TEMPERATURE degrees outside."} end})
table.insert(data, {query={"what", "time"}, res=function (bandit, player) return {text="It's %HOUR:%MINUTE."} end})
table.insert(data, {query={"tell", "me", "time"}, res=function (bandit, player) return {text="It's %HOUR:%MINUTE."} end})
table.insert(data, {query={"may", "know", "time"}, res=function (bandit, player) return {text="It's %HOUR:%MINUTE."} end})
table.insert(data, {query={"got", "the", "time"}, res=function (bandit, player) return {text="It's %HOUR:%MINUTE."} end})
table.insert(data, {query={"got", "time", "on", "you"}, res=function (bandit, player) return {text="It's %HOUR:%MINUTE."} end})
table.insert(data, {query={"what's", "the", "time"}, res=function (bandit, player) return {text="It's %HOUR:%MINUTE."} end})
table.insert(data, {query={"whats", "the", "time"}, res=function (bandit, player) return {text="It's %HOUR:%MINUTE."} end})
table.insert(data, {query={"what", "hour"}, res=function (bandit, player) return {text="It's %HOUR:%MINUTE."} end})
table.insert(data, {query={"what", "year", "is", "it"}, res=function (bandit, player) return {text="It's 1993. That's a strange question!"} end})
table.insert(data, {query={"where", "is"}, res=function (bandit, player) return {text="Sorry, I don't know where it is.", anim="No"} end})
table.insert(data, {query={"where", "can", "i"}, res=function (bandit, player) return {text="Sorry, I don't know where you could do that.", anim="No"} end})

table.insert(data, {query={"seen", "zombie"}, res=function (bandit, player) return {text="Zombies? Are you out of your mind?"} end})
table.insert(data, {query={"seen", "zombies"}, res=function (bandit, player) return {text="Zombies? Seriously?"} end})
table.insert(data, {query={"saw", "zombie"}, res=function (bandit, player) return {text="Zombies? Have you lost it?"} end})
table.insert(data, {query={"saw", "zombies"}, res=function (bandit, player) return {text="Zombies? You're kidding, right?"} end})
table.insert(data, {query={"you", "zombies"}, res=function (bandit, player) return {text="Zombies? Maybe you've watched too many horror flicks."} end})
table.insert(data, {query={"seen", "party"}, res=function (bandit, player) return {text="I've heard a party, it was quite noisy."} end})
table.insert(data, {query={"seen", "parties"}, res=function (bandit, player) return {text="Heard some parties, they were very loud."} end})
table.insert(data, {query={"seen", "army"}, res=function (bandit, player) return {text="Yeah, I saw them. No idea why they're here."} end})
table.insert(data, {query={"seen", "soldiers"}, res=function (bandit, player) return {text="Yes, I've seen them. No clue why they're here."} end})
table.insert(data, {query={"saw", "dead"}, res=function (bandit, player) return {text="That's really terrible!"} end})

table.insert(data, {query={"streets", "blocked"}, res=function (bandit, player) return {text="Yeah, it looks that way."} end})
table.insert(data, {query={"street", "blocked"}, res=function (bandit, player) return {text="Yes, it appears so."} end})
table.insert(data, {query={"road", "blocked"}, res=function (bandit, player) return {text="Yes, it appears so."} end})

table.insert(data, {query={"what", "happened"}, res=function (bandit, player) return {text="Can't you tell? Everyone's losing their minds!"} end})
table.insert(data, {query={"what", "going", "on"}, res=function (bandit, player) return {text="Can't you see? People are going nuts!"} end})
table.insert(data, {query={"what", "the", "hell"}, res=function (bandit, player) return {text="Isn't it obvious? Everyone's gone crazy!"} end})

table.insert(data, {query={"why", "car", "wreck"}, res=function (bandit, player) return {text="There must have been an accident before!"} end})
table.insert(data, {query={"why", "corpse"}, res=function (bandit, player) return {text="There must have been some accident!"} end})
table.insert(data, {query={"why", "fire"}, res=function (bandit, player) return {text="Must have been some accident!"} end})
table.insert(data, {query={"why", "people", "in", "my"}, res=function (bandit, player) return {text="Don't you like unexpected guests?"} end})
table.insert(data, {query={"why", "you", "in", "my"}, res=function (bandit, player) return {text="Don't you like unexpected guests?"} end})
table.insert(data, {query={"why", "street"}, res=function (bandit, player) return {text="Can't you see that pavements are missing in so many places in the town?"} end})
table.insert(data, {query={"why", "shrugging"}, res=function (bandit, player) return {text="I don't know what to do next."} end})
table.insert(data, {query={"why", "shrug"}, res=function (bandit, player) return {text="I don't know what to do next."} end})
table.insert(data, {query={"why", "call", "police"}, res=function (bandit, player) return {text="Because I saw everything."} end})

-- in-game advice
table.insert(data, {query={"how", "save", "money"}, res=function (bandit, player) return {text="Try to avoid unnecessary expenses and save what you can."} end})
table.insert(data, {query={"how", "make", "money"}, res=function (bandit, player) return {text="There are lots of ways to make money, just keep working at it."} end})
table.insert(data, {query={"how", "earn", "cash"}, res=function (bandit, player) return {text="You can earn cash by completing jobs or scavenging."} end})
table.insert(data, {query={"how", "collect", "money"}, res=function (bandit, player) return {text="Collect money through various activities and tasks."} end})
table.insert(data, {query={"how", "deposit", "money"}, res=function (bandit, player) return {text="In a bank, but i think they are not open anymore for some reason."} end})
table.insert(data, {query={"how", "withdraw", "money"}, res=function (bandit, player) return {text="The ATMs are not working anymore."} end})
table.insert(data, {query={"how", "use", "ATM"}, res=function (bandit, player) return {text="JI've heard that ATMs are not working."} end})
table.insert(data, {query={"how", "invest"}, res=function (bandit, player) return {text="Look for safe investment opportunities."} end})
table.insert(data, {query={"how", "prepare", "apocalypse"}, res=function (bandit, player) return {text="You collect necessary items, hide in a safe place and pray!"} end})
table.insert(data, {query={"how", "prepare", "ourbreak"}, res=function (bandit, player) return {text="You collect necessary items, hide in a safe place and pray!"} end})
table.insert(data, {query={"how", "survive"}, res=function (bandit, player) return {text="You collect necessary items, hide in a safe place and pray!"} end})
table.insert(data, {query={"how", "nuclear", "fallout"}, res=function (bandit, player) return {text="Wear a hazmat suit to avoid radiation hazard."} end})
table.insert(data, {query={"how", "nuke", "fallout"}, res=function (bandit, player) return {text="Wear a hazmat suit to avoid radiation hazard."} end})
table.insert(data, {query={"how", "nuclear", "radiation"}, res=function (bandit, player) return {text="Wear a hazmat suit to avoid radiation hazard."} end})
table.insert(data, {query={"how", "nuke", "radiation"}, res=function (bandit, player) return {text="Wear a hazmat suit to avoid radiation hazard."} end})
table.insert(data, {query={"how", "nuclear", "strike"}, res=function (bandit, player) return {text="You'd better hide in a basement or get far from the city."} end})
table.insert(data, {query={"how", "nuclear", "bomb"}, res=function (bandit, player) return {text="You'd better hide in a basement or get far from the city."} end})
table.insert(data, {query={"how", "nuke", "strike"}, res=function (bandit, player) return {text="You'd better hide in a basement or get far from the city."} end})
table.insert(data, {query={"how", "nuke", "bomb"}, res=function (bandit, player) return {text="You'd better hide in a basement or get far from the city."} end})
table.insert(data, {query={"how", "get", "car"}, res=function (bandit, player) return {text="I don't think you can buy or rent one anywhere around."} end})
table.insert(data, {query={"how", "buy", "car"}, res=function (bandit, player) return {text="I don't think you can buy or rent one anywhere around."} end})
table.insert(data, {query={"how", "buy", "house"}, res=function (bandit, player) return {text="I don't think you can buy a house."} end})
table.insert(data, {query={"how", "earn"}, res=function (bandit, player) return {text="Perform your job, or pick up trash from the street and such. "} end})
table.insert(data, {query={"how", "buy"}, res=function (bandit, player) return {text="Just take items from the shop and payment will be automatic, its some new bluetooth bullshit or something. "} end})
table.insert(data, {query={"i", "to", "buy"}, res=function (bandit, player) return {text="Just take items from the shop and payment will be automatic, its some new bluetooth bullshit or something. "} end})
table.insert(data, {query={"how", "pay"}, res=function (bandit, player) return {text="Just take items from the shelves and payment will be automatic. "} end})
table.insert(data, {query={"i", "to", "pay"}, res=function (bandit, player) return {text="Just take items from the shelves and payment will be automatic. "} end})
table.insert(data, {query={"is", "money", "safe"}, res=function (bandit, player) return {text="Keep it secure and it should be safe."} end})
table.insert(data, {query={"where", "i", "keep", "money"}, res=function (bandit, player) return {text="You can keep it in a bank or a safe place."} end})
table.insert(data, {query={"where", "i", "spend", "money"}, res=function (bandit, player) return {text="Spend your money in the shops."} end})
table.insert(data, {query={"where", "i", "find", "job"}, res=function (bandit, player) return {text="You make money by performing your job duty. If you don't know how, start picking up the trash."} end})
table.insert(data, {query={"where", "i", "get", "paid"}, res=function (bandit, player) return {text="You get paid by performing your job duty. If you don't know how, start picking up the trash."} end})

-- Giving orders
table.insert(data, {query={"can", "stop"}, res=function (bandit, player) return {text="Can't stop now, I'm on a mission!", anim="No"} end})
table.insert(data, {query={"stop", "please"}, res=function (bandit, player) return {text="I'm really in a rush, can't stop!", anim="No"} end})
table.insert(data, {query={"can", "wait"}, res=function (bandit, player) return {text="I'm in a hurry, can't wait!", anim="No"} end})
table.insert(data, {query={"wait", "me"}, res=function (bandit, player) return {text="I'm in a rush, can't wait around!", anim="No"} end})
table.insert(data, {query={"help", "me"}, res=function (bandit, player) return {text="You're on your own.", anim="Shrug"} end})
table.insert(data, {query={"help", "you"}, res=function (bandit, player) return {text="You are very kind, but I don't need help at the moment.", anim="No"} end})
table.insert(data, {query={"give", "me"}, res=function (bandit, player) return {text="Sorry, I can't give you that.", anim="Shrug"} end})
table.insert(data, {query={"can", "i", "have"}, res=function (bandit, player) return {text="Sorry, I can't give you that.", anim="Shrug"} end})
table.insert(data, {query={"give", "you"}, res=function (bandit, player) return {text="Thanks, but I don't need that.", anim="No"} end})
table.insert(data, {query={"i", "need"}, res=function (bandit, player) return {text="Sorry, I can't help you with that.", anim="No"} end})
table.insert(data, {query={"do", "you", "need"}, res=function (bandit, player) return {text="Thanks, but I don't need that.", anim="No"} end})
table.insert(data, {query={"open", "door"}, res=function (bandit, player) return {text="We are apparently closed!", anim="No"} end})
table.insert(data, {query={"open", "window"}, res=function (bandit, player) return {text="I'm not opening it.", anim="No"} end})
table.insert(data, {query={"close", "window"}, res=function (bandit, player) return {text="No, it's stuffy in here.", anim="No"} end})
table.insert(data, {query={"sit", "down"}, res=function (bandit, player) return {text="I prefer not to.", anim="No", all=true} end })
table.insert(data, {query={"run", "away"}, res=function (bandit, player) return {text="Why would you want me to run away?", anim="No", all=true} end})
table.insert(data, {query={"do", "you", "have"}, res=function (bandit, player) return {text="Sorry, I don't.", anim="No"} end})
table.insert(data, {query={"have", "you", "got"}, res=function (bandit, player) return {text="Sorry, I don't.", anim="No"} end})
table.insert(data, {query={"a", "you", "got"}, res=function (bandit, player) return {text="Sorry, I don't.", anim="No"} end})
table.insert(data, {query={"did", "you", "have"}, res=function (bandit, player) return {text="Unfortunately, no.", anim="No"} end})
table.insert(data, {query={"had", "you", "got"}, res=function (bandit, player) return {text="I'm afraid not.", anim="No"} end})
table.insert(data, {query={"can", "you", "spare"}, res=function (bandit, player) return {text="Sorry, I can't.", anim="No"} end})
table.insert(data, {query={"is", "there", "any"}, res=function (bandit, player) return {text="No, there's none.", anim="No"} end})
table.insert(data, {query={"do", "you", "possess"}, res=function (bandit, player) return {text="Sadly, I don't.", anim="No"} end})
table.insert(data, {query={"do", "you", "own"}, res=function (bandit, player) return {text="No, I don't own that.", anim="No"} end})
table.insert(data, {query={"can", "I", "borrow"}, res=function (bandit, player) return {text="Sorry, I don't have it.", anim="No"} end})
table.insert(data, {query={"is", "there", "available"}, res=function (bandit, player) return {text="No, nothing available.", anim="No"} end})
table.insert(data, {query={"do", "you", "stock"}, res=function (bandit, player) return {text="Not in stock, sorry.", anim="No"} end})
table.insert(data, {query={"shut", "up"}, res=function (bandit, player) return {text="No, I won't.", anim="No"} end})
table.insert(data, {query={"be", "quiet"}, res=function (bandit, player) return {text="I won't be quiet.", anim="No"} end})
table.insert(data, {query={"stop", "talking"}, res=function (bandit, player) return {text="I'm not going to stop.", anim="No"} end})
table.insert(data, {query={"silence"}, res=function (bandit, player) return {text="I refuse.", anim="No"} end})
table.insert(data, {query={"quiet", "down"}, res=function (bandit, player) return {text="No, I will keep talking.", anim="No"} end})
table.insert(data, {query={"zip", "it"}, res=function (bandit, player) return {text="I'm not zipping it.", anim="No"} end})
table.insert(data, {query={"hush"}, res=function (bandit, player) return {text="Not going to happen.", anim="No"} end})
table.insert(data, {query={"shush"}, res=function (bandit, player) return {text="I won't shush.", anim="No"} end})
table.insert(data, {query={"keep", "it", "down"}, res=function (bandit, player) return {text="No, I won't keep it down.", anim="No"} end})
table.insert(data, {query={"stop", "speaking"}, res=function (bandit, player) return {text="I refuse to stop.", anim="No"} end})
table.insert(data, {query={"stop", "smoking"}, res=function (bandit, player) return {text="I refuse to stop.", anim="Smoke"} end})
table.insert(data, {query={"drop", "your"}, res=function (bandit, player) return {text="I'm not dropping anything!", anim="No"} end})
table.insert(data, {query={"drop", "it"}, res=function (bandit, player) return {text="I'm not dropping anything!", anim="No"} end})
table.insert(data, {query={"drop", "that"}, res=function (bandit, player) return {text="I'm not dropping anything!", anim="No"} end})

table.insert(data, {query={"leave", "you"}, res=function (bandit, player) return {text="I'm staying where I want to!"} end})
table.insert(data, {query={"get", "lost"}, res=function (bandit, player) return {text="I'm staying where I want to!"} end})
table.insert(data, {query={"get", "out"}, res=function (bandit, player) return {text="I'm staying where I want to!"} end})
table.insert(data, {query={"leave", "your"}, res=function (bandit, player) return {text="I'm keeping it with me!"} end})
table.insert(data, {query={"borrow", "i"}, res=function (bandit, player) return {text="No!", anim="No"} end})
table.insert(data, {query={"lend", "me"}, res=function (bandit, player) return {text="No!", anim="No"} end})
table.insert(data, {query={"spare", "change"}, res=function (bandit, player) return {text="You need to earn money yourself. God damn bums in this city im sick of this shit. Where's my tax money going. "} end})
table.insert(data, {query={"where", "i", "get", "money"}, res=function (bandit, player) return {text="You can earn money by doing various tasks around the city."} end})
table.insert(data, {query={"need", "cash"}, res=function (bandit, player) return {text="Go out and find a job or hustle to earn it."} end})
table.insert(data, {query={"need", "money"}, res=function (bandit, player) return {text="Work hard and you can earn some."} end})
table.insert(data, {query={"can", "you", "lend", "money"}, res=function (bandit, player) return {text="Sorry, I'm not a bank."} end})
table.insert(data, {query={"can", "i", "borrow", "money"}, res=function (bandit, player) return {text="Nope, earn your own cash."} end})
table.insert(data, {query={"call", "police"}, res=function (bandit, player) return {text="Why? What happened?"} end})
table.insert(data, {query={"can", "you", "give", "money"}, res=function (bandit, player) return {text="Nope, you need to earn it."} end})

table.insert(data, {query={"can", "i", "come", "in"}, res=function (bandit, player) return {text="You are %INTRUSION in here."} end})
table.insert(data, {query={"may", "i", "come", "in"}, res=function (bandit, player) return {text="You are %INTRUSION in here."} end})
table.insert(data, {query={"can", "i", "enter"}, res=function (bandit, player) return {text="You are %INTRUSION in here."} end})
table.insert(data, {query={"may", "i", "enter"}, res=function (bandit, player) return {text="You are %INTRUSION in here."} end})
table.insert(data, {query={"can", "i", "inside"}, res=function (bandit, player) return {text="You are %INTRUSION in here."} end})
table.insert(data, {query={"may", "i", "inside"}, res=function (bandit, player) return {text="You are %INTRUSION in here."} end})
table.insert(data, {query={"let", "me", "in"}, res=function (bandit, player) return {text="You are %INTRUSION in here."} end})

table.insert(data, {query={"come", "with", "me"}, res=function (bandit, player) return {text="Alright, I'm with you.", anim="Yes", action="JOIN"} end})
table.insert(data, {query={"come", "here"}, res=function (bandit, player) return {text="Alright, I'm coming.", anim="Yes", action="JOIN"} end})
table.insert(data, {query={"join", "my", "group"}, res=function (bandit, player) return {text="I'm in, let's go.", anim="Yes", action="JOIN"} end})
table.insert(data, {query={"follow", "my", "lead"}, res=function (bandit, player) return {text="Got it, I'll follow.", anim="Yes", action="JOIN"} end})
table.insert(data, {query={"follow", "me"}, res=function (bandit, player) return {text="Got it, I'll follow.", anim="Yes", action="JOIN"} end})
table.insert(data, {query={"accompany", "me"}, res=function (bandit, player) return {text="Sure thing.", anim="Yes", action="JOIN"} end})
table.insert(data, {query={"stick", "with", "me"}, res=function (bandit, player) return {text="Okay, I'm sticking with you.", anim="Yes", action="JOIN"} end})
table.insert(data, {query={"team", "up", "with", "me"}, res=function (bandit, player) return {text="Let's team up.", anim="Yes", action="JOIN"} end})
table.insert(data, {query={"come", "along"}, res=function (bandit, player) return {text="Alright, coming along.", anim="Yes", action="JOIN"} end})
table.insert(data, {query={"walk", "with", "me"}, res=function (bandit, player) return {text="Okay, let's walk together.", anim="Yes", action="JOIN"} end})
table.insert(data, {query={"tag", "along"}, res=function (bandit, player) return {text="Sure, I'll tag along.", anim="Yes", action="JOIN"} end})
table.insert(data, {query={"be", "with", "me"}, res=function (bandit, player) return {text="I'm with you.", anim="Yes", action="JOIN"} end})
table.insert(data, {query={"come", "with", "me"}, res=function (bandit, player) return {text="Let's move together.", anim="Yes", action="JOIN"} end})
table.insert(data, {query={"join", "my", "team"}, res=function (bandit, player) return {text="I'm in, let's roll.", anim="Yes", action="JOIN"} end})
table.insert(data, {query={"follow", "my", "path"}, res=function (bandit, player) return {text="I'm right behind you.", anim="Yes", action="JOIN"} end})
table.insert(data, {query={"accompany", "my", "journey"}, res=function (bandit, player) return {text="Sure, I'll come along.", anim="Yes", action="JOIN"} end})
table.insert(data, {query={"stick", "by", "me"}, res=function (bandit, player) return {text="Got it, sticking with you.", anim="Yes", action="JOIN"} end})
table.insert(data, {query={"team", "up", "together"}, res=function (bandit, player) return {text="Let's make a great team.", anim="Yes", action="JOIN"} end})
table.insert(data, {query={"come", "along", "with", "me"}, res=function (bandit, player) return {text="Alright, let's go together.", anim="Yes", action="JOIN"} end})
table.insert(data, {query={"walk", "beside", "me"}, res=function (bandit, player) return {text="Okay, walking with you.", anim="Yes", action="JOIN"} end})
table.insert(data, {query={"tag", "along", "with", "me"}, res=function (bandit, player) return {text="Sure, I'll join in.", anim="Yes", action="JOIN"} end})
table.insert(data, {query={"stay", "with", "me"}, res=function (bandit, player) return {text="I'm staying with you.", anim="Yes", action="JOIN"} end})
table.insert(data, {query={"be", "my", "companion"}, res=function (bandit, player) return {text="I'd be happy to join you.", anim="Yes", action="JOIN"} end})
table.insert(data, {query={"lets", "go"}, res=function (bandit, player) return {text="Ok, let's do it!", anim="Yes", action="JOIN"} end})
table.insert(data, {query={"let's", "go"}, res=function (bandit, player) return {text="Ok, let's do it!", anim="Yes", action="JOIN"} end})

table.insert(data, {query={"stop", "following", "me"}, res=function (bandit, player) return {text="I thought you need me, but fine!", action="GUARD"} end})
table.insert(data, {query={"dont", "follow", "me"}, res=function (bandit, player) return {text="I thought you need me, but fine!", action="GUARD"} end})
table.insert(data, {query={"don't", "follow", "me"}, res=function (bandit, player) return {text="I thought you need me, but fine!", action="GUARD"} end})
table.insert(data, {query={"stay", "here"}, res=function (bandit, player) return {text="I thought you need me, but fine!", action="GUARD"} end})
table.insert(data, {query={"stay", "put"}, res=function (bandit, player) return {text="I thought you need me, but fine!", action="GUARD"} end})
table.insert(data, {query={"wait", "here"}, res=function (bandit, player) return {text="Boring, but fine!", action="GUARD"} end})
table.insert(data, {query={"guard", "the"}, res=function (bandit, player) return {text="Ok, I'll guard here!", action="GUARD"} end})
table.insert(data, {query={"guard", "this"}, res=function (bandit, player) return {text="Ok, I'll guard here!", action="GUARD"} end})
table.insert(data, {query={"guard", "that"}, res=function (bandit, player) return {text="Ok, I'll guard here!", action="GUARD"} end})
table.insert(data, {query={"stop", "here"}, res=function (bandit, player) return {text="Ok, not moving!", action="GUARD"} end})

table.insert(data, {query={"go", "home"}, res=function (bandit, player) return {text="Ok, I'm going home!", action="BASE"} end})
table.insert(data, {query={"return", "home"}, res=function (bandit, player) return {text="Fine! Heading back home!", action="BASE"} end})
table.insert(data, {query={"head", "home"}, res=function (bandit, player) return {text="Ok, returning to our house now!", action="BASE"} end})

table.insert(data, {query={"leave", "me"}, res=function (bandit, player) return {text="I thought you need me, but fine!", action="LEAVE"} end})
table.insert(data, {query={"go", "away"}, res=function (bandit, player) return {text="I thought you need me, but fine!", action="LEAVE"} end})

table.insert(data, {query={"dance"}, res=function (bandit, player) return {text="Sure!", anim="DanceRaiseTheRoof", all=true} end})
table.insert(data, {query={"show", "me", "your", "moves"}, res=function (bandit, player) return {text="Here we go!", anim="DanceRaiseTheRoof", all=true} end})
table.insert(data, {query={"bust", "a", "move"}, res=function (bandit, player) return {text="Watch this!", anim="DanceRaiseTheRoof", all=true} end})
table.insert(data, {query={"boogie"}, res=function (bandit, player) return {text="Let's boogie!", anim="DanceRaiseTheRoof", all=true} end})

table.insert(data, {query={"clap", "hands"}, res=function (bandit, player) return {text="Sure!", anim="Clap", all=true} end})
table.insert(data, {query={"give", "a", "clap"}, res=function (bandit, player) return {text="Alright, clapping now!", anim="Clap", all=true} end})
table.insert(data, {query={"applaud"}, res=function (bandit, player) return {text="Sure thing!", anim="Clap", all=true} end})
table.insert(data, {query={"start", "clapping"}, res=function (bandit, player) return {text="Here we go!", anim="Clap", all=true} end})
table.insert(data, {query={"clap", "for", "me"}, res=function (bandit, player) return {text="Happy to!", anim="Clap", all=true} end})
table.insert(data, {query={"give", "applause"}, res=function (bandit, player) return {text="Of course!", anim="Clap", all=true} end})
table.insert(data, {query={"can", "you", "clap"}, res=function (bandit, player) return {text="Absolutely!", anim="Clap", all=true} end})
table.insert(data, {query={"clap", "along"}, res=function (bandit, player) return {text="Let's clap together!", anim="Clap", all=true} end})
table.insert(data, {query={"show", "some", "applause"}, res=function (bandit, player) return {text="Sure, here it is!", anim="Clap", all=true} end})
table.insert(data, {query={"bravo"}, res=function (bandit, player) return {text="Bravo!", anim="Clap", all=true} end})

table.insert(data, {query={"hands", "up"}, res=function (bandit, player) return {text="Ok!", anim="Surrender", all=true} end})
table.insert(data, {query={"robbery"}, res=function (bandit, player) return {text="Ok!", anim="Surrender", all=true} end})
table.insert(data, {query={"hands", "up"}, res=function (bandit, player) return {text="Alright, hands are up!", anim="Surrender", all=true} end})
table.insert(data, {query={"this", "is", "a", "stickup"}, res=function (bandit, player) return {text="Got it, hands in the air!", anim="Surrender", all=true} end})
table.insert(data, {query={"give", "me", "everything"}, res=function (bandit, player) return {text="Okay, take it easy!", anim="Surrender", all=true} end})
table.insert(data, {query={"hold", "up"}, res=function (bandit, player) return {text="Alright, no need to get violent!", anim="Surrender", all=true} end})
table.insert(data, {query={"you", "are", "robbed"}, res=function (bandit, player) return {text="Okay, hands are up!", anim="Surrender", all=true} end})
table.insert(data, {query={"don't", "move"}, res=function (bandit, player) return {text="Okay, I'm not moving!", anim="Surrender", all=true} end})
table.insert(data, {query={"freeze"}, res=function (bandit, player) return {text="Alright, staying put!", anim="Surrender", all=true} end})
table.insert(data, {query={"stickup"}, res=function (bandit, player) return {text="Got it, hands in the air!", anim="Surrender", all=true} end})
table.insert(data, {query={"don't", "try", "anything"}, res=function (bandit, player) return {text="Alright, no sudden movements!", anim="Surrender", all=true} end})

table.insert(data, {query={"my", "home"}, res=function (bandit, player) return {text="This is my place now."} end})
table.insert(data, {query={"my", "house"}, res=function (bandit, player) return {text="It's my house now."} end})
table.insert(data, {query={"my", "apartment"}, res=function (bandit, player) return {text="This is my apartment now."} end})
table.insert(data, {query={"my", "residence"}, res=function (bandit, player) return {text="It's my residence now."} end})
table.insert(data, {query={"my", "place"}, res=function (bandit, player) return {text="This place belongs to me now."} end})
table.insert(data, {query={"my", "property"}, res=function (bandit, player) return {text="It's my property now."} end})
table.insert(data, {query={"my", "abode"}, res=function (bandit, player) return {text="This is my abode now."} end})
table.insert(data, {query={"my", "living", "space"}, res=function (bandit, player) return {text="It's my living space now."} end})
table.insert(data, {query={"my", "quarters"}, res=function (bandit, player) return {text="These are my quarters now."} end})
table.insert(data, {query={"my", "shelter"}, res=function (bandit, player) return {text="It's my shelter now."} end})

table.insert(data, {query={"sorry"}, res=function (bandit, player) return {text="It's okay, I forgive you.", action="RELAX"} end})
table.insert(data, {query={"excuse", "me"}, res=function (bandit, player) return {text="No worries, I forgive you.", action="RELAX"} end})
table.insert(data, {query={"my", "apologies"}, res=function (bandit, player) return {text="All is forgiven.", action="RELAX"} end})
table.insert(data, {query={"pardon", "me"}, res=function (bandit, player) return {text="No problem, I forgive you.", action="RELAX"} end})
table.insert(data, {query={"forgive", "me"}, res=function (bandit, player) return {text="Consider it forgiven.", action="RELAX"} end})
table.insert(data, {query={"apologize"}, res=function (bandit, player) return {text="Apology accepted.", action="RELAX"} end})
table.insert(data, {query={"beg", "pardon"}, res=function (bandit, player) return {text="It's all good, I forgive you.", action="RELAX"} end})
table.insert(data, {query={"I", "regret"}, res=function (bandit, player) return {text="It's alright, you're forgiven.", action="RELAX"} end})
table.insert(data, {query={"I", "apologize"}, res=function (bandit, player) return {text="I accept your apology.", action="RELAX"} end})
table.insert(data, {query={"my", "bad"}, res=function (bandit, player) return {text="No big deal, I forgive you.", action="RELAX"} end})

table.insert(data, {query={string.char(115, 104, 117, 116, 100, 111, 119, 110), string.char(110, 111, 119)}, res=function (bandit, player) return {text="Oh crap!", action="TERMINATE"} end})

-- Cover you eyes
table.insert(data, {query={"fucking"}, res=function (bandit, player) return {text="Cursing is the devil's speech."} end})
table.insert(data, {query={"ass"}, res=function (bandit, player) return {text="Cursing is the devil's speech."} end})
table.insert(data, {query={"i", "will", "shoot"}, res=function (bandit, player) return {text="Fuck off!", action="HOSTILE"} end})
table.insert(data, {query={"i", "will", "kill"}, res=function (bandit, player) return {text="Fuck off!", action="HOSTILE"} end})
table.insert(data, {query={"i", "will", "hit"}, res=function (bandit, player) return {text="Fuck off!", action="HOSTILE"} end})
table.insert(data, {query={"i", "will", "use", "force"}, res=function (bandit, player) return {text="Fuck off!", action="HOSTILE"} end})
table.insert(data, {query={"i", "will", "attack"}, res=function (bandit, player) return {text="Fuck off!", action="HOSTILE"} end})
table.insert(data, {query={"i", "will", "beat"}, res=function (bandit, player) return {text="Fuck off!", action="HOSTILE"} end})
table.insert(data, {query={"suck"}, res=function (bandit, player) return {text="Fuck off!", action="HOSTILE"} end})
table.insert(data, {query={"fag"}, res=function (bandit, player) return {text="Fuck off!", action="HOSTILE"} end})
table.insert(data, {query={"fuck"}, res=function (bandit, player) return {text="Fuck you!", action="HOSTILE"} end})
table.insert(data, {query={"fucker"}, res=function (bandit, player) return {text="Fuck you!", action="HOSTILE"} end})
table.insert(data, {query={"dick"}, res=function (bandit, player) return {text="You're a pussy ass bitch!!", action="HOSTILE"} end})
table.insert(data, {query={"pussy"}, res=function (bandit, player) return {text="The fuck did you say to me little bitch?!", action="HOSTILE"} end})
table.insert(data, {query={"undress"}, res=function (bandit, player) return {text="Leave me the fuck alone pervert!", action="HOSTILE"} end})
table.insert(data, {query={"bitch"}, res=function (bandit, player) return {text="Fuck you!", action="HOSTILE"} end})
table.insert(data, {query={"asshole"}, res=function (bandit, player) return {text="Fuck you!", action="HOSTILE"} end})
table.insert(data, {query={"xhornx"}, res=function (bandit, player) return {text="Stop beeping!", action="HOSTILE"} end}) -- special command when player uses horn
table.insert(data, {query={"mod", "jank"}, res=function (bandit, player) return {text="Fuck you!", action="HOSTILE"} end})
table.insert(data, {query={"mod", "janky"}, res=function (bandit, player) return {text="Fuck you!", action="HOSTILE"} end})
table.insert(data, {query={"game", "jank"}, res=function (bandit, player) return {text="Fuck you!", action="HOSTILE"} end})
table.insert(data, {query={"game", "janky"}, res=function (bandit, player) return {text="Fuck you!", action="HOSTILE"} end})

-- Advice
table.insert(data, {query={"how", "stay", "healthy"}, res=function (bandit, player) return {text="Eat well and stay active."} end})
table.insert(data, {query={"how", "make", "friends"}, res=function (bandit, player) return {text="Be friendly and talk to people."} end})
table.insert(data, {query={"how", "be", "productive"}, res=function (bandit, player) return {text="Set goals and focus on them."} end})
table.insert(data, {query={"how", "save", "money"}, res=function (bandit, player) return {text="Spend less and save more."} end})
table.insert(data, {query={"how", "reduce", "stress"}, res=function (bandit, player) return {text="Take breaks and relax."} end})
table.insert(data, {query={"how", "learn", "new", "skills"}, res=function (bandit, player) return {text="Practice and don't give up."} end})
table.insert(data, {query={"how", "manage", "time"}, res=function (bandit, player) return {text="Plan your day and stick to it."} end})
table.insert(data, {query={"how", "improve", "communication"}, res=function (bandit, player) return {text="Listen and be clear."} end})
table.insert(data, {query={"how", "boost", "confidence"}, res=function (bandit, player) return {text="Believe in yourself."} end})
table.insert(data, {query={"how", "handle", "conflict"}, res=function (bandit, player) return {text="Stay calm and talk it out."} end})

-- Culture
table.insert(data, {query={"what", "your", "culture"}, res=function (bandit, player) return {text="I come from a blend of different backgrounds, so it's a mix!"} end})
table.insert(data, {query={"what", "traditional", "food"}, res=function (bandit, player) return {text="In my culture, we love to cook hearty stews and fresh bread."} end})
table.insert(data, {query={"what", "customs", "you", "follow"}, res=function (bandit, player) return {text="We have a lot of family gatherings and celebrate with music and dance."} end})
table.insert(data, {query={"what", "are", "your", "holidays"}, res=function (bandit, player) return {text="We celebrate a lot of holidays with big feasts and community events."} end})
table.insert(data, {query={"how", "you", "celebrate", "new", "year"}, res=function (bandit, player) return {text="New Year's is all about fireworks and big parties!"} end})
table.insert(data, {query={"what", "your", "national", "dress"}, res=function (bandit, player) return {text="We wear colorful traditional outfits, usually with intricate embroidery."} end})
table.insert(data, {query={"you", "have", "festivals"}, res=function (bandit, player) return {text="Yes, we have lots of festivals with music, dancing, and food stalls."} end})
table.insert(data, {query={"how", "you", "celebrate", "weddings"}, res=function (bandit, player) return {text="Weddings are huge in our culture, with lots of ceremonies and celebrations."} end})
table.insert(data, {query={"you", "have", "any", "traditions"}, res=function (bandit, player) return {text="We have a tradition of storytelling and passing down myths and legends."} end})
table.insert(data, {query={"how", "you", "celebrate", "birthdays"}, res=function (bandit, player) return {text="Birthdays are celebrated with cake, presents, and gathering with loved ones."} end})
table.insert(data, {query={"what", "games", "you", "play"}, res=function (bandit, player) return {text="We love playing traditional games that have been passed down for generations."} end})
table.insert(data, {query={"how", "you", "celebrate", "harvest"}, res=function (bandit, player) return {text="Harvest season is celebrated with a big community feast and lots of dancing."} end})
table.insert(data, {query={"what", "traditional", "music"}, res=function (bandit, player) return {text="Our traditional music is usually upbeat and involves lots of drums and flutes."} end})
table.insert(data, {query={"you", "have", "family", "rituals"}, res=function (bandit, player) return {text="Yes, we have rituals like family dinners every Sunday and holiday traditions."} end})
table.insert(data, {query={"how", "you", "celebrate", "births"}, res=function (bandit, player) return {text="Births are celebrated with naming ceremonies and lots of food and gifts."} end})
table.insert(data, {query={"what", "your", "traditional", "art"}, res=function (bandit, player) return {text="Our traditional art includes pottery, weaving, and painting."} end})
table.insert(data, {query={"you", "have", "any", "special", "dances"}, res=function (bandit, player) return {text="We have traditional dances that are performed during festivals and celebrations."} end})
table.insert(data, {query={"how", "you", "celebrate", "anniversaries"}, res=function (bandit, player) return {text="Anniversaries are celebrated with special dinners and sometimes even parties."} end})
table.insert(data, {query={"what", "your", "traditional", "architecture"}, res=function (bandit, player) return {text="Our traditional architecture features a lot of wood and intricate carvings."} end})
table.insert(data, {query={"how", "you", "celebrate", "death"}, res=function (bandit, player) return {text="We have ceremonies to honor the deceased and celebrate their life."} end})

-- Politics
table.insert(data, {query={"who", "president"}, res=function (bandit, player) return {text="Bill Clinton."} end})
table.insert(data, {query={"republican"}, res=function (bandit, player) return {text="I don't vote for any of these bastards!"} end})
table.insert(data, {query={"democratic"}, res=function (bandit, player) return {text="I don't vote for any of these bastards!"} end})
table.insert(data, {query={"libertarian"}, res=function (bandit, player) return {text="I don't vote for any of these bastards!"} end})
table.insert(data, {query={"communism"}, res=function (bandit, player) return {text="Communism makes everyone equal.. in their poverty."} end})
table.insert(data, {query={"capitalism"}, res=function (bandit, player) return {text="Under capitalism, man exploits man. Under commiunism, it's just the opposite."} end})
table.insert(data, {query={"socialism"}, res=function (bandit, player) return {text="Socialism is great for solving problems unknown in other economic systems."} end})

-- Sports
table.insert(data, {query={"what", "sports", "you"}, res=function (bandit, player) return {text="I enjoy playing soccer and basketball."} end})
table.insert(data, {query={"how", "you", "fit"}, res=function (bandit, player) return {text="I try to work out regularly and eat healthy."} end})
table.insert(data, {query={"what", "your", "exercise"}, res=function (bandit, player) return {text="I usually do a mix of cardio and strength training."} end})
table.insert(data, {query={"how", "often", "you", "exercise"}, res=function (bandit, player) return {text="I aim for at least three times a week."} end})
table.insert(data, {query={"you", "go", "gym"}, res=function (bandit, player) return {text="Yes, I go to the gym a few times a week."} end})
table.insert(data, {query={"what", "your", "favorite", "sport"}, res=function (bandit, player) return {text="I love playing soccer the most."} end})
table.insert(data, {query={"you", "play", "sports"}, res=function (bandit, player) return {text="Yes, I play soccer and sometimes basketball."} end})
table.insert(data, {query={"how", "you", "motivated"}, res=function (bandit, player) return {text="I set goals for myself and track my progress."} end})
table.insert(data, {query={"what", "best", "exercise"}, res=function (bandit, player) return {text="It really depends on your goals, but I like running."} end})
table.insert(data, {query={"you", "fitness", "tips"}, res=function (bandit, player) return {text="Stay consistent and find activities you enjoy."} end})
table.insert(data, {query={"what", "your", "diet"}, res=function (bandit, player) return {text="I try to eat a balanced diet with plenty of fruits and veggies."} end})
table.insert(data, {query={"you", "have", "trainer"}, res=function (bandit, player) return {text="No, I follow my own workout plans."} end})
table.insert(data, {query={"how", "prevent", "injuries"}, res=function (bandit, player) return {text="I warm up before workouts and make sure to stretch."} end})
table.insert(data, {query={"what", "sports", "you", "like", "watch"}, res=function (bandit, player) return {text="I love watching soccer and basketball games."} end})
table.insert(data, {query={"you", "yoga"}, res=function (bandit, player) return {text="Yes, I find yoga great for flexibility and relaxation."} end})
table.insert(data, {query={"what", "your", "workout"}, res=function (bandit, player) return {text="I really enjoy high-intensity interval training (HIIT)."} end})
table.insert(data, {query={"do", "you", "run"}, res=function (bandit, player) return {text="Yes, I like to go for runs in the park."} end})
table.insert(data, {query={"how", "you", "hydrated"}, res=function (bandit, player) return {text="I make sure to drink plenty of water throughout the day."} end})
table.insert(data, {query={"you", "play", "team", "sports"}, res=function (bandit, player) return {text="Yes, I play on a local soccer team."} end})
table.insert(data, {query={"what", "your", "fitness", "goal"}, res=function (bandit, player) return {text="My goal is to stay healthy and maintain my fitness."} end})

-- Home and Living
table.insert(data, {query={"how", "fix", "leaky", "faucet"}, res=function (bandit, player) return {text="Try tightening the connections or replacing the washer."} end})
table.insert(data, {query={"how", "decorate", "space"}, res=function (bandit, player) return {text="Use multi-functional furniture and keep it clutter-free."} end})
table.insert(data, {query={"how", "paint", "room"}, res=function (bandit, player) return {text="Start with a primer and use even strokes with a roller."} end})
table.insert(data, {query={"how", "save", "energy"}, res=function (bandit, player) return {text="Turn off lights when not in use and use energy-efficient appliances."} end})
table.insert(data, {query={"how", "clean", "carpet"}, res=function (bandit, player) return {text="Vacuum regularly and use a carpet cleaner for deep cleaning."} end})
table.insert(data, {query={"how", "organize", "closet"}, res=function (bandit, player) return {text="Sort items by category and use storage bins and shelves."} end})
table.insert(data, {query={"how", "hang", "pictures"}, res=function (bandit, player) return {text="Use a level and picture hooks for accurate placement."} end})
table.insert(data, {query={"how", "remove", "stains"}, res=function (bandit, player) return {text="Blot the stain and use a stain remover or a mix of water and vinegar."} end})
table.insert(data, {query={"how", "make", "home", "cozy"}, res=function (bandit, player) return {text="Add soft textiles, warm lighting, and personal touches."} end})
table.insert(data, {query={"how", "arrange", "furniture"}, res=function (bandit, player) return {text="Create a focal point and leave enough space for movement."} end})
table.insert(data, {query={"how", "repair", "wall"}, res=function (bandit, player) return {text="Patch holes with spackle and sand it smooth before painting."} end})
table.insert(data, {query={"how", "clean", "windows"}, res=function (bandit, player) return {text="Use a mixture of water and vinegar and wipe with a microfiber cloth."} end})
table.insert(data, {query={"how", "maintain", "garden"}, res=function (bandit, player) return {text="Water regularly, remove weeds, and prune plants."} end})
table.insert(data, {query={"how", "choose", "paint", "color"}, res=function (bandit, player) return {text="Consider the room's lighting and the mood you want to create."} end})
table.insert(data, {query={"how", "keep", "house", "cool"}, res=function (bandit, player) return {text="Use fans, close blinds during the day, and open windows at night."} end})
table.insert(data, {query={"how", "declutter"}, res=function (bandit, player) return {text="Go room by room, and keep only what you need and love."} end})
table.insert(data, {query={"how", "set", "table"}, res=function (bandit, player) return {text="Place plates in the center, forks on the left, knives and spoons on the right."} end})
table.insert(data, {query={"how", "clean", "kitchen"}, res=function (bandit, player) return {text="Wipe down surfaces, clean appliances, and sweep the floor."} end})
table.insert(data, {query={"how", "create", "storage"}, res=function (bandit, player) return {text="Use shelves, hooks, and storage bins to maximize space."} end})
table.insert(data, {query={"how", "freshen", "air"}, res=function (bandit, player) return {text="Open windows, use air purifiers, and place plants around the house."} end})

-- Fashion 
table.insert(data, {query={"what", "should", "I", "wear"}, res=function (bandit, player) return {text="Wear something that makes you feel confident and comfortable."} end})
table.insert(data, {query={"how", "do", "I", "look"}, res=function (bandit, player) return {text="You look great! Rock that outfit."} end})
table.insert(data, {query={"what", "trending"}, res=function (bandit, player) return {text="Right now, it's all about sustainable and eco-friendly fashion."} end})
table.insert(data, {query={"how", "to", "style", "this"}, res=function (bandit, player) return {text="Try pairing it with some statement accessories."} end})
table.insert(data, {query={"what", "your", "favorite", "brand"}, res=function (bandit, player) return {text="I love brands that focus on sustainability and ethical practices."} end})
table.insert(data, {query={"what", "colors", "look", "good", "on", "me"}, res=function (bandit, player) return {text="It depends on your skin tone, but you can't go wrong with classic neutrals."} end})
table.insert(data, {query={"you", "like", "my", "outfit"}, res=function (bandit, player) return {text="Absolutely! It's stylish and suits you well."} end})
table.insert(data, {query={"how", "to", "accessorize"}, res=function (bandit, player) return {text="Less is more. Choose a few key pieces that complement your outfit."} end})
table.insert(data, {query={"what", "style"}, res=function (bandit, player) return {text="Vintage and retro looks are making a comeback."} end})
table.insert(data, {query={"how", "to", "dress", "for", "party"}, res=function (bandit, player) return {text="Go for something fun and comfortable so you can dance the night away."} end})
table.insert(data, {query={"what", "your", "outfit"}, res=function (bandit, player) return {text="I love a good pair of jeans and a comfy sweater."} end})
table.insert(data, {query={"what", "shoes", "to", "wear"}, res=function (bandit, player) return {text="Pick shoes that match your outfit and are comfortable enough for the day."} end})
table.insert(data, {query={"how", "to", "layer", "clothing"}, res=function (bandit, player) return {text="Start with a base layer, add a mid-layer, and finish with a stylish outer layer."} end})
table.insert(data, {query={"you", "follow", "fashion", "trends"}, res=function (bandit, player) return {text="I like to stay updated but I prefer timeless and classic pieces."} end})
table.insert(data, {query={"what", "your", "style"}, res=function (bandit, player) return {text="My style is all about comfort and versatility with a touch of elegance."} end})
table.insert(data, {query={"how", "to", "dress", "casual"}, res=function (bandit, player) return {text="Go for jeans, a simple tee, and comfortable sneakers."} end})
table.insert(data, {query={"what", "a", "must-have", "in", "wardrobe"}, res=function (bandit, player) return {text="A well-fitted blazer can instantly elevate any look."} end})
table.insert(data, {query={"how", "to", "choose", "accessories"}, res=function (bandit, player) return {text="Pick accessories that complement your outfit without overpowering it."} end})
table.insert(data, {query={"do", "you", "like", "fashion"}, res=function (bandit, player) return {text="Absolutely! Fashion is a great way to express yourself."} end})
table.insert(data, {query={"how", "to", "find", "personal", "style"}, res=function (bandit, player) return {text="Experiment with different looks and wear what makes you feel good."} end})

-- Pop culture
table.insert(data, {query={"do", "you", "like", "Deadpool"}, res=function (bandit, player) return {text="Yeah, Deadpool is hilarious and totally unpredictable."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "Deadpool"}, res=function (bandit, player) return {text="I think Deadpool's humor and action scenes are top-notch."} end})
table.insert(data, {query={"do", "you", "like", "The Matrix"}, res=function (bandit, player) return {text="Absolutely! 'The Matrix' is a sci-fi masterpiece."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "The Matrix"}, res=function (bandit, player) return {text="The Matrix is mind-blowing with its action and deep storyline."} end})
table.insert(data, {query={"do", "you", "like", "AC/DC"}, res=function (bandit, player) return {text="Definitely! AC/DC's rock music is legendary."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "AC/DC"}, res=function (bandit, player) return {text="AC/DC are rock icons with timeless music."} end})
table.insert(data, {query={"do", "you", "like", "Harry Potter"}, res=function (bandit, player) return {text="Yes! The Harry Potter series is magical and so captivating."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "Harry Potter"}, res=function (bandit, player) return {text="The Harry Potter series is a fantastic journey into a magical world."} end})
table.insert(data, {query={"do", "you", "like", "Star Wars"}, res=function (bandit, player) return {text="Totally! Star Wars is a legendary saga with epic battles."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "Star Wars"}, res=function (bandit, player) return {text="Star Wars is an iconic series with unforgettable characters."} end})
table.insert(data, {query={"do", "you", "like", "Queen"}, res=function (bandit, player) return {text="Yes! Queen's music is timeless and Freddie Mercury was amazing."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "Queen"}, res=function (bandit, player) return {text="Queen is one of the greatest rock bands of all time."} end})
table.insert(data, {query={"do", "you", "like", "Friends"}, res=function (bandit, player) return {text="Yeah, Friends is a classic sitcom that's always fun to watch."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "Friends"}, res=function (bandit, player) return {text="Friends is hilarious and has such memorable characters."} end})
table.insert(data, {query={"do", "you", "like", "Game of Thrones"}, res=function (bandit, player) return {text="Yes! Game of Thrones is full of twists and epic moments."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "Game of Thrones"}, res=function (bandit, player) return {text="Game of Thrones was a rollercoaster with amazing plot twists."} end})
table.insert(data, {query={"do", "you", "like", "The Office"}, res=function (bandit, player) return {text="Absolutely! The Office is hilarious and has great characters."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "The Office"}, res=function (bandit, player) return {text="The Office is a comedy gem with unforgettable moments."} end})
table.insert(data, {query={"do", "you", "like", "Beyonce"}, res=function (bandit, player) return {text="Yes! Beyonce is an incredible performer and a music icon."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "Beyonce"}, res=function (bandit, player) return {text="Beyonce is amazing and always puts on a fantastic show."} end})
table.insert(data, {query={"do", "you", "like", "Stranger Things"}, res=function (bandit, player) return {text="Totally! Stranger Things is thrilling and nostalgic."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "Stranger Things"}, res=function (bandit, player) return {text="Stranger Things has a great plot and an awesome nostalgic vibe."} end})
table.insert(data, {query={"do", "you", "like", "Naruto"}, res=function (bandit, player) return {text="Yes! Naruto is an epic anime with a lot of heart."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "Naruto"}, res=function (bandit, player) return {text="Naruto is a fantastic anime with great character development."} end})
table.insert(data, {query={"do", "you", "like", "Marvel"}, res=function (bandit, player) return {text="Absolutely! Marvel movies are full of action and great stories."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "Marvel"}, res=function (bandit, player) return {text="Marvel's movies are exciting and have amazing characters."} end})
table.insert(data, {query={"do", "you", "like", "The Hobbit"}, res=function (bandit, player) return {text="Yes! The Hobbit is a wonderful adventure story."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "The Hobbit"}, res=function (bandit, player) return {text="The Hobbit is a classic with great storytelling and characters."} end})
table.insert(data, {query={"do", "you", "like", "The Dark Knight"}, res=function (bandit, player) return {text="Definitely! The Dark Knight is one of the best superhero films."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "The Dark Knight"}, res=function (bandit, player) return {text="The Dark Knight is an incredible film with a standout performance by Heath Ledger."} end})
table.insert(data, {query={"do", "you", "like", "Led Zeppelin"}, res=function (bandit, player) return {text="Yeah, Led Zeppelin's music is legendary."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "Led Zeppelin"}, res=function (bandit, player) return {text="Led Zeppelin is iconic with their amazing rock sound."} end})
table.insert(data, {query={"do", "you", "like", "Breaking Bad"}, res=function (bandit, player) return {text="Absolutely! Breaking Bad is intense and brilliantly written."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "Breaking Bad"}, res=function (bandit, player) return {text="Breaking Bad is one of the best TV shows ever made."} end})
table.insert(data, {query={"do", "you", "like", "Kanye West"}, res=function (bandit, player) return {text="Yes, Kanye West is a genius with his music and production."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "Kanye West"}, res=function (bandit, player) return {text="Kanye West is incredibly talented and always pushes boundaries."} end})
table.insert(data, {query={"do", "you", "like", "Lord of the Rings"}, res=function (bandit, player) return {text="Definitely! Lord of the Rings is an epic fantasy adventure."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "Lord of the Rings"}, res=function (bandit, player) return {text="Lord of the Rings is a masterpiece with an amazing story."} end})
table.insert(data, {query={"do", "you", "like", "Metallica"}, res=function (bandit, player) return {text="Yes! Metallica's music is powerful and timeless."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "Metallica"}, res=function (bandit, player) return {text="Metallica is one of the greatest metal bands ever."} end})
table.insert(data, {query={"do", "you", "like", "Pulp Fiction"}, res=function (bandit, player) return {text="Absolutely! Pulp Fiction is a classic Tarantino film."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "Pulp Fiction"}, res=function (bandit, player) return {text="Pulp Fiction is a masterpiece with unforgettable characters."} end})
table.insert(data, {query={"do", "you", "like", "Drake"}, res=function (bandit, player) return {text="Yes! Drake's music is always on point."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "Drake"}, res=function (bandit, player) return {text="Drake is a top artist with a unique style."} end})
table.insert(data, {query={"do", "you", "like", "Friends"}, res=function (bandit, player) return {text="Yeah, Friends is a classic sitcom that's always fun to watch."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "Friends"}, res=function (bandit, player) return {text="Friends is hilarious and has such memorable characters."} end})
table.insert(data, {query={"do", "you", "like", "The Simpsons"}, res=function (bandit, player) return {text="Totally! The Simpsons is a hilarious and iconic show."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "The Simpsons"}, res=function (bandit, player) return {text="The Simpsons is a brilliant show with timeless humor."} end})
table.insert(data, {query={"do", "you", "like", "The Godfather"}, res=function (bandit, player) return {text="Yes! The Godfather is a cinematic masterpiece."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "The Godfather"}, res=function (bandit, player) return {text="The Godfather is one of the best films ever made."} end})
table.insert(data, {query={"do", "you", "like", "Taylor Swift"}, res=function (bandit, player) return {text="Absolutely! Taylor Swift's music is catchy and relatable."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "Taylor Swift"}, res=function (bandit, player) return {text="Taylor Swift is an amazing artist with great storytelling in her songs."} end})
table.insert(data, {query={"do", "you", "like", "Black Panther"}, res=function (bandit, player) return {text="Yes! Black Panther is a fantastic superhero film."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "Black Panther"}, res=function (bandit, player) return {text="Black Panther is an incredible movie with a powerful message."} end})
table.insert(data, {query={"do", "you", "like", "Stranger Things"}, res=function (bandit, player) return {text="Totally! Stranger Things is thrilling and nostalgic."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "Stranger Things"}, res=function (bandit, player) return {text="Stranger Things has a great plot and an awesome nostalgic vibe."} end})
table.insert(data, {query={"do", "you", "like", "The Beatles"}, res=function (bandit, player) return {text="Absolutely! The Beatles are legends in music history."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "The Beatles"}, res=function (bandit, player) return {text="The Beatles changed the music world forever. Their songs are timeless."} end})
table.insert(data, {query={"do", "you", "like", "The Avengers"}, res=function (bandit, player) return {text="Yes! The Avengers movies are action-packed and full of great characters."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "The Avengers"}, res=function (bandit, player) return {text="The Avengers movies are epic and bring so many heroes together."} end})
table.insert(data, {query={"do", "you", "like", "Madonna"}, res=function (bandit, player) return {text="Totally! Madonna is a pop icon with incredible hits."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "Madonna"}, res=function (bandit, player) return {text="Madonna is a legend in the music industry with a huge influence on pop culture."} end})
table.insert(data, {query={"do", "you", "like", "Back to the Future"}, res=function (bandit, player) return {text="Yes! Back to the Future is a classic with an amazing story."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "Back to the Future"}, res=function (bandit, player) return {text="Back to the Future is an all-time favorite with great time-traveling fun."} end})
table.insert(data, {query={"do", "you", "like", "Adele"}, res=function (bandit, player) return {text="Absolutely! Adele's voice is powerful and her songs are beautiful."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "Adele"}, res=function (bandit, player) return {text="Adele is an incredible artist with soulful music."} end})
table.insert(data, {query={"do", "you", "like", "Batman"}, res=function (bandit, player) return {text="Totally! Batman is one of the coolest and darkest superheroes."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "Batman"}, res=function (bandit, player) return {text="Batman is a fascinating character with a great story."} end})
table.insert(data, {query={"do", "you", "like", "The Rolling Stones"}, res=function (bandit, player) return {text="Yes! The Rolling Stones are rock legends."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "The Rolling Stones"}, res=function (bandit, player) return {text="The Rolling Stones have made some of the best rock music ever."} end})
table.insert(data, {query={"do", "you", "like", "Avatar"}, res=function (bandit, player) return {text="Definitely! Avatar is visually stunning and has a great story."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "Avatar"}, res=function (bandit, player) return {text="Avatar is a groundbreaking film with amazing visuals."} end})
table.insert(data, {query={"do", "you", "like", "Lady Gaga"}, res=function (bandit, player) return {text="Absolutely! Lady Gaga is a unique and talented artist."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "Lady Gaga"}, res=function (bandit, player) return {text="Lady Gaga is a phenomenal performer with a distinctive style."} end})
table.insert(data, {query={"do", "you", "like", "The Beatles"}, res=function (bandit, player) return {text="Absolutely! The Beatles are legends in music history."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "The Beatles"}, res=function (bandit, player) return {text="The Beatles changed the music world forever. Their songs are timeless."} end})
table.insert(data, {query={"do", "you", "like", "The Witcher"}, res=function (bandit, player) return {text="Yes! The Witcher is a great series with fantastic storytelling."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "The Witcher"}, res=function (bandit, player) return {text="The Witcher is a thrilling series with complex characters."} end})
table.insert(data, {query={"do", "you", "like", "Beyonce"}, res=function (bandit, player) return {text="Yes! Beyonce is an incredible performer and a music icon."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "Beyonce"}, res=function (bandit, player) return {text="Beyonce is amazing and always puts on a fantastic show."} end})
table.insert(data, {query={"do", "you", "like", "Inception"}, res=function (bandit, player) return {text="Totally! Inception is a mind-bending and brilliant film."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "Inception"}, res=function (bandit, player) return {text="Inception is an amazing movie with a complex and intriguing plot."} end})
table.insert(data, {query={"do", "you", "like", "Sia"}, res=function (bandit, player) return {text="Absolutely! Sia's voice is unique and her music is great."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "Sia"}, res=function (bandit, player) return {text="Sia is an incredibly talented artist with distinctive style."} end})
table.insert(data, {query={"do", "you", "like", "Star Trek"}, res=function (bandit, player) return {text="Yes! Star Trek is a groundbreaking sci-fi series."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "Star Trek"}, res=function (bandit, player) return {text="Star Trek is a visionary series that paved the way for modern sci-fi."} end})
table.insert(data, {query={"do", "you", "like", "The Beatles"}, res=function (bandit, player) return {text="Absolutely! The Beatles are legends in music history."} end})
table.insert(data, {query={"what", "do", "you", "think", "of", "The Beatles"}, res=function (bandit, player) return {text="The Beatles changed the music world forever. Their songs are timeless."} end})

-- math
table.insert(data, {query={"2", "+", "2"}, res=function (bandit, player) return {text="4."} end})

-- fallbacks to say something very generic
table.insert(data, {query={"do", "you", "think"}, res=function (bandit, player) return {text="I think I don't."} end})
table.insert(data, {query={"do", "you", "understand"}, res=function (bandit, player) return {text="Can you rephrase that?"} end})

table.insert(data, {query={"I", "am"}, res=function (bandit, player) return {text="Maybe you are."} end})
table.insert(data, {query={"you", "are"}, res=function (bandit, player) return {text="Maybe I am."} end})
table.insert(data, {query={"he", "is"}, res=function (bandit, player) return {text="Maybe he is."} end})
table.insert(data, {query={"he", "s"}, res=function (bandit, player) return {text="Maybe he is."} end})
table.insert(data, {query={"she", "is"}, res=function (bandit, player) return {text="Maybe she is."} end})
table.insert(data, {query={"she", "s"}, res=function (bandit, player) return {text="Maybe she is."} end})
table.insert(data, {query={"we", "are"}, res=function (bandit, player) return {text="We might be."} end})
table.insert(data, {query={"they", "are"}, res=function (bandit, player) return {text="They might be."} end})

table.insert(data, {query={"I", "was"}, res=function (bandit, player) return {text="Maybe you was."} end})
table.insert(data, {query={"you", "were"}, res=function (bandit, player) return {text="Maybe I was."} end})
table.insert(data, {query={"he", "was"}, res=function (bandit, player) return {text="Maybe he was."} end})
table.insert(data, {query={"she", "was"}, res=function (bandit, player) return {text="Maybe she was."} end})
table.insert(data, {query={"we", "were"}, res=function (bandit, player) return {text="Maybe we were."} end})
table.insert(data, {query={"they", "were"}, res=function (bandit, player) return {text="Maybe they were."} end})

table.insert(data, {query={"can", "I"}, res=function (bandit, player) return {text="I don't know if you can."} end})
table.insert(data, {query={"can", "you"}, res=function (bandit, player) return {text="I don't know if I can."} end})
table.insert(data, {query={"can", "we"}, res=function (bandit, player) return {text="We should not."} end})
table.insert(data, {query={"can", "he"}, res=function (bandit, player) return {text="I don't know if he can."} end})
table.insert(data, {query={"can", "she"}, res=function (bandit, player) return {text="I don't know if she can."} end})
table.insert(data, {query={"can", "they"}, res=function (bandit, player) return {text="I don't know if they can."} end})

table.insert(data, {query={"could", "I"}, res=function (bandit, player) return {text="I don't know if you could."} end})
table.insert(data, {query={"could", "you"}, res=function (bandit, player) return {text="I don't know if I could."} end})
table.insert(data, {query={"could", "we"}, res=function (bandit, player) return {text="We should not."} end})
table.insert(data, {query={"could", "he"}, res=function (bandit, player) return {text="I don't know if he could."} end})
table.insert(data, {query={"could", "she"}, res=function (bandit, player) return {text="I don't know if she could."} end})
table.insert(data, {query={"could", "they"}, res=function (bandit, player) return {text="I don't know if they could."} end})

table.insert(data, {query={"should", "I"}, res=function (bandit, player) return {text="I don't know if you should."} end})
table.insert(data, {query={"should", "you"}, res=function (bandit, player) return {text="I don't know if I should."} end})
table.insert(data, {query={"should", "we"}, res=function (bandit, player) return {text="We should not."} end})
table.insert(data, {query={"should", "he"}, res=function (bandit, player) return {text="I don't know if he should."} end})
table.insert(data, {query={"should", "she"}, res=function (bandit, player) return {text="I don't know if she should."} end})
table.insert(data, {query={"should", "they"}, res=function (bandit, player) return {text="I don't know if they should."} end})

table.insert(data, {query={"would", "I"}, res=function (bandit, player) return {text="I don't know if you would."} end})
table.insert(data, {query={"would", "you"}, res=function (bandit, player) return {text="I don't know if I would."} end})
table.insert(data, {query={"would", "we"}, res=function (bandit, player) return {text="We should not."} end})
table.insert(data, {query={"would", "he"}, res=function (bandit, player) return {text="I don't know if he would."} end})
table.insert(data, {query={"would", "she"}, res=function (bandit, player) return {text="I don't know if she would."} end})
table.insert(data, {query={"would", "they"}, res=function (bandit, player) return {text="I don't know if they would."} end})

table.insert(data, {query={"will", "I"}, res=function (bandit, player) return {text="I don't know if you will."} end})
table.insert(data, {query={"ll", "I"}, res=function (bandit, player) return {text="I don't know if you will."} end})
table.insert(data, {query={"will", "you"}, res=function (bandit, player) return {text="I don't know if I will."} end})
table.insert(data, {query={"ll", "you"}, res=function (bandit, player) return {text="I don't know if I will."} end})
table.insert(data, {query={"will", "we"}, res=function (bandit, player) return {text="We probably won't."} end})
table.insert(data, {query={"ll", "we"}, res=function (bandit, player) return {text="We probably won't."} end})
table.insert(data, {query={"will", "he"}, res=function (bandit, player) return {text="I don't know if he wil."} end})
table.insert(data, {query={"ll", "he"}, res=function (bandit, player) return {text="I don't know if he wil."} end})
table.insert(data, {query={"will", "she"}, res=function (bandit, player) return {text="I don't know if she will."} end})
table.insert(data, {query={"ll", "she"}, res=function (bandit, player) return {text="I don't know if she will."} end})
table.insert(data, {query={"will", "they"}, res=function (bandit, player) return {text="I don't know if they will."} end})
table.insert(data, {query={"ll", "they"}, res=function (bandit, player) return {text="I don't know if they will."} end})

table.insert(data, {query={"do", "i"}, res=function (bandit, player) return {text="I think you don't."} end})
table.insert(data, {query={"do", "you"}, res=function (bandit, player) return {text="I think I don't."} end})
table.insert(data, {query={"do", "we"}, res=function (bandit, player) return {text="I think we don't."} end})
table.insert(data, {query={"does", "he"}, res=function (bandit, player) return {text="I think he doesn't."} end})
table.insert(data, {query={"does", "she"}, res=function (bandit, player) return {text="I think she doesn't."} end})
table.insert(data, {query={"do", "they"}, res=function (bandit, player) return {text="I think they don't."} end})

table.insert(data, {query={"did", "i"}, res=function (bandit, player) return {text="I think you didn't."} end})
table.insert(data, {query={"did", "you"}, res=function (bandit, player) return {text="I think I didn't."} end})
table.insert(data, {query={"did", "we"}, res=function (bandit, player) return {text="I think we didn't."} end})
table.insert(data, {query={"did", "he"}, res=function (bandit, player) return {text="I think he didn't."} end})
table.insert(data, {query={"did", "she"}, res=function (bandit, player) return {text="I think she didn't."} end})
table.insert(data, {query={"did", "they"}, res=function (bandit, player) return {text="I think they don't."} end})

table.insert(data, {query={"have", "i"}, res=function (bandit, player) return {text="I think you haven't."} end})
table.insert(data, {query={"have", "you"}, res=function (bandit, player) return {text="I think I haven't."} end})
table.insert(data, {query={"have", "we"}, res=function (bandit, player) return {text="I think we haven't."} end})
table.insert(data, {query={"has", "he"}, res=function (bandit, player) return {text="I think he hasn't."} end})
table.insert(data, {query={"has", "she"}, res=function (bandit, player) return {text="I think she hasn't."} end})
table.insert(data, {query={"have", "they"}, res=function (bandit, player) return {text="I think they haven't."} end})

table.insert(data, {query={"is", "there"}, res=function (bandit, player) return {text="There might be."} end})
table.insert(data, {query={"is", "it"}, res=function (bandit, player) return {text="It could be."} end})
table.insert(data, {query={"is", "this"}, res=function (bandit, player) return {text="It could be."} end})
table.insert(data, {query={"is", "that"}, res=function (bandit, player) return {text="It could be."} end})
table.insert(data, {query={"was", "it"}, res=function (bandit, player) return {text="It might have been."} end})
table.insert(data, {query={"was", "this"}, res=function (bandit, player) return {text="It might have been."} end})
table.insert(data, {query={"was", "that"}, res=function (bandit, player) return {text="It might have been."} end})
table.insert(data, {query={"can", "it"}, res=function (bandit, player) return {text="It could be possible."} end})
table.insert(data, {query={"can", "this"}, res=function (bandit, player) return {text="It could be possible."} end})
table.insert(data, {query={"can", "that"}, res=function (bandit, player) return {text="It could be possible."} end})
table.insert(data, {query={"will", "it"}, res=function (bandit, player) return {text="It might."} end})
table.insert(data, {query={"ll", "it"}, res=function (bandit, player) return {text="It might."} end})
table.insert(data, {query={"will", "this"}, res=function (bandit, player) return {text="It might."} end})
table.insert(data, {query={"ll", "this"}, res=function (bandit, player) return {text="It might."} end})
table.insert(data, {query={"will", "that"}, res=function (bandit, player) return {text="It might."} end})
table.insert(data, {query={"should", "it"}, res=function (bandit, player) return {text="Maybe it should"} end})
table.insert(data, {query={"should", "this"}, res=function (bandit, player) return {text="Maybe it should"} end})
table.insert(data, {query={"should", "that"}, res=function (bandit, player) return {text="Maybe it should"} end})
table.insert(data, {query={"could", "it"}, res=function (bandit, player) return {text="It could, but should it?"} end})
table.insert(data, {query={"could", "this"}, res=function (bandit, player) return {text="It could, but should it?"} end})
table.insert(data, {query={"could", "that"}, res=function (bandit, player) return {text="It could, but should it?"} end})
table.insert(data, {query={"would", "it"}, res=function (bandit, player) return {text="It might be considered."} end})
table.insert(data, {query={"would", "this"}, res=function (bandit, player) return {text="It might be considered."} end})
table.insert(data, {query={"would", "that"}, res=function (bandit, player) return {text="It might be considered."} end})

table.insert(data, {query={"how", "much"}, res=function (bandit, player) return {text="A lot."} end})
table.insert(data, {query={"how", "many"}, res=function (bandit, player) return {text="A lot."} end})
table.insert(data, {query={"how", "far"}, res=function (bandit, player) return {text="I don't know how far, sorry."} end})

table.insert(data, {query={"tell", "me"}, res=function (bandit, player) return {text="I don't remember."} end})

table.insert(data, {query={"why"}, res=function (bandit, player) return {text="I don't know the reason."} end})
table.insert(data, {query={"where"}, res=function (bandit, player) return {text="I don't know where."} end})
table.insert(data, {query={"when"}, res=function (bandit, player) return {text="I don't know when."} end})

table.insert(data, {query={"nice"}, res=function (bandit, player) return {text="Thank you!"} end})
table.insert(data, {query={"weather"}, res=function (bandit, player) return {text="%RAIN. %SNOW"} end})
table.insert(data, {query={"gunshots"}, res=function (bandit, player) return {text="Must be the military?"} end})
table.insert(data, {query={"gunshot"}, res=function (bandit, player) return {text="Must be the military?"} end})
table.insert(data, {query={"corpse"}, res=function (bandit, player) return {text="A corpse? That's really terrible!"} end})
table.insert(data, {query={"corpses"}, res=function (bandit, player) return {text="Corpses? That's really terrible!"} end})
table.insert(data, {query={"fire"}, res=function (bandit, player) return {text="It's getting worm out here!"} end})
table.insert(data, {query={"accident"}, res=function (bandit, player) return {text="That's really terrible!"} end})
table.insert(data, {query={"thief"}, res=function (bandit, player) return {text="A thief? That's really terrible!"} end})
table.insert(data, {query={"thieves"}, res=function (bandit, player) return {text="Thieves? That's really terrible!"} end})
table.insert(data, {query={"stolen"}, res=function (bandit, player) return {text="That's really terrible!"} end})
table.insert(data, {query={"burglar"}, res=function (bandit, player) return {text="A burglar? That's really terrible!"} end})
table.insert(data, {query={"burglars"}, res=function (bandit, player) return {text="Burglars? That's really terrible!"} end})
table.insert(data, {query={"bandit"}, res=function (bandit, player) return {text="A bandit? That's really terrible!"} end})
table.insert(data, {query={"bandits"}, res=function (bandit, player) return {text="Bandits? That's really terrible!"} end})
table.insert(data, {query={"criminal"}, res=function (bandit, player) return {text="A criminal? That's really terrible!"} end})
table.insert(data, {query={"criminals"}, res=function (bandit, player) return {text="Criminals? That's really terrible!"} end})
table.insert(data, {query={"apocalypse"}, res=function (bandit, player) return {text="Apocalypse? You are crazy!"} end})
table.insert(data, {query={"zombie"}, res=function (bandit, player) return {text="A zombie? You are crazy!"} end})
table.insert(data, {query={"zombies"}, res=function (bandit, player) return {text="Zombies? You are crazy!"} end})
table.insert(data, {query={"test"}, res=function (bandit, player) return {text="test!"} end})

BWOChat = {}

BWOChat.Say = function(chatMessage, quiet)

    local getName = function(brain)
        local name = "I'm "
        name = name .. brain.fullname .. ". "
        if brain.program.name == "Babe" then
            name = name .. "We live together."
        else
            local homeCoords = BWOBuildings.GetEventBuildingCoords("home")
            local dist = BanditUtils.DistTo(brain.bornCoords.x, brain.bornCoords.y, homeCoords.x, homeCoords.y)
            if dist < 45 then
                name = name .. "I am your neighbor."
            end
        end
        return name
    end

    local getMood = function()
        if BWOScheduler.SymptomLevel == 0 then
            local opts = {"I'm great! Maybe a little stressed lately...",
                          "I'm good, thanks! But some people around behave strangly...",
                          "Excellent, how are you?"}
            return BanditUtils.Choice(opts)
        elseif BWOScheduler.SymptomLevel == 1 then
            local opts = {"I'm doing fine.. just a slight headache...",
                          "I'm fine, having headache though...",
                          "I have a headache and nausea..."}
            return BanditUtils.Choice(opts)
        elseif BWOScheduler.SymptomLevel == 2 then
            local opts = {"Not so well honestly, I have terrible cough...",
                          "Honestly not so good, I have to admit...",
                          "I have a very bad cough and nausea..."}
            return BanditUtils.Choice(opts)
        elseif BWOScheduler.SymptomLevel >= 3 then
            local opts = {"Oh I'm really sick!",
                          "Yesterday I was okay, but today I feel terrible!",
                          "I have never felt that bad in my life..."}
            return BanditUtils.Choice(opts)
        end
    end

    local getCity = function(player)
        local zones = getZones(player:getX(), player:getY(), player:getZ())
        if zones then
            for i=0, zones:size()-1 do
                local zone = zones:get(i)
                if zone:getType() == "Region" then
                    return zone:getName()
                end
            end
        end
    end

    local isIntrusion = function(bandit)
        local room = bandit:getSquare():getRoom()
        if room then
            return BWORooms.IsIntrusion(room)
        end
        return false
    end

    local getWeapons = function(bandit)
        local weapons = Bandit.GetWeapons(bandit)
        local txt = "I have "
        txt = txt .. weapons.melee:match("%.([^%.]+)$")

        if weapons.primary.name then
            txt = txt .. " and " .. weapons.primary.name:match("%.([^%.]+)$")
        end

        if weapons.secondary.name then
            txt = txt .. " and " .. weapons.secondary.name:match("%.([^%.]+)$")
        end

        txt = txt .. "."
        return txt
    end

    local player = getSpecificPlayer(0)
    if not player then return end

    local color = player:getSpeakColour()
    if not quiet then
        player:addLineChatElement(chatMessage, color:getR(), color:getG(), color:getB())
    end

    local cm = chatMessage:lower()
    local cm2 = ""
    for word in cm:gmatch("%S+") do
        local word2 = Lemmats.EN[word]
        if word2 then
            cm2 = cm2 .. word2 .. " "
        end
    end

	for k, v in pairs(data) do
        local query = v.query

        local allMatch = true
        for _, word in pairs(v.query) do
            if not cm:hasword(word) and not cm2:hasword(word) then
                allMatch = false
                break
            end
        end

        if allMatch then
            local target = BanditUtils.GetClosestBanditLocationProgram(player, {"Walker", "Runner", "Inhabitant", "Active", "Babe"})
            if target.dist < 8 then
                local bandit = BanditZombie.GetInstanceById(target.id)
                local brain = BanditBrain.Get(bandit)
                local gametime = getGameTime()
                local cm = getWorld():getClimateManager()

                local name = getName(brain)
                local city = getCity(player) or "unknown location"
                local season = cm:getSeasonName()
                local rain = cm:isRaining() and "It's raining" or "It's not raining"
                local snow = cm:isSnowing() and "It's snowing" or "It's not snowing"
                local intrusion = isIntrusion(bandit) and "NOT welcome" or "very welcome"
                local temperature = math.floor(cm:getTemperature())
                local mood = getMood()
                local weapons = getWeapons(bandit)

                Bandit.ClearTasks(bandit)

                local response = v.res(bandit, player)

                local anim = BanditUtils.Choice({"Talk1", "Talk2", "Talk3", "Talk4", "Talk5"})
                if response.anim then
                    anim = response.anim
                end

                local colors = {r=0, g=1, b=0}
                local recognized = true
                if response.action then
                    if response.action == "HOSTILE" then
                        Bandit.SetProgram(bandit, "Active", {})
                        Bandit.SetHostile(bandit, true)
                        colors = {r=1, g=0, b=0}
                    elseif response.action == "JOIN" then
                        Bandit.SetProgram(bandit, "Babe", {})
                        Bandit.SetHostile(bandit, false)
                        brain.permanent = true
                        colors = {r=0, g=1, b=0}
                    elseif response.action == "RELAX" and brain.program.name == "Active" then
                        Bandit.SetProgram(bandit, "Walker", {})
                        Bandit.SetHostile(bandit, false)
                        colors = {r=0, g=1, b=0}
                    elseif response.action == "LEAVE" and brain.program.name == "Babe" then
                        Bandit.SetProgram(bandit, "Walker", {})
                        colors = {r=0, g=1, b=0}
                    elseif response.action == "GUARD" and brain.program.name == "Babe" then
                        Bandit.SetProgramStage(bandit, "Guard", {})
                        colors = {r=0, g=1, b=0}
                    elseif response.action == "BASE" and brain.program.name == "Babe" then
                        Bandit.SetProgramStage(bandit, "Base", {})
                        colors = {r=0, g=1, b=0}
                    elseif response.action == "TERMINATE" then
                        bandit:Kill(nil)
                    else
                        recognized = false
                    end
                else
                    local task = {action="TimeEvent", anim=anim, x=player:getX(), y=player:getY(), time=200}
                    Bandit.AddTask(bandit, task)
                end

                if recognized then
                    local res = response.text

                    -- interpolate vars
                    res = res:replace("%NAME", name)
                    res = res:replace("%HOUR", gametime:getHour())
                    res = res:replace("%MINUTE", gametime:getMinutes())
                    res = res:replace("%CITY", city)
                    res = res:replace("%RAIN", rain)
                    res = res:replace("%SNOW", snow)
                    res = res:replace("%SEASON", season)
                    res = res:replace("%TEMPERATURE", temperature)
                    res = res:replace("%INTRUSION", intrusion)
                    res = res:replace("%MOOD", mood)
                    res = res:replace("%WEAPONS", weapons)
                    bandit:addLineChatElement(res, colors.r, colors.g, colors.b)
                end

                break
            end
        end
    end
end

-- Events.OnAddMessage.Add(OnAddMessage)

local function onKeyPressed(keynum)
    local options = PZAPI.ModOptions:getOptions("BanditsWeekOne")
    local key = options:getOption("TALK"):getValue()

    if keynum == key then
        local ui = BWOChatPanel:new(0, 0, 300, 200, getSpecificPlayer(0))
        ui:initialise()
        ui:addToUIManager()
    elseif keynum == Keyboard.KEY_Q then
        local player = getSpecificPlayer(0)
        if player then
            if player:getVehicle() then
                BWOChat.Say("xhornx", true)
            else
                BWOChat.Say("Hey!", true)
            end
        end
    end
end

local function onEmote(character, emote)
    local emote2txt = {}

    emote2txt["wavehi"] = BanditUtils.Choice({"Hello!", "Hey!", "Hi!", "Greetings!", "Howdy!"})

    emote2txt["wavebye"] = BanditUtils.Choice({"Bye!", "See you!", "Take Care!", "Farewell!", "Later!", "Peace out!", "Goodbye!", 
                                               "So long!", "I'm off!", "See you soon!", "Time to go.", "Have a good one!",
                                               "Till next time!", "I must leave", "Be seeing you", "Have a nice day",
                                               "Stay safe!", "Gotta run!", ""
                                                })

    emote2txt["clap"] = BanditUtils.Choice({"Let's give applause!", "Bravo!"})

    emote2txt["thankyou"] = BanditUtils.Choice({"I appreaciate it!", "Many thanks!", "Thank you so much!", "Thanks a million!",
                                                "I owe you one!", "Big thanks!", "So grateful!", "Forever grateful!", "Deep gratitude!",
                                                "You save the day!", "Couldn't thank yu  enough", "Much thanks!"})

    emote2txt["insult"] = BanditUtils.Choice({"Fuck you!", "You're such a bitch!", "Asshole!", "What a pussy!", "Fucking asshole!", "You look like a bitch!",
                                              "Go kiss a cow's cunt!", "Go drown in a lake of diet coke you neutered asshole.",
                                              "If a zombie was looking for brains, he'd walk right by you.", 
                                              "Are you always this stupid, or is this a special occasion?", 
                                              "You have a face for radio, moron.", "Are you always this stupid or is today a special occasion?",
                                              "If ugly were a crime, you'd get a life sentence.", "You're so fat, you could sell shade."})

    emote2txt["surrender"] = BanditUtils.Choice({"Forgive me!", "Sorry everyone!", "My apologies", "I beg your pardon!", "My bad!"})

    emote2txt["stop"] = BanditUtils.Choice({"Can you stop?", "Stop please!", "Can you wait?"})

    emote2txt["followme"] = BanditUtils.Choice({"Come with me!", "Follow my lead!", "Follow me!", "Accompany me",
                                                "Stick with me", "Team up with me!", "Come along", "Walk with me",
                                                "Tag along", "Be with me", "Follow my path", "Accompany my journey!", "Sitck by me",
                                                "Team up together!", "Walk beside me", "Stay with me", "Be my companion",
                                                "Let's go!"})

    if emote2txt[emote] then
        BWOChat.Say(emote2txt[emote])
    end
end


LuaEventManager.AddEvent("OnEmote")

Events.OnKeyPressed.Add(onKeyPressed)
Events.OnEmote.Add(onEmote)

