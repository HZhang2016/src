/*
 * commands for device's message routine
 */
#define MESG_HOME			0
#define MESG_OFF 			1
#define MESG_ON 			2
#define MESG_ERASE			3
#define MESG_HIGHLIGHT_ON		4
#define MESG_HIGHLIGHT_OFF 		5
#define MESG_READY 			6
#define MESG_DONE			7
#define MESG_TEXT			8
#define MESG_MESSAGE			9

/*
 *  MESG_HOME: home the cursor. This does not have to be the terminal's
 *	"home" position. Anyplace likely to be out of the way of the graph
 *	will do.  Leave room for the prompt's text which will surely follow
 *	immediately on this command's heels. If you handle all prompting
 *	yourself, ignore this command.
 *
 *  MESG_OFF: turn the message (text screen) off, leaving the text intact
 *	but invisible. If this is not possible, this should be interpreted
 *	as an erase. If the text and graphics screen are completely
 *	separate, ignore this command.
 *
 *  MESG_ON: turn the message (text screen) back on again if you turned it off.
 *	If you erased it, this may not be possible. If so, just forget about it.
 *
 *  MESG_ERASE: erase the text screen. Do this even if you know how to just
 *	make the text invisible; we want to use the text screen for
 *	prompting and need to leave it on. If you handle all prompting
 *	yourself, ignore this command.
 *
 *  MESG_HIGHLIGHT_ON: after "READY", means that the following message is
 *	a prompt generated by the vplot device-independent code. Normally
 *	you will want to indicate to the user that this text is a prompt by
 *	going into some sort of "highlighted" text mode. Some devices may
 *	want to handle prompting by themselves in dev.interact in a
 *	device-dependent way, however, and they can take this as a signal
 *	to ignore the following text.
 *
 *  MESG_HIGHLIGHT_OFF: get out of "prompt mode".
 *
 *  MESG_READY: get ready to print a message.
 *
 *  MESG_DONE: we're through printing the message.
 *
 *  MESG_TEXT: print out the given text.
 *
 *  MESG_MESSAGE: after "READY", means that the following message is
 *	from the "VP_MESSAGE" vplot command, and so might want to be
 *	treated differently from other messages such as errors or prompts.
 */

/*
 * The modes MESG_READY, MESG_TEXT, MESG_HIGHLIGHT_OFF,
 * MESG_HIGHLIGHT_ON, MESG_DONE, and MESG_MESSAGE can only occur
 * in the following orders:
 *
 * READY, [MESSAGE optionally], TEXT, DONE
 *
 * For a prompt:
 * READY, HIGHLIGHT_ON, TEXT, DONE, dev.interact,
 * HIGHLIGHT_OFF, [READY, TEXT (carriage return - line feed),] DONE
 *
 * The other modes can occur at any time in any order!
 */

#define CRLF			"\015\012"

/*
 * Use CRLF instead of \n when you are putting a newline on the end of
 * a message, since the output may be (probably is, in fact) in raw mode.
 * Note that "error" puts this on FOR you.
 */
