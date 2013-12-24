package com.haxepunk.spriter;

class Folder
{
	public var id : Int;
	public var name : String;
	public var files : Array<File>; // <file> tags
	
	public function new (folder:String, fast:haxe.xml.Fast)
	{
		files = new Array<File>();
		
		id = Std.parseInt(fast.att.id);
		name = fast.has.name ? fast.att.name : "";
		
		var path:String;
		
		if (name != "")
		{			
			path = folder + (name.charAt(name.length-1) == "/" ? name : name + "/");
		}
		else
			path = folder;
		
		for (f in fast.nodes.file)
		{
			files.push(new File(path, f));
		}
	}
}
