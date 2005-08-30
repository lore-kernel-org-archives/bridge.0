Date: Tue, 30 Aug 2005 13:43:54 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Question about VLANs, bridges and switches
Message-ID: <20050830134354.691045e0@dxpl.pdx.osdl.net>
In-Reply-To: <5.2.0.9.1.20050826173852.02ece300@mailhost.csse.uwa.edu.au>
References: <5.2.0.9.1.20050826173852.02ece300@mailhost.csse.uwa.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Ryan McConigley <ryan@csse.uwa.edu.au>
Cc: bridge@lists.osdl.org

On Fri, 26 Aug 2005 17:56:16 +0800
Ryan McConigley <ryan@csse.uwa.edu.au> wrote:

> 
> 	I have a question about bridges, vlans and switches.    We had been using 
> a bridge to provide filtering between our student labs and the main 
> network.  All the filtering does is check that a known IP matches a known 
> MAC address, this stops students plugging in laptops and stealing an IP 
> address.  (And yes, we know about the MAC spoofing issues too)  The 
> connection was nice and simple, basically:
> 
>         [Main switch]-----<bridge firewall>-------[Lab 
> Switch]
> 
> 	And it was working fine.  Then of course, earlier this year, we upgraded 
> our network and the guy who did it created vlans so now we're bridging from 
> Vlan_1 to Vlan_2 on seperate ports on the same switch.
> 
> 	That has apparently been working fine as well, but when one of the uni 
> network guys looked at it he freaked and started going on about the 
> problems of arp broadcasts and he was insisting we replace it immediately, 
> but of course, couldn't provide any suggestions as to how to replace 
> it.  Since we're in a university and things appeared to be working 
> normally, I did what seemed natural... I ignored him.  (Mainly because it 
> was the middle of semester and changing things then is bad)
> 
> 	Step forward a few months and here I am currently building two replacement 
> firewalls, so I thought I'd ask the list about problems with bridging vlans 
> on the same switch.

There are problems with some switches because they may not treat
VLAN's as real separate networks. The switch is really a bridge,
and if forwards broadcasts between VLAN's you will end up creating
a loop in your network:

	[Switch]  --->- VLAN1 ->- [ Bridge ]
                  ---<- VLAN2 -<-

And the broadcast will ping pong forever. Spanning Tree would help,
but the Switch may or may not do STP, and the Bridge needs to have STP
turned on.

