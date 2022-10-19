package lib.starwars {
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	
	
	public class plasmaExplosion extends MovieClip {

		private var stageRef:Stage;
		
		
		public function plasmaExplosion(stageRef:Stage, x:Number, y:Number) {
			// constructor code
			this.stageRef = stageRef;
			this.x = x;
			this.y = y;
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}
		public function loop(e:Event){
			if(currentFrame == totalFrames)
			{
				removeSelf();
			}
		}
		public function removeSelf():void
		{
			removeEventListener(Event.ENTER_FRAME, loop);
			if(stageRef.contains(this))
			{
				stageRef.removeChild(this);
			}
		}
	}
	
}
