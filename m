From: "Jeremy Jones" <jjones@djc.state.id.us>
Subject: RE: [Bridge] Bridging vlans...
Date: Thu, 25 Mar 2004 18:44:51 -0700
Message-ID: <011a01c412d3$f141fe90$f80210ac@djc.state.id.us>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <4062D6E8.6070804@tuxdriver.com>
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Now, with iptables, under the first scenario (creating 2 vlan interfaces per
physical interface, and bridging the vlan interfaces), can I safely DROP
everything to, from, or through eth0 & eth1?  That is, assuming I don't want
to forward any untagged frames.

So:

iptables -N only_tagged
iptables -A only_tagged -j LOG --log-prefix " untagged? "
iptables -A only_tagged -j DROP
iptables -A INPUT -i eth0 -j only_tagged
iptables -A INPUT -i eth1 -j only_tagged
iptables -A OUTPUT -i eth0 -j only_tagged
iptables -A OUTPUT -i eth1 -j only_tagged
iptables -A FORWARD -i eth0 -j only_tagged
iptables -A FORWARD -i eth1 -j only_tagged

Then do my more granular filtering on the vlan interfaces...

(guess this would be something to ask the vlan mailing list people -- but
what the heck, this list isn't terribly busy anyway)

I imagine I'll have to come up with a fairly complex matrix of --physdev-in,
--physdev-out, etc. combinations.  Yikes.

Jeremy

> -----Original Message-----
> From: bridge-bounces@lists.osdl.org 
> [mailto:bridge-bounces@lists.osdl.org] On Behalf Of John W. Linville
> Sent: Thursday, March 25, 2004 5:56 AM
> To: Jeremy Jones
> Cc: bridge@lists.osdl.org
> Subject: Re: [Bridge] Bridging vlans...
> 
> 
> Jeremy,
> 
> I have no specific experience with a situation like yours.  But, that 
> won't stop me from rendering an opinion... :-)
> 
> I, too, would lean toward the first at least partly for the 
> reason you 
> describe.  But, you should also consider untagged frames and 
> frames with 
> other VLAN IDs.  The second configuration should bridge all frames 
> (tagged or untagged), while the first will only be bridging 
> frames with 
> VLAN IDs of 4 or 51.  I'm not sure which is your desired 
> behaviour, but 
> I suspect it is the first configuration which you should prefer.
> 
> Hth...
> 
> John
> -- 



