package lib.starwars {
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class hitBox extends MovieClip {
		
		public var stageRef:Stage;
		public var mShip:Ship;
		public var myStage:Stage;
		
		public function hitBox(stageRef:Stage, tarShip:Ship) {
			// constructor code
			myStage = stageRef;
			this.mShip = tarShip;

			addEventListener(Event.ENTER_FRAME, moveHit, false, 0, true);
			this.alpha = 0;
		}
		public function moveHit(e:Event):void
		{
			//mimics ship movement
			this.x = mShip.x;
			this.y = mShip.y;
			this.rotation = mShip.rotation;
			for(var i:int = myStage.numChildren - 1; i >0; i--)
				{
					//if it is a fighter
					if(myStage.getChildAt(i) is Fighter)
					{
						//trace("fighter" + i);
						//make that instance name _fighter
						var _fighter:Fighter = Fighter(myStage.getChildAt(i));
						//test for a hit against current _fighter
						if(this.hitTestObject(_fighter))
						{
							dispatchEvent(new Event("shipsHit"));
							trace("collision!");
							//if hit remove fighter
							//add var to fighter class called destroyed
							_fighter.destroyed = true;
							_fighter.takeHit();
							break;
						}
					}
				}

		}
		public function degreesToRadians(degrees:Number) : Number
		{
			return degrees * Math.PI / 180;
		}
		public function takeHit():void
		{
			dispatchEvent(new Event("hit"));
		}
	}
	
}
