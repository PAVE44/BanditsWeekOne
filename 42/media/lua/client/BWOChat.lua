local data = {}

table.insert(data, {query={"hey"}, res="Hi!", anim="WaveHi"})
table.insert(data, {query={"hello"}, res="Hi!", anim="WaveHi"})
table.insert(data, {query={"hi"}, res="Hi!", anim="WaveHi"})
table.insert(data, {query={"good", "morning"}, res="Hi!", anim="WaveHi"})
table.insert(data, {query={"good", "evening"}, res="Hi!", anim="WaveHi"})
table.insert(data, {query={"bye"}, res="See you!", anim="WaveHi"})
table.insert(data, {query={"see", "you"}, res="Bye!", anim="WaveHi"})
table.insert(data, {query={"cu"}, res="Bye!", anim="WaveHi"})
table.insert(data, {query={"howdy"}, res="How do you do?"})
table.insert(data, {query={"how", "are", "you"}, res="I'm doing fine.. just a slight headache...", anim="PainHead"})

table.insert(data, {query={"what", "time"}, res="It's %HOUR:%MINUTE."})
table.insert(data, {query={"what", "your", "name"}, res="I'm %NAME."})
table.insert(data, {query={"what", "doing"}, res="I'm doing what I was programmed to."})

table.insert(data, {query={"where", "is"}, res="Sorry, I don't know where it is.", anim="No"})
table.insert(data, {query={"where", "are"}, res="Sorry, I don't know where they are.", anim="No"})

table.insert(data, {query={"nice", "meet"}, res="Nice to meet you too!"})
table.insert(data, {query={"nice", "meeting"}, res="Nice to meet you too!"})

table.insert(data, {query={"don't", "like", "your"}, res="That's too bad."})
table.insert(data, {query={"not", "like", "your"}, res="That's too bad"})

table.insert(data, {query={"like", "your"}, res="Thank you! You are very kind."})
table.insert(data, {query={"like", "my"}, res="Yes, I think I like it.", anim="Yes"})

table.insert(data, {query={"help", "me"}, res="You're on your own.", anim="Shrug"})
table.insert(data, {query={"help", "you"}, res="You are very kind, but I don't need help at the moment.", anim="No"})

table.insert(data, {query={"give", "me"}, res="Sorry, I can't give you that.", anim="Shrug"})
table.insert(data, {query={"give", "you"}, res="Thanks, but I don't need that.", anim="No"})

table.insert(data, {query={"need", "i"}, res="Sorry, I can't help you with that.", anim="No"})
table.insert(data, {query={"need", "you", "do"}, res="Thanks, but I don't need that.", anim="No"})

table.insert(data, {query={"seen", "zombie"}, res="Zombie? Are you mad?"})
table.insert(data, {query={"seen", "zombies"}, res="Zombie? Are you mad?"})
table.insert(data, {query={"saw", "zombie"}, res="Zombie? Are you mad?"})
table.insert(data, {query={"saw", "zombies"}, res="Zombie? Are you mad?"})
table.insert(data, {query={"you", "zombies"}, res="Zombie? You watched too many movies!"})
table.insert(data, {query={"seen", "party"}, res="I've heard one, they are very loud."})
table.insert(data, {query={"seen", "parties"}, res="I've heard one, they are very loud."})
table.insert(data, {query={"seen", "army"}, res="Yes. I don't know why they are here."})
table.insert(data, {query={"seen", "soldiers"}, res="Yes. I don't know why they are here."})

table.insert(data, {query={"help", "me"}, res="How can I help?"})
table.insert(data, {query={"help", "you"}, res="I think I'll be alright."})

table.insert(data, {query={"open", "door"}, res="We are closed!", anim="No"})
table.insert(data, {query={"open", "window"}, res="I'm not opening it.", anim="No"})

table.insert(data, {query={"leave", "you"}, res="I'm staying where I want to!"})
table.insert(data, {query={"leave", "me"}, res="I'm staying where I want to!"})
table.insert(data, {query={"get", "lost"}, res="I'm staying where I want to!"})
table.insert(data, {query={"leave", "your"}, res="I'm keeping it with me!"})

table.insert(data, {query={"borrow", "i"}, res="No!", anim="No"})
table.insert(data, {query={"lend", "me"}, res="No!", anim="No"})

table.insert(data, {query={"come", "me"}, res="I don't want to go with you.", anim="No"})
table.insert(data, {query={"join", "me"}, res="I don't want to go with you.", anim="No"})
table.insert(data, {query={"go", "with", "me"}, res="I don't want to go with you.", anim="No"})

