Date: Sun, 19 Jun 2005 00:02:17 +0200
From: Santiago Garcia Mantinan <bridge@manty.net>
Subject: Re: [Bridge] 2.6.12: iptables connection tracking broken on bridge
	interfaces
Message-ID: <20050618220217.GA3182@pul.manty.net>
References: <20050618191926.GA17671@pul.manty.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050618191926.GA17671@pul.manty.net>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

I'll reply myself on this so that others know what is going on...

I have selected patches from 2.6.12 that I thought could be related to this
issue, and I have finaly identified this patch...

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=b31e5b1bb53b99dfd5e890aa07e943aff114ae1c

as the patch causing the problem, I have reversed it on my kernel tree and
now the firewall is working again.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
