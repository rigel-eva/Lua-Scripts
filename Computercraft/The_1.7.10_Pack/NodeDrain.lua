redstone_side="bottom"
redstone_input="front"
node=peripheral.wrap("top")
node_aspects=node.getAspects()
--The ONLY REASON WHY THIS FUNCTION IS HERE IS BECAUSE node.getAspectsSum() is indexed by a capitalized Name, and node.getAspects() returns lowercased ...
function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end
function node_recovery(waitTime)
	--Function: node_recovery
	--Purpose: make the program wait until the node has completly recovered.
	--Parameters: waitTime - number of ticks until any lost Vis is considered lost.
	tickCount=0--God Damnit we start our indexces at ZERO!
	currentMax=node_aspects.getAspectsSum()
	while tickCount<waitTime and not node == nil do--Check If there still is a node, and that we haven't surpassed our waitTime
		local i=1
		while node_aspects[i] not nil do
			local aspectCount=node.getAspectsSum(node_aspects[i])
			if(aspectCount == nil) then
				--remove the aspect
				i=i-1--keep i as it was
			else if (node.getAspectsSum(node_aspects[i])>currentMax[firstToUpper(node_aspects[i])]) then
				tickCount= -1;--Oh the node regenerated some Vis, Cool! let's reset the cooldown to -1(moves to zero after adding one)
			end
			i=i+1--Alright let's advance i by one.
		end
		tickCount= tickCount+1 --Advance our tickCount by one.
	end
	if node_aspects == nil then
		redstone.setOutput(redstone_side,false)--This is so the stabalizer on the bully node gets triggered once we finish the program.
		exit() --If there are no more node aspects, then we have done our job to the fullest extent.
	end
  node=peripheral.wrap("top")
end
while(not redstone.getInput(redstone_input) or not node == nil) do --As long as we don't recieve a button press, or the block we are checking for isn't nil ...
	node_aspects=node.getAspects()--get a list of the aspects
	startDrain=true--We want to default to true here ... because
 for i=1,table.getn(node_aspects) do
	 	startDrain=node.getAspectCount(node_aspects[i])>1 and startDrain--We are checking here on each of the aspects if it's greater than one (if all of them are we are good!)
 end
 if startDrain then--So then, let's start this party!
   redstone.setOutput(redstone_side,true)
 else--Right need to write a seperate function to check when we are good to start draining the node again.
   redstone.setOutput(redstone_side,false)
	 node_recovery(500)
 end
 os.sleep(1)--So the redstone triggers can go thru
 	node=peripheral.wrap("top")--Refreshing the wraping just so we can check if we still have a peripheral
end
redstone.setOutput(redstone_side,false)--This is so the stabalizer on the bully node gets triggered once we finish the program.
