MIME-Version: 1.0
In-Reply-To: <8f2d78ba1003081332v539dbebeo7b6ef46f2c48c620@mail.gmail.com>
References: <1826249814.390491268083744068.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<1883282645.390611268083800046.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<8f2d78ba1003081332v539dbebeo7b6ef46f2c48c620@mail.gmail.com>
Date: Mon, 8 Mar 2010 16:03:15 -0600
Message-ID: <2e59e6971003081403saf30ca4od0e25757f099d889@mail.gmail.com>
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] Fwd: What is the lowest valid MAC address that can be
	assigned to a NIC/bridge?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Chandrashekarappa <nandinic1@gmail.com>
Cc: bridge@lists.linux-foundation.org

The "lowest valid MAC address" is assuredly not unique to the host,
which I would think rather defeats the purpose of using it as an
address.

On Mon, Mar 8, 2010 at 3:32 PM, Chandrashekarappa <nandinic1@gmail.com> wrote:
>
> My setup:
> I have a machine running RHEL 5.4(kernel - 2.6.18-164.el5)with two NICs.I've
> created a bonded interface bond0 with the 2 NICs(eth0 and eth1),added bond0
> to the bridge br0.
>
> When I create the bonded interface bond0,bond0 gets the MAC address of the
> first slave device(eth0 in my case)
> After I create br0 and add bond0 to br0,br0 gets the MAC address of bond0.
>
> Issue:
> -I then add a third ethernet interface eth2 to br0
> -br0 now acquires the MAC address of eth2
> -I'd like it if the MAC address of br0 *didn't change*.
>
> My analysis:
> -A bridge acquires the lowest MAC address of all the ports connected to
> it.So,I do believe the bridge acquiring a new MAC address every time an
> ethernet interface is added or removed from a bridge is expected.
> -I also found this patch in the 2.6.27 upstream kernel :
> 92c0574f11598c8036f81e27d2e8bdd6eed7d76d
> bridge: make bridge address settings sticky
>
> Normally, the bridge just chooses the smallest mac address as the
> bridge id and mac address of bridge device. But if the administrator
> has explictly set the interface address then don't change it.
>
> Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
>
> Possible workaround:
> I think I should be able to work around this issue by assigning the lowest
> valid MAC address to one of my ethernet interfaces before adding it to
> br0.I'd like to know what is the lowest valid MAC address that can be
> assigned to a NIC.
> http://standards.ieee.org/regauth/groupmac/tutorial.html
>
> I'd appreciate any pointers.
>
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
