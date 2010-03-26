Message-ID: <4BAC7683.8020901@pandora.be>
Date: Fri, 26 Mar 2010 09:55:31 +0100
From: Bart De Schuymer <bdschuym@pandora.be>
MIME-Version: 1.0
References: <OFB9EFBBE7.11608167-ONC12576F1.005B0C79-C12576F1.005BBE51@transmode.se>	<2e59e6971003251003g34f45ccsf7feecbcb2d68cbf@mail.gmail.com>	<OF55692ECA.4BA1B52C-ONC12576F1.006BA68C-C12576F1.007010C8@transmode.se>	<4BABCF8A.3040701@free.fr>
	<OF073A246F.60E9C255-ONC12576F2.0028EAD8-C12576F2.002A871C@transmode.se>
In-Reply-To: <OF073A246F.60E9C255-ONC12576F2.0028EAD8-C12576F2.002A871C@transmode.se>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] IP address on physcial interface instead
	of	bridge	interface?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: bridge@lists.linux-foundation.org

Joakim Tjernlund wrote:
> Nicolas de Peslo=FCan <nicolas.2p.debian@free.fr> wrote on 2010/03/25 22:=
03:06:
>  =20
>> Joakim Tjernlund wrote:
>> [...]
>>    =20
>>> Sorry but I could not find that discussion but it doesn't sound as
>>> what I was after. Basically I want the eth0 I/F keeping its IP address
>>> and take over the roll of the br0 I/F when it has an IP address.
>>>      =20
>> Can you please try to explain the reason why you would like the bridge m=
embers
>> to have an IP,
>> instead of the br0 interface ?
>>    =20
>
> Sure, our app sometimes just uses eth0 as an normal eth I/F and in some
> configs eth0 needs to be bridged with other I/Fs. Moving the IP address f=
rom eth0 to
> the br0 I/F is painful once the system has booted. There are services alr=
eady running
> on eth0 then once a user decides he needs bridged system all services nee=
ds to be restarted.
>
>  =20
Hi,

Unfortunately this is impossible in the current bridge implementation
without temporarily losing connectivity because the ebtables BROUTING
chain isn't traversed while the bridge port is in learning state. But
with the patch below, the following scenario works without loss of
connectivity:
# (Suppose the bridge isn't configured yet)
ifconfig eth0 $IP
# (the routing table should be correct now, if not you need to do it
yourself)
# (the ebtables rules below will be effective once br0 is up)
# direct local IP traffic to eth0
ebtables -t broute -A BROUTING -p ipv4 -i eth0 --ip-dst $IP -j DROP
# direct arp replies for $MAC_OF_ETH0 to eth0
ebtables -t broute -A BROUTING -p arp -i eth0 -d $MAC_OF_ETH0 -j DROP
# direct arp requests for $IP to eth0
ebtables -t broute -A BROUTING -p arp -i eth0 --arp-ip-dst $IP -j DROP
brctl addbr br0
# make sure to bring br0 up before adding the interface
ifconfig br0 up
brctl addif br0 eth0

If you don't mind loss of connectivity while the bridge port is in
learning state, you don't need the patch.

Stephen, please consider applying the patch below.

cheers,
Bart


Process the brouting decision while the bridge port is in learning state.

Signed-off-by: Bart De Schuymer <bdschuym@pandora.be>

--- linux-2.6.33/net/bridge/br_input.c    2010-02-24 19:52:17.000000000
+0100
+++ linux-2.6.33-uml/net/bridge/br_input.c    2010-03-26
09:21:50.000000000 +0100
@@ -148,14 +148,13 @@ struct sk_buff *br_handle_frame(struct n
 forward:
     switch (p->state) {
     case BR_STATE_FORWARDING:
+    case BR_STATE_LEARNING:
         rhook =3D rcu_dereference(br_should_route_hook);
         if (rhook !=3D NULL) {
             if (rhook(skb))
                 return skb;
             dest =3D eth_hdr(skb)->h_dest;
         }
-        /* fall through */
-    case BR_STATE_LEARNING:
         if (!compare_ether_addr(p->br->dev->dev_addr, dest))
             skb->pkt_type =3D PACKET_HOST;
=20

--=20
Bart De Schuymer
www.artinalgorithms.be

