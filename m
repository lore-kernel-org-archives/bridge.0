Message-ID: <85FF18B4F608D6119F100002A5CE7B890D13BFE3@rocmx1.cs.myharris.net>
From: "Wise, John" <jwise03@harris.com>
Subject: RE: [Bridge] Brctl addif <bridge> ppp0
Date: Tue, 24 Feb 2004 08:22:20 -0500
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "'Eble, Dan'" <DanE@aiinet.com>, "Wise, John" <jwise03@harris.com>
Cc: bridge@osdl.org

Dan,

Thanks for the info. I did a Google groups search to see if I could find details
of your previous work, but didn't find it. The system I am working with is i386,
2.4.20-8 for kernel and 2.4.1-10 for pppd. Any details you can share about how
to progress will be greatly appreciated.

Regards,
John Wise
Harris Corporation - RF Communications Division
john.wise@harris.com
+1 585 242-3295




-----Original Message-----
From: Eble, Dan [mailto:DanE@aiinet.com] 
Sent: Tuesday, February 24, 2004 7:22 AM
To: 'Wise, John'
Cc: bridge@osdl.org
Subject: RE: [Bridge] Brctl addif <bridge> ppp0


Duh, I should have noticed this the first time.
You can't bridge ppp0 because Linux doesn't support BCP without patching the
kernel and pppd.

I posted such patches about 8 months ago.  There have been a few enhancements
and bug fixes since then.  Would you like me to put new ones together?  The
drawback is that they would apply to kernel 2.4.21-pre4
(PowerPC) and pppd 2.4.1, not the latest and greatest.  Would that work for you?

--
Dan Eble <dane@aiinet.com>  _____  .
Software Engineer          |  _  |/|
Applied Innovation Inc.    | |_| | |
http://www.aiinet.com/     |__/|_|_|

 -----Original Message-----
From: Wise, John [mailto:jwise03@harris.com] 
Sent: Monday, February 23, 2004 5:25 PM
To: 'Eble, Dan'
Subject: RE: [Bridge] Brctl addif <bridge> ppp0


Dan,

Thanks for the reply. Yes, here's the dialog

# brctl addbr bridge1
# brctl addif bridge1 eth0
# brctl addif bridge1 ppp0
br_add_interface: Invalid argument

Note - it doesn't seem to matter if I set any of the interfaces down or to
0.0.0.0. It appears as though it really doesn't like ppp interfaces. BTW, making
all ethernet bridges works just fine, so it's not like bridging itself doesn't
work.

Thanks again.
Regards, 
John Wise 
Harris Corporation - RF Communications Division 
john.wise@harris.com 
+1 585 242-3295


-----Original Message-----
From: Eble, Dan [mailto:DanE@aiinet.com] 
Sent: Monday, February 23, 2004 1:08 PM
To: 'Wise, John'
Subject: RE: [Bridge] Brctl addif <bridge> ppp0


You ran "brctl addbr bridge1" first, right?
-----Original Message-----
From: Wise, John [mailto:jwise03@harris.com] 
Sent: Monday, February 23, 2004 12:53 PM
To: 'bridge@osdl.org'
Subject: [Bridge] Brctl addif <bridge> ppp0


Greetings, 
I'm trying to do  ethernet (eth0 or eth1) to PPP (ppp0 or ppp1) bridging
using the Linux kernel facilities and brctl. The command in the subject
line, brctl addif bridge1 ppp0, returns an br_add_interface: Invalid
argument response. I've seen several others have run in to this via google
groups, but I didn't see any responses detailing the cause of the corrective
action. Please let me know  if what I am trying is unsupported and won't
work, or if there some kind of likely operator error that I'm locked in.
Linux install: Red Hat 9 
Brctl: installed from rpm on website 
Thanks and regards, 
John Wise 
john.wise@harris.com 
