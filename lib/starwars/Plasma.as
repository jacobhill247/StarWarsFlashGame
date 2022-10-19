package lib.starwars {
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;

	
	
	public class Plasma extends MovieClip {

		public var vx:Number = 0;
		public var vy:Number = 0;
		public var speed:Number = 16;


		
		
		public function Plasma(x:Number,y:Number, shipRotation:Number):void {
			// constructor code
			this.rotation = shipRotation;
			vy -= Math.sin(degreesToRadians(shipRotation)) * speed;
			vx -= Math.cos(degreesToRadians(shipRotation)) * speed;

			this.x = x + vx * 2;
			this.y = y + vy * 2;

			addEventListener(Event.ENTER_FRAME, loop, false, 0 , true);
		}
		public function loop(e:Event):void
		{
			y += vy *2;
			x += vx * 2;
			//destroys bullet if it goes off stage
			if(x > 1000 || y > 600 || x < 0 || y < 0)//stage boundaries
			{
				destroy();
			}
			//if bullet is still on stage then
			else
			{
				//look at all children
				for(var i:int = stage.numChildren - 1; i >0; i--)
				{
					//if it is a fighter
					if(stage.getChildAt(i) is Fighter)
					{
						trace("fighter" + i);
						//make that instance name _fighter
						var _fighter:Fighter = Fighter(stage.getChildAt(i));
						//test for a hit against current _fighter
						if(this.hitTestObject(_fighter))
						{
							trace("target Hit!!!!");
							//if hit remove fighter
							//add var to fighter class called destroyed
							//_fighter.play();
							_fighter.destroyed = true;
							_fighter.takeHit();
							destroy();
							break;
						}
					}
				}
			}
		}
		public function destroy():void{
			if(parent)
			{
				parent.removeChild(this);
			}
			removeEventListener(Event.ENTER_FRAME, loop);
			trace("destroyed");
		}

		public function degreesToRadians(degrees:Number) : Number
		{
			return degrees * Math.PI / 180;
		}
	}
}
