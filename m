MIME-Version: 1.0
In-Reply-To: <4C2B97CC.8090007@riverviewtech.net>
References: <m2nbc9320b91004211748o5548f351z646076fab6744cca@mail.gmail.com>
	<20100422130919.70206765@nehalam>
	<AANLkTimPiriAOGpHHrAoEyFGuuyn1g8vFqW6Pimdz9CQ@mail.gmail.com>
	<4C2B97CC.8090007@riverviewtech.net>
Date: Thu, 1 Jul 2010 22:35:53 +0530
Message-ID: <AANLkTilE0uZQu6SjlkX1WaY32Ir9STQXT4kVNiSc4sCa@mail.gmail.com>
From: ratheesh k <ratheesh.ksz@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Bridge blocking network traffic
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Grant Taylor <gtaylor@riverviewtech.net>
Cc: bridge@lists.linux-foundation.org, Mail List - Netfilter <netfilter@vger.kernel.org>

On Thu, Jul 1, 2010 at 12:45 AM, Grant Taylor <gtaylor@riverviewtech.net> w=
rote:
> On 06/30/10 02:50, ratheesh k wrote:
>>
>> Why is it so ?
>
> Independent of your scenario, I'd say that binding the IP to the interfac=
e
> will make it more resilient to the individual interfaces going down. =A0A=
t
> least in such as all the interfaces would have to go down before the IP
> would go down.
>
>> I have a linux =A0 machine with interfaces eth0 (192.168.1.100 ) and eth=
1 (
>> 192.168.2.100 ) =A0. =A0 . I can connect =A0both eth0 an eth1 =A0to a ha=
rdware =A0HUB
>> . How could i do this in linux machine itself using brctl ?
>
> What netmask are your two IPs using, a /24? =A0If they are, then you are
> actually using two different subnets, and possibly doing something like a
> bridging router.
>
> Either way, you could bind both IPs to the bridge interface (classic IP
> alias or "ip add").
>
> With in the Xen context it may be because different things manage various
> parts of the Xen network differently and having the IP bound in the wrong
> place might cause a problem if the Xen hypervisor takes something down.
>
> There is also the fact that if a cable gets unplugged from an interface
> (that is a member of a bridge with at least one other member interface) s=
aid
> interface will go down but the bridge will stay up. =A0In doing so, the I=
P
> will go down b/c the interface that it was bound to would go down.
> =A0Conversely if the IP was bound to the bridge interface, the IP would s=
tay
> up and usable.
>
> There is also the possibility that if the IP is bound directly to the
> interface that filtering (EBTables / IPTables w/ Bridged Netfilter option=
)
> will not see the traffic.
>
> In some ways, it really depends on the specific use scenario.
>
>
>
> Grant. . . .
> --
> To unsubscribe from this list: send the line "unsubscribe netfilter" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



                 br0      0.0.0.0
                    |
                    |
  -----------------------------------------
  |                                        |
  |                                        |
eth0                                    eth1
192.168.1.100/24               192.168.2.100/24


brctl addbr br0
brctl  addif eth0
brctl  addif eth1
ifconfig br0  0.0.0.0 up

The problem was "default brouter policy is accept " . So packets are
coming to layer2  only .I applied the below command and every thing
seemed to work exactly like connecting eth0 and eth1 to hardware hub .

ebtables -t broute  -P BROUTING -j DROP


Thanks,
Ratheesh
