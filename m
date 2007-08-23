Date: Thu, 23 Aug 2007 11:23:21 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] bridge problem when one interface is in blocking mode
Message-ID: <20070823112321.41991a9e@freepuppy.rosehill.hemminger.net>
In-Reply-To: <481378.2503.qm@web51911.mail.re2.yahoo.com>
References: <20070823100811.03e68021@freepuppy.rosehill.hemminger.net>
	<481378.2503.qm@web51911.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: wang dengyi <dy_wang@yahoo.com>
Cc: bridge@lists.linux-foundation.org

On Thu, 23 Aug 2007 11:17:44 -0700 (PDT)
wang dengyi <dy_wang@yahoo.com> wrote:

> Hi Stephen,
> 
> Here is the detail
> kernel version: 2.6.14
> architecture: PPC
> ehternet: from the processor mpc5200b
> wifi manufactor: Netgate 5004 MP, Atheros chipset
> wifi driver: madwifi 0.91
> WDS on wifi: enabled.
> 
> I guess it's an issue combined by ethernet driver/wifi
> driver and bridge. Is there anything you suspect that
> I can check? 
> 
> I believe the 2 actions: updating forwarding database
> when a stp package is received and delivering the
> package based on the forwarding database, are correct.
> I must miss something. For example, STP detection set
> an interface as blocking and remove it from the
> forwarding database? It's just my wild guess. 
> 
> By the way, I found Bartek reported the same issue on
> 2.6.11.12 and 2.6.13.2. Here is the link:
> https://lists.linux-foundation.org/pipermail/bridge/2005-October/004710.html
> He has 3 ethernet nic for each machine and his fix is
> to update the forwarding database only when the port
> is in learning or forwarding state.
>

There was a bug fix in later kernel (2.6.19) that causes the forwarding
database to be purged when STP decides not to use interface.
