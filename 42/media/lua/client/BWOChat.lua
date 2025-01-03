llocal data = {}

table.insert(data, {query={"hello"}, res="Hi!"})
table.insert(data, {query={"hi"}, res="Hi!"})
table.insert(data, {query={"good", "morning"}, res="Hi!"})
table.insert(data, {query={"good", "evening"}, res="Hi!"})
table.insert(data, {query={"bye"}, res="See you!"})
table.insert(data, {query={"see", "you"}, res="Bye!"})
table.insert(data, {query={"cu"}, res="Bye!"})
table.insert(data, {query={"howdy"}, res="How do you do?"})
table.insert(data, {query={"how", "are", "you"}, res="I'm doing fine!"})

table.insert(data, {query={"what", "time"}, res="It's %HOUR:%MINUTE."})
table.insert(data, {query={"what", "your", "name"}, res="I'm %NAME."})
table.insert(data, {query={"what", "doing"}, res="I'm doing what I was programmed to."})

table.insert(data, {query={"where", "is"}, res="Sorry, I don't know where it is."})
table.insert(data, {query={"where", "are"}, res="Sorry, I don't know where they are."})

table.insert(data, {query={"nice", "meet"}, res="Nice to meet you too!"})
table.insert(data, {query={"nice", "meet"}, res="Nice to meet you too!"})

table.insert(data, {query={"don't", "like", "your"}, res="Tht's too bad."})
table.insert(data, {query={"not", "like", "your"}, res="That's too bad"})

table.insert(data, {query={"like", "your"}, res="Thank you! You are very kind."})
table.insert(data, {query={"like", "my"}, res="Yes, I think I like it."})

table.insert(data, {query={"help", "me"}, res="You're on your own."})
table.insert(data, {query={"help", "you"}, res="You are very kind, but I don't need help at the moment."})

table.insert(data, {query={"give", "me"}, res="Sorry, I can't give you that."})
table.insert(data, {query={"give", "you"}, res="Thanks, but I don't need that."})

table.insert(data, {query={"need", "i"}, res="Sorry, I can't help you with that."})
table.insert(data, {query={"need", "you", "do"}, res="Thanks, but I don't need that."})

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

table.insert(data, {query={"open", "door"}, res="We are closed!"})
table.insert(data, {query={"open", "window"}, res="I'm not opening it."})

table.insert(data, {query={"leave", "you"}, res="I'm staying where I want to!"})
table.insert(data, {query={"leave", "me"}, res="I'm staying where I want to!"})
table.insert(data, {query={"get", "lost"}, res="I'm staying where I want to!"})
table.insert(data, {query={"leave", "your"}, res="I'm keeping it with me!"})

table.insert(data, {query={"borrow", "i"}, res="No!"})
table.insert(data, {query={"lend", "me"}, res="No!"})

table.insert(data, {query={"come", "me"}, res="I don't want to go with you."})
table.insert(data, {query={"join", "me"}, res="I don't want to go with you."})
table.insert(data, {query={"go", "with", "me"}, res="I don't want to go with you."})

table.insert(data, {query={"die"}, res="I hope you are wrong."})

table.insert(data, {query={"you", "computer"}, res="No shit."})
table.insert(data, {query={"you", "stupid"}, res="So are you!"})
table.insert(data, {query={"you", "bleeding"}, res="I will die but then I will respawn!"})

-- cover you eyes
table.insert(data, {query={"sex"}, res="I'm not interested'."})
table.insert(data, {query={"take", "bed"}, res="I'm not interested."})
table.insert(data, {query={"go", "bed"}, res="I'm not interested."})
table.insert(data, {query={"sleep", "me"}, res="I'm not interested!."})
table.insert(data, {query={"suck"}, res="F**k off!"})
table.insert(data, {query={"fuck"}, res="F**k you!"})
table.insert(data, {query={"dick"}, res="Pervert!"})
table.insert(data, {query={"pussy"}, res="Pervert!"})
table.insert(data, {query={"undress"}, res="Pervert!"})
table.insert(data, {query={"ass"}, res="Cursing is the devil's speech."})
table.insert(data, {query={"bitch"}, res="F**k you!"})

local function OnAddMessage(chatMessage, tabId)
	for k, v in pairs(data) do
        local query = v.query
        
        local allMatch = true
        for _, word in pairs(v.query) do
            if not chatMessage:embodies(word) then
                allMatch = false
                break
            end
        end
        
        if allMatch then
            print (v.res)
            break
        end
    end
end

Events.OnAddMessage.Add(OnAddMessage)


