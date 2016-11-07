package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import jp.shichiseki.exif.ExifLoader;
	
	
	/**
	 * @author marz
	 * @since 2016-11-7 下午4:56:08
	 */
	[SWF(width = "800", height = "600")]
	public class ImageRotation extends Sprite {
		//		[Embed(source = "assets/{280549AE-12BD-4C66-9076-FCC8AB3D1839}.jpg")]
		//		private var clazz:Class;
		
		private static const Orientations:Array = [1, 2, 3, 4, 5, 6, 7, 8];
		private static const Rotations:Array = [0, 0, 180, 180, 90, 90, -90, -90];
		
		public function ImageRotation() {
			super();
			//			var img:Bitmap = new clazz;
			//			addChild(img);
			
			var loader:ExifLoader = new ExifLoader();
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.load(new URLRequest("assets/{280549AE-12BD-4C66-9076-FCC8AB3D1839}.jpg"));
		}
		
		private function onComplete(event:Event):void {
			var loader:ExifLoader = event.target as ExifLoader;
			
			var Orientation:int = 1;
			
			if (loader.exif.ifds.primary["Orientation"] != null) {
				Orientation = loader.exif.ifds.primary["Orientation"]
			}
			
			var w:int = loader.exif.ifds.exif['PixelXDimension'];
			var h:int = loader.exif.ifds.exif['PixelYDimension'];
			
			var _scaleX:Number = 1.0 * stage.stageWidth / w;
			var _scaleY:Number = 1.0 * stage.stageWidth / h;
			var scale:Number = Math.min(_scaleX, _scaleY);
			
			w *= scale;
			h *= scale;
			
			if (Orientation > 2) {
				var rotate:Number = Rotations[Orientation - 1];
				//trace( "rotate : " + rotate );  
				loader.rotation = rotate;
				//				return;
				switch (Orientation) {
					case 5:
					case 6:
						loader.x = w;
						break;
					case 7:
					case 8:
						loader.y = h;
						break;
					case 3:
					case 4:
						loader.x = w;
						loader.y = h;
						break;
					default:
				}
			}
			addChild(loader);
			loader.scaleX = loader.scaleY = scale;
		}
	}
}
