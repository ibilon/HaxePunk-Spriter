package com.haxepunk.spriter;

class Map
{
	public var folder : Int;
    public var file : Int;
    public var targetFolder : Int;
    public var targetFile : Int;
	
	public function new (fast:haxe.xml.Fast)
	{		
		folder = Std.parseInt(fast.att.folder);
		file = Std.parseInt(fast.att.file);
		targetFolder = fast.has.target_folder ? Std.parseInt(fast.att.target_folder) : -1;
		targetFile = fast.has.target_file ? Std.parseInt(fast.att.target_file) : -1;
	}
}
