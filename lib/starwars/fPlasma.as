package lib.starwars {
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.display.DisplayObject;
	
	
	public class fPlasma extends MovieClip {

		public var vx:Number = 0;
		public var vy:Number = 0;
		public var speed:Number = 8;
		public var stageRef:Stage;
		public var target:hitBox;


		
		
		public function fPlasma(stageRef:Stage, x:Number, y:Number, fighterRotation:Number, target:hitBox):void {
			// constructor code
			this.stageRef = stageRef;
			this.target = target;
			this.rotation = fighterRotation;

			vx += Math.cos(degreesToRadians(fighterRotation)) * speed;
			vy -= Math.sin(degreesToRadians(fighterRotation)) * speed;

			this.x = x;
			this.y = y;

			addEventListener(Event.ENTER_FRAME, loop, false, 0 , true);
		}
		public function loop(e:Event):void
		{
			x += vx;
			y -= vy;
			//destroys bullet if it goes off stage
			if(x > 1000 || y > 600 || x < 0 || y < 0)//stage boundaries
			{
				destroy();
			}
			if(this.hitTestObject(target))
			{
				trace("shipHit");
				target.takeHit();
				stageRef.addChild(new plasmaExplosion(stageRef, x, y));
				destroy();
			}
		}
		public function destroy():void{
			if(parent)
			{
				parent.removeChild(this);
			}
			removeEventListener(Event.ENTER_FRAME, loop);
			trace("particle destroyed");
		}

		public function degreesToRadians(degrees:Number) : Number
		{
			return degrees * Math.PI / 180;
		}
	}
}
	
