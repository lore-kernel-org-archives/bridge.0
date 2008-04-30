Message-ID: <4817D8A6.7080208@navigue.com>
Date: Tue, 29 Apr 2008 22:25:42 -0400
From: Jonathan Thibault <jonathan@navigue.com>
MIME-Version: 1.0
References: <4766a3d1.02ab100a.0be8.6fdc@mx.google.com>	<20071217085349.729e5c17@deepthought>	<20080128153914.GA5880@localhost>
	<20080428135754.2ae382b4@extreme>	<20080429082414.GA6475@localhost>
	<2e59e6970804291616l5e6685edw7299be09c0dd2384@mail.gmail.com>
In-Reply-To: <2e59e6970804291616l5e6685edw7299be09c0dd2384@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] Add vlan id to bridge forward database
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.osdl.org


I've been trying to get something like that to work for over a year now. 
  It mostly works, only the bridge will stop forwarding some arp replies 
coming in from a non-vlan interface to the trunk.  Bridge sees the 
replies but they never make it onto the wire.  If this was an STP (it's 
not enabled) issue, I assume the port would simply stop forwarding 
alltogether, not just ARP *replies*.

(yeah, I know I sound like a broken record to those who've been 
following my posts ;)

If there's any tests I can do to help on that front, just ask!  I would 
be happy just knowing *why* it doesn't work so far but I don't know the 
code well enough to figure out where the packets might get discarded.

Jonathan

richardvoigt@gmail.com wrote:

> 
> That's for bridging a trunk, but what about bridging between vlans:
> 
> vconfig add eth0 5
> vconfig add eth0 6
> brctl add br0 eth0.5
> brctl add br0 eth0.6
> 
> While you could combine the vlans, doing this allows you to force all
> traffic through packet filtering/traffic shaping/IDS.
> 
> Usually you wouldn't then see the same MAC on two different VLAN but
> you might on spanning tree packets.
