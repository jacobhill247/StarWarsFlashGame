package lib.starwars {
	
	//engine class
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import lib.starwars.Ship;
	import lib.starwars.fPlasma;
	import lib.starwars.Plasma;
	import lib.starwars.Fighter;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Main extends MovieClip {

		public var background:Sprite;
		public var enemy:Fighter;
		public var ourShip:Ship;
		public var asteroid:Asteroid;
		public var plasma:Plasma;
		public var particle:fPlasma;//particle is fPlasma
		public static var fighters:Array = new Array();
		public var fightersBox:Array = new Array();
		public var asteroids:Array = new Array();
		public var particles:Array = new Array();
		public var asteroidList:Array = new Array();
		public var particleList:Array = new Array();//enemy plasma Array
		public static var hitEnemiesList:Array = new Array();
		public var mHit:hitBox;
		public var score:ScoreHud;
		public var hitCount:Number = 0;
		public var myStage:Stage;
		static var scoreText:TextField;
		public var back:Background;
		public static var healthMeter:HealthMeter;
		public static var gameOverMenu:GameOverMenu;
		public var doc:StarDoc;
		
		public function Main(stageRef1:Stage):void {
			myStage = stageRef1;
			
			back = new Background(myStage);
			back.x = 900;
			back.y = myStage.stageHeight/3;
			myStage.addChild(back);

			//create ship and place it in center
			ourShip = new Ship(myStage);//(stage) is passing the stage to the player
			myStage.addChild(ourShip);
			//center it
			ourShip.x = myStage.stageWidth/2;
			ourShip.y = myStage.stageHeight/2;
			//making hitBox
			mHit = new hitBox(myStage, ourShip);
			myStage.addChild(mHit);
			mHit.x = ourShip.x;
			mHit.y = ourShip.y;
			mHit.addEventListener("hit", shipHit, false, 0, true);
			mHit.addEventListener("shipsHit", shipsHit, false, 0, true);

			//making scoreHud
			score = new ScoreHud(myStage);
			myStage.addChild(score);

			//make healthbar
			healthMeter = new HealthMeter(myStage);
			healthMeter.x = 30;
			healthMeter.y = 10;
			myStage.addChild(healthMeter);
			
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
			
		}
		
		public function loop(e:Event):void
		{
			//adding fighters and asteroids randomly
			if(Math.floor(Math.random()* 100) == 5)
			{
				var enemy:Fighter = new Fighter(stage, mHit);
				enemy.addEventListener(Event.REMOVED_FROM_STAGE, removeEnemy, false, 0, true);
 				fighters.push(enemy);
 				myStage.addChild(enemy);
 				enemy.addEventListener("killed", enemyKilled, false, 0, true);
			}
			if(ourShip.x > 500)
			{
				back.x = back.x - 0.1;
			}
			else if(ourShip.x < 500)
			{
				back.x = back.x + 0.1;
			}
			if(ourShip.y < 300)
			{
				back.y = back.y + 0.1;
			}
			else if(ourShip.y > 300)
			{
				back.y = back.y - 0.1;
			}
			if(healthMeter.bar.width == 0)
			{
				newGame();
			}
		}
		private function enemyKilled(e:Event):void
		{	
			trace('anything');
			score.updateKills(1);
			score.updateScore(64);
		}
		private function removeEnemy(e:Event)
		{
			fighters.splice(fighters.indexOf(e.currentTarget, 1));
		}
		private function removeParticle(e:Event)
		{
			particleList.splice(particleList.indexOf(e.currentTarget, 1));
		}
		public function shipHit(e:Event):void
		{
			hitCount++;
			trace(hitCount);
			ourShip.takeDamage(5);
		}
		public function shipsHit(e:Event):void
		{
			trace("Ship and Enemy Collided");
			ourShip.takeDamage(1);
		}
		public function newGame()
		{
			this.removeEventListener(Event.ENTER_FRAME, loop);
			gameOverMenu = new GameOverMenu();
			gameOverMenu.x = myStage.stageWidth/2;
			gameOverMenu.y = myStage.stageHeight/2;
			addChild(gameOverMenu);
			myStage.removeChild(ourShip);
			myStage.removeChild(back);
			myStage.removeChild(mHit);
		}
	}
}
