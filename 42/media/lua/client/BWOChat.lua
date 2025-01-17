local data = {}

-- greetings and other politeness
table.insert(data, {query={"hey"}, res="Hi!", anim="WaveHi"})
table.insert(data, {query={"yo"}, res="Hi!", anim="WaveHi"})
table.insert(data, {query={"hello"}, res="Hi!", anim="WaveHi"})
table.insert(data, {query={"hi"}, res="Hi!", anim="WaveHi"})
table.insert(data, {query={"good", "morning"}, res="Hi!", anim="WaveHi"})
table.insert(data, {query={"good", "evening"}, res="Hi!", anim="WaveHi"})
table.insert(data, {query={"bye"}, res="See you!", anim="WaveHi"})
table.insert(data, {query={"see", "you"}, res="Bye!", anim="WaveHi"})
table.insert(data, {query={"cu"}, res="Bye!", anim="WaveHi"})
table.insert(data, {query={"cya"}, res="Bye!", anim="WaveHi"})
table.insert(data, {query={"bon appetit"}, res="Thanks!"})
table.insert(data, {query={"looks", "tasty"}, res="Thanks!"})
table.insert(data, {query={"thank you"}, res="You are welcome!"})
table.insert(data, {query={"thanks"}, res="You are welcome!"})
table.insert(data, {query={"thx"}, res="You are welcome!"})
table.insert(data, {query={"howdy"}, res="How do you do?"})
table.insert(data, {query={"nice", "meet"}, res="Nice to meet you too!"})
table.insert(data, {query={"nice", "meeting"}, res="Nice to meet you too!"})

-- personal questions
table.insert(data, {query={"what", "your", "name"}, res="I'm %NAME."})
table.insert(data, {query={"who", "are", "you"}, res="I'm %NAME."})
table.insert(data, {query={"how", "are", "you"}, res="%MOOD", anim="PainHead"})
table.insert(data, {query={"are", "you", "sick"}, res="%MOOD", anim="PainHead"})
table.insert(data, {query={"are", "you", "ok"}, res="%MOOD", anim="PainHead"})
table.insert(data, {query={"are", "you", "okay"}, res="%MOOD", anim="PainHead"})
table.insert(data, {query={"are", "you", "alright"}, res="%MOOD", anim="PainHead"})
table.insert(data, {query={"how", "old", "you"}, res="Oh I have just respawned recently!"})
table.insert(data, {query={"where", "you", "from"}, res="I'm from %CITY."})
table.insert(data, {query={"where", "am", "i"}, res="You're in %CITY."})
table.insert(data, {query={"where", "are", "we"}, res="We're in %CITY."})
table.insert(data, {query={"do", "you", "like"}, res="Yeah, sure."})
table.insert(data, {query={"do", "you", "love"}, res="Yeah, sure."})
table.insert(data, {query={"what", "are", "you", "doing"}, res="Living the day!"})

table.insert(data, {query={"hobby", "you"}, res="I like collecting dead bodies in my basement."})
table.insert(data, {query={"hobby", "your"}, res="I like collecting dead bodies in my basement."})

table.insert(data, {query={"favorite", "color"}, res="Pink!"})
table.insert(data, {query={"favorite", "music"}, res="Chopin!"})
table.insert(data, {query={"favorite", "game"}, res="Project Zomboid Week One Mod!"})
table.insert(data, {query={"favorite", "food"}, res="Polish Pierogi!"})
table.insert(data, {query={"favorite", "meal"}, res="Polish Pierogi!"})
table.insert(data, {query={"favorite", "country"}, res="Poland!"})
table.insert(data, {query={"favorite", "animal"}, res="I like cats!"})
table.insert(data, {query={"favorite", "song"}, res="High Hopes, Pink Floyd!"})
table.insert(data, {query={"favorite", "band"}, res="Pink Floyd!"})
table.insert(data, {query={"favorite", "stream"}, res="Snowbeetle!"})
table.insert(data, {query={"favorite", "movie"}, res="Those about zombies!"})
table.insert(data, {query={"favorite", "sport"}, res="Chess!"})

