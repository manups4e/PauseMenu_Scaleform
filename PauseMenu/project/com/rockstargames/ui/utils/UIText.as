class com.rockstargames.ui.utils.UIText
{
	static var SIZE = 13;
	static var SIZE_GTAG = 18;
	function UIText()
	{
	}
	static function setSizedText(tf, str, autoShrink, autoSize, font, sizeOffset, sizeOverride)
	{
		tf.wordWrap = false;
		tf.multiline = false;
		tf.html = true;
		var _loc3_ = 0;
		if (sizeOffset != undefined)
		{
			_loc3_ = sizeOffset;
		}
		var _loc2_ = com.rockstargames.ui.utils.UIText.SIZE - _loc3_;
		if (sizeOverride != undefined)
		{
			_loc2_ = sizeOverride;
		}
		var _font;
		if (font != undefined)
		{
			_font = font;
		}
		else
		{
			_font = "$Font2";

		}
		tf.htmlText = "<FONT FACE=\'" + _font + "\' SIZE=\'" + _loc2_ + "\'>" + str + "</FONT>";
		tf.verticalAlign = "center";
		if (autoShrink)
		{
			tf.textAutoSize = "shrink";
		}
		else if (autoSize)
		{
			tf.autoSize = true;
		}
	}
	static function setDescText(tf, str, font, autoSize)
	{
		tf.wordWrap = true;
		tf.multiline = true;
		tf.html = true;
		var _font;
		if (font != undefined)
		{
			_font = font;
		}
		else
		{
			_font = "$Font2";

		}
		tf.htmlText = "<FONT FACE=\'" + _font + "\' SIZE=\'" + com.rockstargames.ui.utils.UIText.SIZE + "\'>" + str + "</FONT>";
		if (autoSize != undefined && autoSize == true)
		{
			tf.autoSize = true;
		}
	}
}