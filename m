content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Date: Mon, 12 Jul 2004 11:34:26 -0500
Message-ID: <30F5491FC3F68047925F0F51C190BCD701571018@ACDFWMAIL1.acd.de.ittind.com>
From: "Saxer, John -ACDSD" <John.Saxer@itt.com>
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Packets go through the bridge one-way only
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org


Hello all,

I am new to this list, and to bridging, and am having a problem. Perhaps I just don't understand something, am setting it up incorrectly, or just plain missed something, but I could use some help.

I am using 2 Redhat 7.3 systems to work out the configuration issues for a bridge, before transferring all my accumulated knowledge to an embedded system. One of the systems has only a wireless card, while the other has a wireless card and a wired interface. The plan is to use the 2nd machine to allow the first to access the wired world.

I followed the directions in setting up a bridge on the 2nd machine, bridging the wireless card and the wired interface. However, even something as simple as ping on the first card does not work. I run TCPDUMP on the 2nd machine, and it reports the "apr-whohas" packets arriving, but either they then don't go out, or the responses get lost, or something.

I can ping the 2nd machine from the first, using the bridge IP address, just fine. Even telnet works. But only addressing the 2nd machine - everything else is a black hole.

Any ideas? What did I do wrong?

Thanks,

John Saxer
ITT Industries, San Diego

************************************
This email and any files transmitted with it are proprietary and intended solely for the use of the individual or entity to whom they are addressed. If you have received this email
in error please notify the sender. Please note that any views or opinions presented in this email are solely those of the author and do not necessarily represent those of ITT Industries, Inc.
The recipient should check this email and any attachments for the presence of viruses. ITT Industries accepts no liability for any damage caused by any virus transmitted by this
email.
************************************