table.insert(data, {query={"belive", "god"}, res="Jesus is my savior!"})
table.insert(data, {query={"belive", "love"}, res="I do believe in love!"})
table.insert(data, {query={"belive", "aliens"}, res="Aliens? Hell no!"})
table.insert(data, {query={"belive", "zombies"}, res="Zombies? Hell no!"})
table.insert(data, {query={"belive", "magic"}, res="No, I don't believe in magic!"})

table.insert(data, {query={"have", "boyfriend"}, res="That's not your business!", anim="No"})
table.insert(data, {query={"have", "girlfriend"}, res="That's not your business!", anim="No"})
table.insert(data, {query={"have", "wife"}, res="That's not your business!", anim="No"})
table.insert(data, {query={"have", "husband"}, res="That's not your business!", anim="No"})
table.insert(data, {query={"have", "time"}, res="Sorry, I'm in a hurry!", anim="No"})
table.insert(data, {query={"what", "you", "doing"}, res="I'm doing what I was programmed to."})

table.insert(data, {query={"dont", "like", "your"}, res="That's too bad."})
table.insert(data, {query={"don't", "like", "your"}, res="That's too bad."})
table.insert(data, {query={"not", "like", "your"}, res="That's too bad"})

table.insert(data, {query={"like", "your"}, res="Thank you! You are very kind."})
table.insert(data, {query={"like", "my"}, res="Yes, I think I like it.", anim="Yes"})

table.insert(data, {query={"republican"}, res="I don't vote!"})
table.insert(data, {query={"democrat"}, res="I don't vote!"})

table.insert(data, {query={"you", "computer"}, res="No shit."})
table.insert(data, {query={"you", "stupid"}, res="So are you!"})
table.insert(data, {query={"you", "ugly"}, res="So are you!"})
table.insert(data, {query={"you", "dumb"}, res="You are not so bright yourself!"})
table.insert(data, {query={"you", "stupid"}, res="You are not so bright yourself!"})
table.insert(data, {query={"you", "pretty"}, res="Thank you!"})
table.insert(data, {query={"you", "beautiful"}, res="Thank you!"})
table.insert(data, {query={"you", "bleeding"}, res="I will die but then I will respawn!"})
table.insert(data, {query={"you", "die"}, res="I hope you are wrong."})
table.insert(data, {query={"you", "friend"}, res="I don't know you that well"})

table.insert(data, {query={"we", "die"}, res="I hope you are wrong."})
table.insert(data, {query={"you", "die"}, res="I hope you are wrong."})
table.insert(data, {query={"what", "in", "briefcase"}, res="Nothing you should know about!"})

table.insert(data, {query={"where", "are", "you", "going"}, res="I go where fate takes me."})

-- questions about the world
table.insert(data, {query={"is", "weather"}, res="%RAIN. %SNOW"})
table.insert(data, {query={"is", "raining"}, res="%RAIN."})
table.insert(data, {query={"is", "snowing"}, res="%SNOW."})
table.insert(data, {query={"what", "season"}, res="It's %SEASON."})
table.insert(data, {query={"what", "temperature"}, res="It's about %TEMPERATURE degrees outside."})
table.insert(data, {query={"what", "time"}, res="It's %HOUR:%MINUTE."})
table.insert(data, {query={"where", "is"}, res="Sorry, I don't know where it is.", anim="No"})
table.insert(data, {query={"where", "can", "i"}, res="Sorry, I don't know where you could do that.", anim="No"})

table.insert(data, {query={"seen", "zombie"}, res="Zombie? Are you mad?"})
table.insert(data, {query={"seen", "zombies"}, res="Zombie? Are you mad?"})
table.insert(data, {query={"saw", "zombie"}, res="Zombie? Are you mad?"})
table.insert(data, {query={"saw", "zombies"}, res="Zombie? Are you mad?"})
table.insert(data, {query={"you", "zombies"}, res="Zombie? You watched too many movies!"})
table.insert(data, {query={"seen", "party"}, res="I've heard one, they are very loud."})
table.insert(data, {query={"seen", "parties"}, res="I've heard one, they are very loud."})
table.insert(data, {query={"seen", "army"}, res="Yes. I don't know why they are here."})
table.insert(data, {query={"seen", "soldiers"}, res="Yes. I don't know why they are here."})
table.insert(data, {query={"saw", "dead"}, res="That is horrible!"})

