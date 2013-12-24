package com.haxepunk.spriter;

class Folder
{
	public var id : Int;
	public var name : String;
	public var files : Array<File>; // <file> tags
	
	public function new (fast:haxe.xml.Fast)
	{
		files = new Array<File>();
		
		id = Std.parseInt(fast.att.id);
		name = fast.has.name ? fast.att.name : "";
		
		for (f in fast.nodes.file)
		{
			files.push(new File(f));
		}
	}
}
