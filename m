Date: Sat, 5 Feb 2005 13:51:18 +0100
From: Santiago Garcia Mantinan <bridge@manty.net>
Subject: Re: [Bridge] recent 2.6 kernels hang on bridge shutdown - solved
Message-ID: <20050205125118.GA2761@man.manty.net>
References: <20050202175652.GA1531@stilzchen.informatik.tu-chemnitz.de>
	<20050203115407.5e7fc195@dxpl.pdx.osdl.net>
	<20050204223204.GA15585@stilzchen.informatik.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050204223204.GA15585@stilzchen.informatik.tu-chemnitz.de>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Mirko Parthey <mirko.parthey@informatik.tu-chemnitz.de>
Cc: bridge@lists.osdl.org, Stephen Hemminger <shemminger@osdl.org>

Hi!

> > Are you running IPV6? if so it is most likely related to IPV6.
> Yes, indeed.
> Since I currently don't need IPv6, I disabled it - problem solved.

This is not related to IPv6 at all, several people have reported it to me
and don't run IPv6 or have support for it in their kernels.

However, it is not easy to reproduce this problem, it happens to me only on
one of my machines, and only sometimes, and it doesn't happen on any of my
other bridges, I've been trying to get the steps to reproduce it but I'm not
able :-(

Mirko, if you can do more tests, maybe you find that your machine it still
suffers from this.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
