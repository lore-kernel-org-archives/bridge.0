Date: Thu, 29 Jul 2004 00:27:23 +0200
From: Santiago Garcia Mantinan <manty@manty.net>
Subject: Re: [Bridge] Assertion failed in bridge code on 2.4.27-rc3
Message-ID: <20040728222722.GA2688@man.manty.net>
References: <20040728195957.GA2621@man.manty.net>
	<20040728132128.22bed751@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728132128.22bed751@dell_ss3.pdx.osdl.net>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org

> What is the command sequence you use to bring up the bridge?

This doesn't matter, I have tested this more, and it seems that any
execution of "brctl" even without any argument, which only shows the help,
will generate at least two of these "RTNL: assertion failed at br_ioctl.c(244)"
messages, doesn't matter if you have a bridge defined or not.

> What version of the brctl command?
0.9.5

I can test with newer versions of you want, but that is what comes with
Debian stable right now and it's what the machine has.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
