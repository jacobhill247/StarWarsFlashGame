
package lib.starwars {

	import flash.display.MovieClip;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.display.Stage;
	import lib.starwars.com.senocular.utils.KeyObject;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	public class Ship extends MovieClip
	{
		//passing through so it can be used in any function in class
		public var stageRef:Stage;
		//key:KeyObject creates an instance of KeyObject that can access the class KeyObject  
		public var key:KeyObject;
		public var speed:Number = .23;
		public var rotateSpeed:Number = 5;
		public var vx:Number = 0;
		public var vy:Number = 0;
		public var friction:Number = .93;
		public var max:Number = 1;
		public var target:hitEnemy;

		public var health:Number;
		public var maxHealth:Number;

		public var fireTimer:Timer;
		public var canFire:Boolean = true;

		public var hit:hitBox;

		
		public function Ship(stageRef:Stage)
		{
			trace(stage);
			trace(stageRef);
			//looking at this stage reference and looking for key presses on the stage
			//for keyObject class to work we need a reference to the stage
			this.stageRef = stageRef;
			key = new KeyObject(stageRef);

			this.hit = new hitBox(stageRef, this);

			//assign hitBox
			hit.x = this.x;
			hit.y = this.y;

			health = 100;
			maxHealth = 100;


			//add event listener to listen for presses everytime the frame redraws
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);

			fireTimer = new Timer(300, 1);
			fireTimer.addEventListener(TimerEvent.TIMER, fireTimerHandler, false, 0, true);
		}

		public function loop(e:Event):void
		{
			//vertical directions
			if (key.isDown(Keyboard.UP))
			{
				vy -= Math.sin(degreesToRadians(rotation)) * speed;
				vx -= Math.cos(degreesToRadians(rotation)) * speed;
			} else {
				vy *= friction;
				vx *= friction;
			}
 			//horizontal
			if (key.isDown(Keyboard.RIGHT))
				rotation += rotateSpeed;
			else if (key.isDown(Keyboard.LEFT))
				rotation -= rotateSpeed;
			//firing particle
			if(key.isDown(Keyboard.SPACE))
			{
				fireBullet();
			} 
			y += vy;
			x += vx;
 
			if (x > stageRef.stageWidth)
			{
				x = stageRef.stageWidth;
				vx = -vx;
			}

			else if (x < 0)
			{
				x = 0;
				vx = -vx;
			}
 
			if (y > stageRef.stageHeight)
			{
				y = stageRef.stageHeight;
				vy = -vy;
			}
			else if (y < 0)
			{
				y = 0;
				vy = -vy;
			}
		}

		public function fireBullet():void
		{
			if(canFire)
			{
				stage.addChild(new Plasma(x, y, rotation));
				canFire = false;
				fireTimer.start();
			}
		}
		public function takeDamage(d)
		{
			health -= d;
			if(health <= 0)
			{
				health = 0;
			}
			Main.healthMeter.bar.scaleX = health/maxHealth;
		}
		public function fireTimerHandler(e:TimerEvent):void
		{
			canFire = true;
		}
		public function degreesToRadians(degrees:Number) : Number
		{
			return degrees * Math.PI / 180;
		}
	}
}