table.insert(data, {query={"streets", "blocked"}, res="Yes, it seems so."})
table.insert(data, {query={"street", "blocked"}, res="Yes, it seems so."})

table.insert(data, {query={"what", "happened"}, res="Can't you see that everyone is going crazy?"})
table.insert(data, {query={"what", "going", "on"}, res="Can't you see that everyone is going crazy?"})
table.insert(data, {query={"what", "going", "on"}, res="Can't you see that everyone is going crazy?"})
table.insert(data, {query={"what", "the", "hell"}, res="Can't you see that everyone is going crazy?"})

-- giving intructions
table.insert(data, {query={"can", "stop"}, res="Sorry, I'm in a hurry!", anim="No"})
table.insert(data, {query={"stop", "please"}, res="Sorry, I'm in a hurry!", anim="No"})
table.insert(data, {query={"can", "wait"}, res="Sorry, I'm in a hurry!", anim="No"})
table.insert(data, {query={"wait", "me"}, res="Sorry, I'm in a hurry!", anim="No"})
table.insert(data, {query={"can", "i", "come", "in"}, res="You are %INTRUSION in here."})
table.insert(data, {query={"may", "i", "come", "in"}, res="You are %INTRUSION in here."})
table.insert(data, {query={"let", "me", "in"}, res="You are %INTRUSION in here."})

table.insert(data, {query={"help", "me"}, res="You're on your own.", anim="Shrug"})
table.insert(data, {query={"help", "you"}, res="You are very kind, but I don't need help at the moment.", anim="No"})

table.insert(data, {query={"give", "me"}, res="Sorry, I can't give you that.", anim="Shrug"})
table.insert(data, {query={"can", "i", "have"}, res="Sorry, I can't give you that.", anim="Shrug"})
table.insert(data, {query={"give", "you"}, res="Thanks, but I don't need that.", anim="No"})

table.insert(data, {query={"i", "need"}, res="Sorry, I can't help you with that.", anim="No"})
table.insert(data, {query={"do", "you", "need"}, res="Thanks, but I don't need that.", anim="No"})

table.insert(data, {query={"open", "door"}, res="We are apparently closed!", anim="No"})
table.insert(data, {query={"open", "window"}, res="I'm not opening it.", anim="No"})

table.insert(data, {query={"leave", "you"}, res="I'm staying where I want to!"})
table.insert(data, {query={"leave", "me"}, res="I thought you need me, but fine!", action="LEAVE"})
table.insert(data, {query={"stay", "here"}, res="I thought you need me, but fine!", action="LEAVE"})
table.insert(data, {query={"go", "away"}, res="I thought you need me, but fine!", action="LEAVE"})
table.insert(data, {query={"get", "lost"}, res="I'm staying where I want to!"})
table.insert(data, {query={"leave", "your"}, res="I'm keeping it with me!"})

table.insert(data, {query={"borrow", "i"}, res="No!", anim="No"})
table.insert(data, {query={"lend", "me"}, res="No!", anim="No"})

table.insert(data, {query={"how", "i", "earn"}, res="Perform your duty, or pick up trash from the street. "})
table.insert(data, {query={"how", "i", "buy"}, res="Just take items from the shelves and payment will be automatic. "})
table.insert(data, {query={"how", "i", "pay"}, res="Just take items from the shelves and payment will be automatic. "})
table.insert(data, {query={"spare", "change"}, res="You need to earn money yourself. "})

table.insert(data, {query={"come", "me"}, res="Okay.", anim="Yes", action="JOIN"})
table.insert(data, {query={"join", "me"}, res="Okay.", anim="Yes", action="JOIN"})
table.insert(data, {query={"follow", "me"}, res="Okay.", anim="Yes", action="JOIN"})
table.insert(data, {query={"go", "with", "me"}, res="Okay.", anim="Yes", action="JOIN"})

