Message-ID: <915136920611180514q663e65d1oec82391ed3fac700@mail.gmail.com>
Date: Sat, 18 Nov 2006 14:14:28 +0100
From: "=?ISO-8859-1?Q?Abel_Mart=EDn?=" <abel.martin.ruiz@gmail.com>
In-Reply-To: <49002b820611170149n645e35e6n76edc98fe6c9596@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <49002b820611170149n645e35e6n76edc98fe6c9596@mail.gmail.com>
Subject: Re: [Bridge] bridge physical to several dummy interface
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: d tbsky <tbskyd@gmail.com>
Cc: bridge@lists.osdl.org

On 11/17/06, d tbsky <tbskyd@gmail.com> wrote:
> Hi:
>     i want to bridge my eth0 interface to several dummy interface, like
> vmware or xen did,
> so i can request several dhcp ip address via several mac addresses.
>    but i am stuck in the first step:
>    assume my eth0 is 192.168.10.1, and it can ping 192.168.10.254.
>     ifconfig br0 up
>     brctl setfd br0 0
>     brctl addif br0 eth0
>
>     now i can not ping 192.168.10.254 anymore.
You might be having a routing problem. Check your routing table with ip route.
>     but if i set 192.168.10.2 to br0, i can ping 192.168.10.254.
>     and "dhclient eth0" can get ip addess from dhcp server(that surprise
> me!!)
Try dhclient br0.
>     i try to add dummy interface to br0, but dummy interface can not work,
> like eth0.
>     "brctl showmac br0" give me may mac addresses, so i think bridging is
> working.
>
>     i think i must misunderstanding the brindge concept.
When a nic is part of a bridge it's not supposed to have an address,
is the bridge interface which has to.
>     can i keep eth0 work after it join br0?
I think it does work, since it's the physical
>     thanks a lot for your help!!
>
One more thing: as you add interfaces to a bridge, the bridge MAC will
change to the lowest MAC of the attached interfaces.

Regards.
