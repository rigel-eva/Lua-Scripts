function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end
rednet.open("back")
monitor=peripheral.find("monitor")
node=peripheral.wrap("bottom")
while true do
	node_aspects=node.getAspects()
	for i=1, table.getn(node_aspects) do
		printString=string.format("%s - %i\n",firstToUpper(node_aspects[i]),node.getAspectCount(node_aspects[i]))
		monitor.write(printString)
	end
	os.sleep(1)
end
