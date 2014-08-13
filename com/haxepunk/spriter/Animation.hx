package com.haxepunk.spriter;

class Animation
{	
	public function new (parent:Scml, fast:haxe.xml.Fast)
	{
		mainlineKeys = new Array<MainlineKey>();
		timelines = new Array<Timeline>();
		
		_parent = parent;
		
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
			timelines.push(new Timeline(parent, t));
		}
	}
	
	@:isVar public var currentTime(get_currentTime, set_currentTime) : Int = 0;
	public inline function get_currentTime () : Int
	{
		return currentTime;
	}
	public inline function set_currentTime (value:Int) : Int
	{
		if (!looping)
		{
			value = Std.int(Math.min(value, length-1));
		}
		else
		{
			value %= length;
		}
		
		updateCharacter(mainlineKeyFromTime(value), value);
		
		return currentTime = value;
	}
	
	public var id : Int;
	public var name : String;
	public var length : Int;
	public var looping : Bool;
	public var mainlineKeys : Array<MainlineKey>; // <key> tags within a single <mainline> tag
	public var timelines : Array<Timeline>; // <timeline> tags
	
	private function updateCharacter (mainKey:MainlineKey, newTime:Int)
	{
		var transformedBoneKeys = new Array<BoneTimelineKey>();
		
		for(currentRef in mainKey.boneRefs)
		{
			var parentInfo : SpatialInfo;
			
			if (currentRef.parent >= 0)
			{
				parentInfo = transformedBoneKeys[currentRef.parent].info;
			}
			else
			{
				parentInfo = _parent.characterInfo();
			}

			var currentKey : BoneTimelineKey = cast keyFromRef(currentRef, newTime);
			currentKey.info = currentKey.info.unmapFromParent(parentInfo);
			transformedBoneKeys.push(currentKey);
		}

		var objectKeys = new Array<SpriteTimelineKey>();
		
		for(currentRef in mainKey.objectRefs)
		{
			var parentInfo : SpatialInfo;

			if (currentRef.parent >= 0)
			{
				parentInfo = transformedBoneKeys[currentRef.parent].info;
			}
			else
			{
				parentInfo = _parent.characterInfo();
			}

			var currentKey : SpriteTimelineKey = cast keyFromRef(currentRef, newTime);
			currentKey.info = currentKey.info.unmapFromParent(parentInfo);
			objectKeys.push(currentKey);
		}

		// <expose objectKeys to api users to retrieve AND replace objectKeys>

		for (k in objectKeys)
		{            
			k.paint();
		}
	}
	
	private function mainlineKeyFromTime (time:Int) : MainlineKey
	{
		var currentMainKey : Int = 0;
		
		for (m in 0...mainlineKeys.length)
		{
			if (mainlineKeys[m].time <= time)
			{
				currentMainKey = m;
			}
			
			if (mainlineKeys[m].time >= time)
			{
				break;
			}
		}
		
		return mainlineKeys[currentMainKey];
	}
	
	private function keyFromRef (ref:Ref, newTime:Int) : TimelineKey
	{
		var timeline = timelines[ref.timeline];
		var keyA = timeline.keys[ref.key];
		
		if (timeline.keys.length == 1)
		{
			return keyA;
		}
		
		var nextKeyIndex = ref.key + 1;
		
		if (nextKeyIndex >= timeline.keys.length)
		{
			if (looping)
			{
				nextKeyIndex = 0; 
			}
			else
			{
				return keyA;
			}
		}
  
		var keyB = timeline.keys[nextKeyIndex];
		var keyBTime = keyB.time;

		if (keyBTime < keyA.time)
		{
			keyBTime += length;
		}
		
		return keyA.interpolate(keyB, keyBTime, newTime);
	}
	
	private var _parent : Scml;
}
