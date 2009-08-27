// if the containing frame is small, then offsetHeight is pretty good for all but ie/xp.
// ie/xp reports clientHeight == offsetHeight, but has a good scrollHeight
function setMainFrameHeight(id)
{
// run the script only if this window's name matches the id parameter
// this tells us that the iframe in parent by the name of 'id' is the one who spawned us
	if (typeof window.name != "undefined" && id != window.name) return;

	var obj = parent.document.getElementById(id);

	if (obj)
	{
// reset the scroll
		parent.window.scrollTo(0,0);

// to get a good reading from some browsers (ie?) set the height small
		obj.style.height="50px";

		var height = document.body.offsetHeight;
// here's the detection of ie/xp
		//if ((height == document.body.clientHeight) && (document.body.scrollHeight))
		//{
			height = document.body.scrollHeight;
		//}
// here we fudge to get a little bigger
		height = height + 50;
// no need to be smaller than...
		if (height < 200) height = 600;
		obj.style.height=height + "px";
	}
}