table.insert(data, {query={"dance"}, res="Sure!", anim="DanceRaiseTheRoof", all=true})
table.insert(data, {query={"clap", "hands"}, res="Sure!", anim="Clap", all=true})

table.insert(data, {query={"hands", "up"}, res="Ok!", anim="Surrender", all=true})
table.insert(data, {query={"robbery"}, res="Ok!", anim="Surrender", all=true})

table.insert(data, {query={"do", "you", "have"}, res="Sorry, I don't.", anim="No"})
table.insert(data, {query={"have", "you", "got"}, res="Sorry, I don't.", anim="No"})
table.insert(data, {query={"a", "you", "got"}, res="Sorry, I don't.", anim="No"})

table.insert(data, {query={"my", "home"}, res="It is my home now."})
table.insert(data, {query={"my", "house"}, res="It is my home now."})

table.insert(data, {query={"shut", "up"}, res="I won't'.", anim="No"})

table.insert(data, {query={"sorry"}, res="I forgive you.", action="RELAX"})
table.insert(data, {query={"excuse", "me"}, res="I forgive you.", action="RELAX"})

-- romantic offers
table.insert(data, {query={"sex"}, res="I'm not interested'.", anim="No"})
table.insert(data, {query={"take", "bed"}, res="I'm not interested.", anim="No"})
table.insert(data, {query={"go", "bed"}, res="I'm not interested.", anim="No"})
table.insert(data, {query={"sleep", "me"}, res="I'm not interested!.", anim="No"})
table.insert(data, {query={"dinner", "me"}, res="Sure! Let's go!", anim="Yes", action="JOIN"})
table.insert(data, {query={"lunch", "me"}, res="Sure! Let's go!", anim="Yes", action="JOIN"})
table.insert(data, {query={"take", "drink"}, res="Sure! Let's go!", anim="Clap", action="JOIN"})
table.insert(data, {query={"have", "a", "drink"}, res="Sure! Let's go!", anim="Clap", action="JOIN"})
table.insert(data, {query={"buy", "drink"}, res="Sure! Let's go!", anim="Clap", action="JOIN"})
table.insert(data, {query={"take", "coffee"}, res="Sure! Let's go!", anim="Yes", action="JOIN"})
table.insert(data, {query={"buy", "coffee"}, res="Sure! Let's go!", anim="Yes", action="JOIN"})

-- cover you eyes
table.insert(data, {query={"will", "shoot"}, res="F**k off!", action="HOSTILE"})
table.insert(data, {query={"will", "kill"}, res="F**k off!", action="HOSTILE"})
table.insert(data, {query={"will", "hit"}, res="F**k off!", action="HOSTILE"})
table.insert(data, {query={"suck"}, res="F**k off!", action="HOSTILE"})
table.insert(data, {query={"fag"}, res="F**k off!", action="HOSTILE"})
table.insert(data, {query={"fuck"}, res="F**k you!", action="HOSTILE"})
table.insert(data, {query={"dick"}, res="Pervert!", action="HOSTILE"})
table.insert(data, {query={"pussy"}, res="Pervert!", action="HOSTILE"})
table.insert(data, {query={"undress"}, res="Pervert!", action="HOSTILE"})
table.insert(data, {query={"ass"}, res="Cursing is the devil's speech."})
table.insert(data, {query={"bitch"}, res="F**k you!", action="HOSTILE"})

-- fallbacks to say something very generic
table.insert(data, {query={"you", "are"}, res="Maybe I am"})
table.insert(data, {query={"gunshots"}, res="Must be the military?"})
table.insert(data, {query={"weather"}, res="%RAIN. %SNOW"})
table.insert(data, {query={"how", "much"}, res="A lot."})

BWOChat = {}

