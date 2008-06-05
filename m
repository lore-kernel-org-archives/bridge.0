Message-ID: <1682.78.42.24.243.1212709630.squirrel@postamt.eit.uni-kl.de>
Date: Fri, 6 Jun 2008 01:47:10 +0200 (CEST)
From: "Faruk Keskin" <faruk@eit.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] VLAN-aware bridge : [PATCH] Add vlan id to bridge
 forward database
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: " <bridge@lists.linux-foundation.org>"@eit.uni-kl.de, "bridge@lists.linux-foundation.org"@eit.uni-kl.de

Hi all, hi Stephen,

seems like you've been discussing this issue fairly enough.

However, when you're saying selected vlan's this only works if you have an
exclusive bridge for each vlan.

Unless, the inter-vlan bridging is possible  with the current bridging
implementation (same mac address might also a problem). My understanding
is without a vlan aware fdb you'll need multiple bridges to have vlan
specific separate bridging domains enforced by the network topology. 
Having a single bridge is desirable because it will simplify dynamic VLAN 
management and ease up dynamic configuration, I would suppose.

Yes, the tag gets stripped off when a non-vlan device is forwarded to,
you're right. However, do I want non-vlan devices to get any vlan specific
data as such ? Again, I must properly configure the topology of the
bridges.

By topology I mean which devices (ethX, ethY.Z, ..) are attached to the
different bridges.

And yes, the extension I mentioned will be used to do some type of sniffing:
an userspace network management tool should among other stuff control the
VLAN configuration over a webinterface. With multiple bridges, the
sniffing  will also need some more attention as the might be added and
removed on runtime.

Anyway, thanks you Stephen for the reply.

Best Regards, Faruk

> On Thu, 5 Jun 2008 22:08:03 +0200 (CEST)
> "Faruk Keskin" <faruk@eit.uni-kl.de> wrote:
>
>> Hello everybody, hi Jaime,
>> I'm mailing to get more information about whether your patch
>> [PATCH] Add vlan id to bridge forward database
>> has been accepted so far.
>> I couldn't find the patched version yet - could you please tell me
where
>> I
>> can get the latest version of the patch or point out a reference to it
?
>
> This only applys to bridge that is blindly bridging without any
knowledge
> of vlan's. You can already handle the case of bridging selected vlan's
if you tell the kernel about them.
>
>> Has the vlan-aware bridge forwarding already been tested ?
>
> People do it all the time without patch by configuring the vlan's first
then bridging the vlan's.
>
>> And how about forwarding tagged packets ?
>> Until now, the bridge always stripped off the tag if present.
>
> Not if you bridge the vlan's
>
>> I'm currently thinking about extending the sk_buff data structure to
incorporate the vlan tag - to keep the VLAN information present when
exchanging packets from or to the bridge with the 8021q module and also
when a socket is bind to a interface (extending the sockaddr_ll struct
in
>> that case).
>> Do you think thats's a sane approach ?
>
> Only for other uses like sniffing
>
>




