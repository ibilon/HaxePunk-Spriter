package com.haxepunk.spriter;

class Animation
{
	public var id : Int;
	public var name : String;
    public var length : Int;
    public var looping : Bool;
    public var mainlineKeys : Array<MainlineKey>; // <key> tags within a single <mainline> tag
    public var timelines : Array<Timeline>; // <timeline> tags
	
	public function new (fast:haxe.xml.Fast)
	{
		mainlineKeys = new Array<MainlineKey>();
		timelines = new Array<Timeline>();
		
		id = Std.parseInt(fast.att.id);
		name = fast.att.name;
		length = Std.parseInt(fast.att.length);
		looping = fast.has.looping ? (fast.att.looping == "true") : true;
		
		for (mk in fast.node.mainline.nodes.key)
		{
			mainlineKeys.push(new MainlineKey(mk));
		}
		
		for (t in fast.nodes.timeline)
		{
			timelines.push(new Timeline(t));
		}
	}
}