BWOChat.Say = function(chatMessage)

    local getMood = function()
        if BWOScheduler.SymptomLevel == 0 then
            return "I'm great! Maybe a little stressed lately..."
        elseif BWOScheduler.SymptomLevel == 1 then
            return "I'm doing fine.. just a slight headache..."
        elseif BWOScheduler.SymptomLevel == 2 then
            return "Not so well honestly, I have terrible cough..."
        elseif BWOScheduler.SymptomLevel >= 3 then
            return "Oh I'm really sick!"
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

    local player = getSpecificPlayer(0)
    local color = player:getSpeakColour()
    player:addLineChatElement(chatMessage, color:getR(), color:getG(), color:getB())

	for k, v in pairs(data) do
        local query = v.query
        
        local allMatch = true
        for _, word in pairs(v.query) do
            if not chatMessage:lower():hasword(word) then
                allMatch = false
                break
            end
        end
        
        if allMatch then
            local player = getSpecificPlayer(0)
            local target = BanditUtils.GetClosestBanditLocationProgram(player, {"Walker", "Runner", "Inhabitant", "Active", "Babe"})
            if target.dist < 8 then
                local bandit = BanditZombie.GetInstanceById(target.id)
                local brain = BanditBrain.Get(bandit)
                local gametime = getGameTime()
                local cm = getWorld():getClimateManager()

                local city = getCity(player) or "unknown location"
                local season = cm:getSeasonName()
                local rain = cm:isRaining() and "It's raining" or "It's not raining"
                local snow = cm:isSnowing() and "It's snowing" or "It's not snowing"
                local intrusion = isIntrusion(bandit) and "NOT welcome" or "very welcome"
                local temperature = math.floor(cm:getTemperature())
                local mood = getMood()

                Bandit.ClearTasks(bandit)

                local anim = BanditUtils.Choice({"Talk1", "Talk2", "Talk3", "Talk4", "Talk5"})
                if v.anim then
                    anim = v.anim
                end

                local colors = {r=0, g=1, b=0}
                local recognized = true
                if v.action then
                    if v.action == "HOSTILE" then
                        Bandit.SetProgram(bandit, "Bandit", {})
                        Bandit.SetHostile(bandit, true)
                        colors = {r=1, g=0, b=0}
                    elseif v.action == "JOIN" then
                        Bandit.SetProgram(bandit, "Babe", {})
                        Bandit.SetHostile(bandit, false)
                        colors = {r=0, g=1, b=0}
                    elseif v.action == "RELAX" and brain.program.name == "Active" then
                        Bandit.SetProgram(bandit, "Walker", {})
                        Bandit.SetHostile(bandit, false)
                        colors = {r=0, g=1, b=0}
                    elseif v.action == "LEAVE" and brain.program.name == "Babe" then
                        Bandit.SetProgram(bandit, "Walker", {})
                        Bandit.SetHostile(bandit, false)
                        colors = {r=0, g=1, b=0}
                    else
                        recognized = false
                    end
                else
                    local task = {action="TimeEvent", anim=anim, x=player:getX(), y=player:getY(), time=200}
                    Bandit.AddTask(bandit, task)
                end

                if recognized then
                    local res = v.res

                    -- interpolate vars
                    res = res:replace("%NAME", brain.fullname)
                    res = res:replace("%HOUR", gametime:getHour())
                    res = res:replace("%MINUTE", gametime:getMinutes())
                    res = res:replace("%CITY", city)
                    res = res:replace("%RAIN", rain)
                    res = res:replace("%SNOW", snow)
                    res = res:replace("%SEASON", season)
                    res = res:replace("%TEMPERATURE", temperature)
                    res = res:replace("%INTRUSION", intrusion)
                    res = res:replace("%MOOD", mood)
                    bandit:addLineChatElement(res, colors.r, colors.g, colors.b)
                end

                break
            end
        end
    end
end

-- Events.OnAddMessage.Add(OnAddMessage)

local function onKeyPressed(keynum)
    if keynum == Keyboard.KEY_T then
        print ("T pressed")
        local ui = BWOChatPanel:new(0, 0, 300, 200, getSpecificPlayer(0))
        ui:initialise()
        ui:addToUIManager()
    end
end

Events.OnKeyPressed.Add(onKeyPressed)