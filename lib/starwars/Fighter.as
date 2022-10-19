package lib.starwars {
	
	import flash.display.MovieClip;

	import flash.events.Event;
	import flash.display.Stage;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	

	
	
	public class Fighter extends MovieClip {
	
		public var stageRef:Stage;
		public var vx:Number = Math.random();
		public var ax:Number = 0.01; //x acc
		public var target:hitBox;
		public var turnRate:Number = 10;
		public var shotSpeed:Number = 10;
		public var bulletCounter:int = Math.random() * bulletDelay;
		public var bulletDelay:int = 45;
		public var needsTarget:Boolean;
		public var shootTimer:Timer;
		public static var list:Array = [];

		public var intTimer:Timer;
		public var canFire1:Boolean = true;
		public var destroyed:Boolean = false;
		


		public function Fighter(stageRef:Stage, target:hitBox):void {
			stop();
			this.stageRef = stageRef;
			this.target = target;

			y = Math.random() * 400 + 50;
			x = -7;

			needsTarget = true;

			list.push(this);

			//make a new sound

			//timer to control when it shoots
			//initShootingInterval();

			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}

		public function loop(e:Event){
			
			shootTimer = new Timer(6000, 1);
			shootTimer.addEventListener(TimerEvent.TIMER, shootHandler);

			if(canFire1)
			{
				shoot();
			}
			//speed and accel
			vx += ax;
			x += vx;
			//handles rotation
			var targetAngle:Number = Math.atan2(target.y - y, target.x - x) * 180/Math.PI;

			if (Math.abs(targetAngle - rotation) < turnRate)
				{
					rotation = targetAngle;
				}
				else
				{
					if (targetAngle - rotation > 180)
					{
						targetAngle -= 360;
					}
					else if (targetAngle - rotation < -180)
					{
						targetAngle += 360;
					}
					
					if (targetAngle - rotation > 0)
					{
						rotation += turnRate;
					}
					else
					{
						rotation -= turnRate;
					}
				}
				//end rotation
			//begin remove if outside of stage
			if(x > stageRef.stageWidth)
			{
				removeSelf();
				trace("enemy removed");
			}	
			if(currentLabel == "destroyedComplete")
			{
				removeSelf();
			}
		}
		private function removeSelf():void{
			removeEventListener(Event.ENTER_FRAME, loop);
			if(stageRef.contains(this))
			{
				stageRef.removeChild(this);
			}
		}
		//end remove
		public function shootHandler(e:TimerEvent)
		{
			canFire1 = true;
		}
		public function shoot()
		{	
			if(canFire1)
			{
				var b = new fPlasma(stage, x, y, rotation, target);
				stage.addChild(b);
				trace('shoot');
				shootTimer.start();
				canFire1 = false;
			}
		}
		public function takeHit()
		{
			if(currentLabel!= "destroyed" && currentLabel != "destroyedComplete")
			{
				dispatchEvent(new Event("killed"));
				gotoAndPlay("destroyed");
			}
		}
	}
}