table.insert(data, {query={"we", "die"}, res="I hope you are wrong."})

table.insert(data, {query={"you", "computer"}, res="No shit."})
table.insert(data, {query={"you", "stupid"}, res="So are you!"})
table.insert(data, {query={"you", "ugly"}, res="So are you!"})
table.insert(data, {query={"you", "dumb"}, res="You are not so bright yourself!"})
table.insert(data, {query={"you", "pretty"}, res="Thank you!"})
table.insert(data, {query={"you", "beautiful"}, res="Thank you!"})
table.insert(data, {query={"you", "bleeding"}, res="I will die but then I will respawn!"})
table.insert(data, {query={"you", "die"}, res="I hope you are wrong."})
table.insert(data, {query={"you", "are"}, res="Maybe I am"})

table.insert(data, {query={"dance"}, res="Sure!", anim="DanceRaiseTheRoof"})

table.insert(data, {query={"do", "you", "have"}, res="Sorry, I don't.", anim="No"})
table.insert(data, {query={"have", "you", "got"}, res="Sorry, I don't.", anim="No"})

-- romantic offers
table.insert(data, {query={"sex"}, res="I'm not interested'.", anim="No"})
table.insert(data, {query={"take", "bed"}, res="I'm not interested.", anim="No"})
table.insert(data, {query={"go", "bed"}, res="I'm not interested.", anim="No"})
table.insert(data, {query={"sleep", "me"}, res="I'm not interested!.", anim="No"})
table.insert(data, {query={"dinner", "me"}, res="I'm not interested!.", anim="No"})
table.insert(data, {query={"lunch", "me"}, res="I'm not interested!.", anim="No"})
table.insert(data, {query={"take", "drink"}, res="I'm not interested!.", anim="No"})
table.insert(data, {query={"buy", "drink"}, res="I'm not interested!.", anim="No"})
table.insert(data, {query={"take", "coffee"}, res="I'm not interested!.", anim="No"})
table.insert(data, {query={"buy", "coffee"}, res="I'm not interested!.", anim="No"})

-- cover you eyes
table.insert(data, {query={"suck"}, res="F**k off!", action="HOSTILE"})
table.insert(data, {query={"fuck"}, res="F**k you!", action="HOSTILE"})
table.insert(data, {query={"dick"}, res="Pervert!", action="HOSTILE"})
table.insert(data, {query={"pussy"}, res="Pervert!", action="HOSTILE"})
table.insert(data, {query={"undress"}, res="Pervert!", action="HOSTILE"})
table.insert(data, {query={"ass"}, res="Cursing is the devil's speech."})
table.insert(data, {query={"bitch"}, res="F**k you!", action="HOSTILE"})

local function OnAddMessage(chatMessage, tabId)

	for k, v in pairs(data) do
        local query = v.query
        
        local allMatch = true
        for _, word in pairs(v.query) do
            if not chatMessage::lower():embodies(word) then
                allMatch = false
                break
            end
        end
        
        if allMatch then
            local player = getPlayer()
            local target = BanditUtils.GetClosestBanditLocationProgram(player, {"Walker", "Runner", "Inhabitant"})
            if target.dist < 8 then
                local bandit = BanditZombie.GetInstanceById(target.id)
                local brain = BanditBrain.Get(bandit)
                local gametime = getGameTime()
                Bandit.ClearTasks(bandit)

                local anim = BanditUtils.Choice({"Talk1", "Talk2", "Talk3", "Talk4", "Talk5"})
                if v.anim then
                    anim = v.anim
                end

                local colors = {r=0, g=1, b=0}
                if v.action then
                    if v.action == "HOSTILE" then
                        Bandit.SetProgram(bandit, "Active", {})
                        Bandit.SetHostile(bandit, true)
                        colors = {r=1, g=0, b=0}
                    end
                else
                    local task = {action="TimeEvent", anim=anim, x=player:getX(), y=player:getY(), time=200}
                    Bandit.AddTask(bandit, task)
                end

                local res = v.res

                -- interpolate vars
                res:replace("%NAME", brain.fullname)
                res:replace("%HOUR", gametime:getHour())
                res:replace("%MINUTE", gametime:getMinutes())
                bandit:addLineChatElement(res, colors.r, colors.g, colors.b)
            end
        end
    end
end

Events.OnAddMessage.Add(OnAddMessage)
