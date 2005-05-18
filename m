Subject: Re: [Bridge] Ip traffic not bridged
From: Bart De Schuymer <bdschuym@pandora.be>
In-Reply-To: <a7243e5e0505171432191b05ed@mail.gmail.com>
References: <a7243e5e0505171432191b05ed@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 18 May 2005 21:04:08 +0000
Message-Id: <1116450249.3841.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Shavian Shakes <shavian78@gmail.com>
Cc: bridge@lists.osdl.org

Op di, 17-05-2005 te 14:32 -0700, schreef Shavian Shakes:
> Hi, I am trying to set up a bridge that connects 2 user mode linux
> (UML) machines.  The bridge lets ARP traffic through, but not the IP
> traffic.
> 
>  linux:~ # brctl showmacs br0
> port no mac addr                is local?       ageing timer
>   2     00:ff:7d:86:06:47       yes                0.00
>   3     00:ff:bc:de:07:76       yes                0.00
>   2     fe:fd:c0:a8:00:03       no                 0.29
>   3     fe:fd:c0:a8:00:04       no                 8.36
> 
> The last 2 are the UML machines.   Using ebtables on the host with the
> bridge  I can see that the IP packets go upto the FORWARD chain in
> both ebtables and iptables after which they seem to disappear. ARP
> packets proceed to the POSTROUTING chain and then out to the other UML
> but IP packets never reach the POSTROUTING chain.
> 
> All the 240 packets seen on the POSTROUTING chain are ARP packets.The
> remaining packets out of the 7424 packets on the PREROUTING hook never
> appear at the POSTROUTING hook.  (Though they can be seen on the
> FORWARD hook in both iptables and ebtables).
> 
> linux:~ # ebtables -t nat -L --Lc
> Bridge table: nat
> 
> Bridge chain: PREROUTING, entries: 1, policy: ACCEPT
> -s fe:fd:c0:a8:0:3 -j ACCEPT , pcnt = 7424 -- bcnt = 610120
> 
> Bridge chain: OUTPUT, entries: 1, policy: ACCEPT
> -s fe:fd:c0:a8:0:3 -j ACCEPT , pcnt = 0 -- bcnt = 0
> 
> Bridge chain: POSTROUTING, entries: 1, policy: ACCEPT
> -s fe:fd:c0:a8:0:3 -j ACCEPT , pcnt = 240 -- bcnt = 6720
> linux:~ #

Perhaps there is something going wrong in the bridge-netfilter code for
this special use.

Try
echo 0 > /proc/sys/net/bridge/bridge-nf-call-iptables

This should disable bridge-netfilter and you should see the packets
traverse the ebtables chains.

cheers,
Bart


