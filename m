From: Ross Vandegrift <ross@kallisti.us>
Date: Tue, 28 Apr 2009 09:37:02 -0400
Message-ID: <20090428133702.GA26738@kallisti.us>
References: <db99f77d0904271413p1e807e52ue3d0ec41f62d7daf@mail.gmail.com>
	<2e59e6970904271436nd66745cv1c64ba792cf76d2f@mail.gmail.com>
	<db99f77d0904272344o43cec753t19a558ccaf3753ff@mail.gmail.com>
	<20090428124009.GA26387@kallisti.us>
	<db99f77d0904280552n5717cd86x6cc045a9f64e5a45@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db99f77d0904280552n5717cd86x6cc045a9f64e5a45@mail.gmail.com>
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

On Tue, Apr 28, 2009 at 02:52:10PM +0200, Jochen Hebbrecht wrote:
> 2009/4/28 Ross Vandegrift <ross@kallisti.us>:
> > On Tue, Apr 28, 2009 at 08:44:50AM +0200, Jochen Hebbrecht wrote:
> >> Thnx Richard! I will try this when I'm back home.
> >>
> >> So the configuration is good? I just need to:
> >>
> >> $ ifconfig br0 up
> >> $ dhclient br0
> >
> > That will work, but note that you configured the bridge in the Debian
> > interfaces file:
> >
> >> >> iface br0 inet dhcp
> >> >> bridge_ports eth0 eth1
> >
> > So now all you need to do is "ifup br0" to activate it and "ifdown
> > br0" to deactivate it.
> 
> Okay, thnx!
> 
> Just a small question, I think I need to configure eth0 and eth1 to
> manual? And not to DHCP?
> 
> Like this:
> ----------------------------------------
> auto eth0
> iface eth0 inet manual
> 
> auto eth1
> iface eth1 inet manual
> ----------------------------------------

Ah - I missed that.  Yes, you definitely want to set the member
interfaces to manual.
 
> The thing I don't understand then: if you execute a dhclient on br0,
> how does br0 know the configuration of eth1? Because there's a WPA2
> configuration on it. Will it use that settings too while bridging?

I'll be honest, I'm not sure - I've never done that with
wpa_supplicant and the debian tools.  You might need to activate
wpa_supplicant in the pre-up for br0.

Check out the manpage for interfaces - it may have more details.

-- 
Ross Vandegrift
ross@kallisti.us

"If the fight gets hot, the songs get hotter.  If the going gets tough,
the songs get tougher."
	--Woody Guthrie
