package lib.starwars {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import lib.starwars.Main;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.media.SoundTransform;
	
	public class StarDoc extends MovieClip {
		
		public var snd:Sound = new Sound();		
		public var channel:SoundChannel = new SoundChannel();
		
		public function StarDoc() 
		{
			var req:URLRequest = new URLRequest("StarWarsThemeSong.mp3");
			snd.load(req);
			trace(stage);
			createStartMenu();
		}

		private function createStartMenu():void
		{
			channel = snd.play();

			var startMenu:StartScreen = new StartScreen();

			addChild(startMenu);

			startMenu.startButton.addEventListener(MouseEvent.CLICK, startGameHandler);
			startMenu.storyButton.addEventListener(MouseEvent.CLICK, startStoryHandler);
		}
		private function startStoryHandler(evt:MouseEvent):void
		{
			var storyMenu:StoryScreen = new StoryScreen();
			addChild(storyMenu);
			removeChild(evt.currentTarget.parent);

			evt.currentTarget.removeEventListener(MouseEvent.CLICK, startStoryHandler);

			storyMenu.startBtn.addEventListener(MouseEvent.CLICK, startGameHandler);
		}
		private function startGameHandler(evt:MouseEvent):void
		{
			channel.stop();
			removeChild(evt.currentTarget.parent);

			evt.currentTarget.removeEventListener(MouseEvent.CLICK, startGameHandler);

			createGame();
		}
		public function createGame():void
		{
			var game:Main = new Main(stage);

			addChild(game);
		}
	}
}
