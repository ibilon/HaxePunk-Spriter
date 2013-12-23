package com.haxepunk.spriter;

class Scml
{
	public function new (source:Xml)
	{
		_folders = new Array<Folder>();
		_entities = new Array<ScmlEntity>();
		
		var fast = new haxe.xml.Fast(source.firstElement());
		
		if (fast.att.scml_version != "1.0")
			trace("Warning, HaxePunk-Spriter may not be compatible with the scml version used in the file.");
		
		for (f in fast.nodes.folder)
		{
			_folders.push(new Folder(f));
		}
		
		for (e in fast.nodes.entity)
		{
			_entities.push(new ScmlEntity(e));
		}
	}
	
	private var _folders : Array<Folder>; // <folder> tags
	private var _entities : Array<ScmlEntity>; // <entity> tags
}
