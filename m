Message-ID: <4A677703.4060507@free.fr>
Date: Wed, 22 Jul 2009 22:30:59 +0200
From: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
MIME-Version: 1.0
References: <4A6638A5.208@ipfire.org> <4A668C49.7080209@superduper.net>
	<4A66C14C.4090300@ipfire.org>
In-Reply-To: <4A66C14C.4090300@ipfire.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridging untagged and tagged VLANs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Michael Tremer <michael.tremer@ipfire.org>
Cc: bridge@lists.linux-foundation.org

Michael Tremer wrote:
> 
> In this mail on
> http://www.mail-archive.com/bridge@lists.osdl.org/msg01440.html
> there is the following sentence: "- Add native support for an untagged
> vlan.  Currently an untagged vlan can be implimented using ebtables or
 > similar."
> 
> Do you know how to do this?

For as far as I remember, the right way to do it with ebtables is :

brctl addbr br0
vconfig add eth0 30
brctl addif br0 eth0.30
brctl addif br0 eth0

ebtables --table broute -A BROUTING --protocol 802_1Q --vlan-id 30 
--jump DROP

Normally, a DROP target in BROUTING let the frame being ROUTED. The 
exact behavior  is "give it to upper layer", which is IP in most case. 
But, for a 802.1q tagged frame, the upper layer is "remove the 802.1q 
header and give it again to lower layer, on the right interface".

So this ebtables entry deny the bridge the opportunity to eat frames 
having a 802.1q vlan id = 30, giving the opportunity to the vlan stack 
to remove the vlan header and give it to eth0.30...

Not tested, because I don't have a bridge available right now, but this 
should work.

Of course, if you add several eth0.X interfaces to the bridge, you 
should add the corresponding ebtables entry. For very special 
configuration, --in-interface eth0 might be necessary too.

Just thinking about it, the --vlan-id 30 might be useless. Juste having 
--protocol 802_1Q might be enough for simple configuration. Just try and 
told us.

HTH.

	Nicolas.
