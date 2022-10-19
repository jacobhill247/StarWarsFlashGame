package lib.starwars {
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.events.Event;
	
	
	public class ScoreHud extends MovieClip {
		
		private var stageRef:Stage;
		public var s_score:Number = 0;
		public var s_kills:Number = 0;
		
		public function ScoreHud(stageRef:Stage) {
			// constructor code
			this.stageRef = stageRef;

			kills.text = "0";
			score.text = "0";

			x = 10;
			y = stageRef.stageHeight - height - 10;
		}
		public function updateKills(value:Number):void
		{
			s_kills += value;
			kills.text = String(s_kills);
		}
		public function updateScore(value:Number):void
		{
			s_score += value;
			score.text = String(s_score);
		}
	}
	
}
