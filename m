From: Ross Vandegrift <ross@kallisti.us>
Date: Tue, 28 Apr 2009 08:40:09 -0400
Message-ID: <20090428124009.GA26387@kallisti.us>
References: <db99f77d0904271413p1e807e52ue3d0ec41f62d7daf@mail.gmail.com>
	<2e59e6970904271436nd66745cv1c64ba792cf76d2f@mail.gmail.com>
	<db99f77d0904272344o43cec753t19a558ccaf3753ff@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db99f77d0904272344o43cec753t19a558ccaf3753ff@mail.gmail.com>
Subject: Re: [Bridge] Ubuntu: network bridging between wireless and wired
	connection fails
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jochen Hebbrecht <jochenhebbrecht@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Tue, Apr 28, 2009 at 08:44:50AM +0200, Jochen Hebbrecht wrote:
> Thnx Richard! I will try this when I'm back home.
> 
> So the configuration is good? I just need to:
> 
> $ ifconfig br0 up
> $ dhclient br0

That will work, but note that you configured the bridge in the Debian
interfaces file:

> >> iface br0 inet dhcp
> >> bridge_ports eth0 eth1

So now all you need to do is "ifup br0" to activate it and "ifdown
br0" to deactivate it.


-- 
Ross Vandegrift
ross@kallisti.us

"If the fight gets hot, the songs get hotter.  If the going gets tough,
the songs get tougher."
	--Woody Guthrie
