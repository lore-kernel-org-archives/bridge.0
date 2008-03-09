Message-ID: <2e59e6970803082336p383350ebm39d4403470ffd162@mail.gmail.com>
Date: Sun, 9 Mar 2008 07:36:55 +0000
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
In-Reply-To: <47D2BE18.7030405@navigue.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <47D19BC9.6060702@navigue.com>
	<bdfc5d6e0803071208p4ba7a38fl9beee59a4ab874b0@mail.gmail.com>
	<47D1B45F.7020409@navigue.com>
	<bdfc5d6e0803071423ia2c794fn662a6e875ffafe09@mail.gmail.com>
	<47D2BE18.7030405@navigue.com>
Subject: Re: [Bridge] bridge, vlan and *no* stp/bpdu
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jonathan Thibault <jonathan@navigue.com>
Cc: bridge@lists.osdl.org

On Sat, Mar 8, 2008 at 4:26 PM, Jonathan Thibault <jonathan@navigue.com> wrote:
> Andy Gospodarek wrote:
>  > Configurations like this can get tricky at times.  Though it seems to
>  > make perfect sense to put two interfaces like this in the same bridge
>  > the current setup of the linux networking stack makes it hard to get
>  > things working sometimes.  Let me make sure I can understand what you
>  > are trying to accomplish.  Do you want to prevent traffic from vlan 2
>  > and vlan 3 from ever talking while still allowing them to talk to the
>  > gateway?  Will you want vlan 2 and vlan3 to communicate with each
>  > other at all?
>  >
>  Well, the plan is to let the vlans communicate together 'freely', for
>  now.  I'm essentially using the vlan tag as a way to 'figure out' where
>  the packet is coming from.  The network spans a little over 100km in a
>  large, flat /22 subnet.  I wish I could do this the usual way with
>  subnets and what not, but we don't really control the routing and
>  gateway side of things.  So basically, we want to assign a vlan to each
>  branch of the network and avoid having to add a new NIC to the bridge
>  each time we add a new branch.  Feeding it a trunk into it and adding
>  vlan interfaces as needed works better for us since bandwidth is not
>  really the limiting factor.  Well, it would be better if it worked :P
>
>  Now I fully understand that it's not how 90% of people would approach
>  this, including myself, but it's the only option we have given what's on
>  either side of the bridge, which we can't change right now.  The
>  alternative is having a switch split the trunk and then feed that into
>  real (as opposed to vlan) interfaces on the bridge, wich I haven't fully
>  tested yet but am sure would work fine.
>
>  I'd rather focus on solving the bridged vlan thing though, it just might
>  be useful to someone else someday and definitely falls into the 'should
>  work' category as far as I'm concerned.

You still didn't tell us any version numbers, and I've got a similar
setup which "works for me".  The only real difference is that my box
routes between two logical bridges, and the bridged interfaces are
multiple vlans in the same trunk.  I can even protect individual vlans
from each other with netfilter rules.

What if you routed "out" as a new vlan on the same cable as "in"?

>
>  Jonathan
>
>  P.S.:  Sorry, forgot to reply to the list.
>
>
> _______________________________________________
>  Bridge mailing list
>  Bridge@lists.linux-foundation.org
>  https://lists.linux-foundation.org/mailman/listinfo/bridge
>
