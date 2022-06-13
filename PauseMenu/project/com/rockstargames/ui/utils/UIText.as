class com.rockstargames.ui.utils.UIText
{
	static var SIZE = 13;
	static var SIZE_GTAG = 18;
	function UIText()
	{
	}
	static function setSizedText(tf, str, autoShrink, autoSize, sizeOffset, sizeOverride)
	{
		tf.wordWrap = false;
		tf.multiline = false;
		tf.html = true;
		var __reg3 = 0;
		if (sizeOffset != undefined)
		{
			__reg3 = sizeOffset;
		}
		var __reg2 = com.rockstargames.ui.utils.UIText.SIZE - __reg3;
		if (sizeOverride != undefined)
		{
			__reg2 = sizeOverride;
		}
		tf.htmlText = "<FONT SIZE=\'" + __reg2 + "\'>" + str + "</FONT>";
		tf.verticalAlign = "center";
		if (autoShrink)
		{
			tf.textAutoSize = "shrink";
			return;
		}
		if (autoSize)
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