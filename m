MIME-Version: 1.0
In-Reply-To: <4C2CD722.4070905@plouf.fr.eu.org>
References: <m2nbc9320b91004211748o5548f351z646076fab6744cca@mail.gmail.com>
	<20100422130919.70206765@nehalam>
	<AANLkTimPiriAOGpHHrAoEyFGuuyn1g8vFqW6Pimdz9CQ@mail.gmail.com>
	<4C2B97CC.8090007@riverviewtech.net>
	<AANLkTilE0uZQu6SjlkX1WaY32Ir9STQXT4kVNiSc4sCa@mail.gmail.com>
	<4C2CD722.4070905@plouf.fr.eu.org>
Date: Thu, 1 Jul 2010 23:44:55 +0530
Message-ID: <AANLkTikPOw6lJX31LvOOqhaezcU3NJ4u8hdnVhFhGKmF@mail.gmail.com>
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
To: Pascal Hambourg <pascal.mail@plouf.fr.eu.org>
Cc: bridge@lists.linux-foundation.org, Netfilter mailing list <netfilter@vger.kernel.org>

>On Thu, Jul 1, 2010 11:27 PM, Pascal Hambourg <pascal.mail@plouf.fr.eu.org=
> wrote:
> I strongly doubt it. This rule forces routing of all packets instead of
> bridging, so IIUC it effectively totally disables bridging and you are
> back to two independent interfaces.

 I am sorry that i made a ambigous statement .
 what i meant is : We could add rules to BROUTING to selectively
bridge and route packets .Previously i was not able to ping eth0 or
eth1 from some other machine (in same subnet ) if i attach both to br0
. This got solved when we made default policy as DROP .


On Thu, Jul 1, 2010 at 11:27 PM, Pascal Hambourg
<pascal.mail@plouf.fr.eu.org> wrote:
> ratheesh k a =E9crit :
>>
>> brctl addbr br0
>> brctl =A0addif eth0
>> brctl =A0addif eth1
>> ifconfig br0 =A00.0.0.0 up
>>
>> The problem was "default brouter policy is accept " . So packets are
>> coming to layer2 =A0only .
>
> Indeed, by default (i.e. no brouting) packets received on a bridge port
> are intercepted by the bridge. This is the intended behaviour of a
> bridge, isn't it ? Thus a bridge port is not supposed to be assigned an
> IP address (or be used by any protocol), because the IP stack (or any
> other upper protocol layer) won't receive any packet directly from it
> but from the bridge interface (which should have the IP address).
>
>>I applied the below command and every thing
>> seemed to work exactly like connecting eth0 and eth1 to hardware hub .
>>
>> ebtables -t broute =A0-P BROUTING -j DROP
>
> I strongly doubt it. This rule forces routing of all packets instead of
> bridging, so IIUC it effectively totally disables bridging and you are
> back to two independent interfaces.
> --
> To unsubscribe from this list: send the line "unsubscribe netfilter" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
