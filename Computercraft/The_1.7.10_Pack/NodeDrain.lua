redstone_side="bottom"
redstone_input="front"
while(not redstone.getInput(redstone_input)) do
	node=peripheral.wrap("top")
	node_aspects=node.getAspects()
	startDrain=true
 for i=1,table.getn(node_aspects) do
	 	startDrain=node.getAspectCount(node_aspects[i])>1 and startDrain
 end
 if startDrain then
   redstone.setOutput(redstone_side,true)
 else
   redstone.setOutput(redstone_side,false)
 end
 os.sleep(1)
end
redstone.setOutput(redstone_side,false)
