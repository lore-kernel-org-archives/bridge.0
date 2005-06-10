From: "Tomo Ceferin" <tomo@activetools.si>
Subject: RE: [Bridge] Multicast
Date: Fri, 10 Jun 2005 10:39:16 +0200
Message-ID: <04b601c56d97$f50df8b0$825810ac@amon>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050609111733.79523dd0@unknown-215.office.pdx.osdl.net>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Two mistakes I made:
1) Bridge's set_multicast_list() is never called. Only devices that create
sk_buff-s are notified of changes to mc_list member in their net_device
structure.

2) Even if someone did call it, the information in mc_list is not sufficient
to use it in implementation of multicast.

I have learned however that by implementing IGMP snooping in bridge I could
learn enough to 'properly' support multicast. By monitoring multicast group
joins and leaves I should be able to tell to which ports a multicast frame
should be forwarded.

Tomo

> -----Original Message-----
> From: Stephen Hemminger [mailto:shemminger@osdl.org] 
> Sent: 9. junij 2005 20:18
> To: Tomo Ceferin
> Cc: bridge@lists.osdl.org
> Subject: Re: [Bridge] Multicast
> 
> 
> On Thu, 9 Jun 2005 16:33:44 +0200
> "Tomo Ceferin" <tomo@activetools.si> wrote:
> 
> > True. However, allow me to make two assumptions (true in our case):
> > 1) Bridge implements set_multicast_list() and uses it to learn 
> > multicast groups.
> > 2) IPv4 or IPv6 is attached to bridge - both provide IGMP snooping 
> > which in turn feeds bridge with multicast lists through 
> > set_multicast_list().
> > 
> > With both above assumptions true, bridge now has awareness of which 
> > ports belong to which multicast groups, hence removing the need to 
> > flood all ports.
> > 
> > Am I getting something wrong?
> 
> 1. Bridge does more than IP and so it knows nothing about IP 
> protocols. Many
>    times a bridge has no IP address at all.
> 
> 2. The bridge machine itself may not be listening the 
> multicast traffic but
>    needs to forward it.
> 
> 3. If you need to do some filtering of multicast, than use 
> netfilter (ebtables)
>    to restrict the traffic.
> 

