MIME-Version: 1.0
In-Reply-To: <20090508162719.6cbc3022@nehalam>
References: <de7adc5e0905081431v58989abch5e7271de302afd99@mail.gmail.com>
	<20090508155418.7acc7fbf@nehalam>
	<de7adc5e0905081620s69f3e874xa50636b0b6fc65d3@mail.gmail.com>
	<20090508162719.6cbc3022@nehalam>
Date: Fri, 8 May 2009 19:08:06 -0600
Message-ID: <de7adc5e0905081808h43e5ef84m113c4dd868077bf1@mail.gmail.com>
From: Daniel Robbins <drobbins@funtoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] 2.6.27: persistent MAC assignment to bridge not working
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: bridge@lists.linux-foundation.org, "Pavel V. Emelianov" <xemul@sw.ru>

Your code in 2.6.27 works perfectly.

Let me tell you what I was doing wrong, and if you could tell me why
it didn't work, I'd really appreciate it :) (Might also be a good
addition to the Net:Bridge FAQ):

# brctl addbr br0
# brctl addif br0 eth0
# ifconfig br0 10.0.1.220 netmask 255.255.255.0
# brctl addif br0 veth100.0
# brctl addif br0 veth102.0

Now, the zinger:

# ifconfig br0 hw ether "12:34:56:78:90:ab"

^^ By using a unique MAC address, this command totally disables my
bridge, and the machine can no longer send or receive data.

If I use a MAC that is already in use by my bridge's sub-interfaces,
however, (ie. from eth0, veth100.0 or veth102.0) then there's no
problem, and everything works, and the MAC address is sticky as it
should be.

So this was the mistake I was making - I was using a user-generated
MAC for my testing rather than choosing a MAC from one of the bridge's
interfaces.

So, my question is: why doesn't a user-generated MAC work? On the
surface, it seems like all devices on the same LAN should have
different MAC addresses. Yet, with Linux bridging, it appears that (at
least in certain conditions, like if there is an IP assigned to the
bridge,) then the bridge *must* share a MAC with one of its
sub-interfaces in order to function properly. This is very
counter-intuitive and a mystery to me and probably quite a few other
bridging newbies (which is why an explanation would make a great
addition to the Net:Bridge FAQ :)

Best Regards,

Daniel Robbins

On Fri, May 8, 2009 at 5:27 PM, Stephen Hemminger <shemminger@vyatta.com> w=
rote:
> On Fri, 8 May 2009 17:20:08 -0600
> Daniel Robbins <drobbins@funtoo.org> wrote:
>
>> This commit is in my 2.6.27-based kernel. It does not appear to be
>> working. Can you show me what steps I should take to confirm that this
>> sticky code is functioning properly, ie commands and expected results?
>>
>> Thanks.
>>
>> -Daniel
>>
>> On Fri, May 8, 2009 at 4:54 PM, Stephen Hemminger <shemminger@vyatta.com=
> wrote:
>> > On Fri, 8 May 2009 15:31:43 -0600
>> > Daniel Robbins <drobbins@funtoo.org> wrote:
>> >
>> >> Hi All,
>> >>
>> >> I am trying to figure out how to get a persistent, non-changing MAC
>> >> address assigned to a bridge. It looks like there is new functionalit=
y
>> >> in 2.6.27 to allow this to happen, specifically, in:
>> >>
>> >> void br_stp_recalculate_bridge_id(struct net_bridge *br)
>> >> [...]
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* user has chosen a value so keep it */
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (br->flags & BR_SET_MAC_ADDR)
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> >>
>> >> and in..
>> >>
>> >> static int br_set_mac_address(struct net_device *dev, void *p)
>> >> [...]
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 br->flags |=3D BR_SET_MAC_ADDR;
>> >>
>> >> However, I cannot get this functionality to work as it appears it
>> >> should. If I manually set a bridge's MAC address to an arbitrary
>> >> value, as follows:
>> >>
>> >> # ifconfig br0 hw ether "xx:xx:xx:xx:xx:xx"
>> >>
>> >> Then, subsequent calls such as the following seem to still change the
>> >> bridge's MAC address:
>> >>
>> >> # brctl addif br0 veth100.0
>> >> # brctl delif br0 veth100.0
>> >>
>> >> Am I doing something wrong? What is the proper way to take advantage
>> >> of the new code in 2.6.27?
>> >>
>> >> The only mechanism that I have found that appears to achieve my
>> >> desired result is application of Deitmar Maurer's 2.6.24 patch which,
>> >> after being applied, seems to disable the dynamic nature of the
>> >> bridge's MAC, so that br0 persistently uses the MAC of the first
>> >> interface that was added to the bridge. Here is this patch that seems
>> >> to be working for me:
>> >>
>> >> --- linux-2.6.24-openvz.org/net/bridge/br_stp_if.c.org =C2=A02008-06-=
11
>> >> 09:15:16.000000000 +0200
>> >> +++ linux-2.6.24-openvz.org/net/bridge/br_stp_if.c =C2=A0 =C2=A0 =C2=
=A02008-06-11
>> >> 09:44:53.000000000 +0200
>> >> @@ -217,10 +217,7 @@
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct net_bridge_port *p;
>> >>
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0list_for_each_entry(p, &br->port_list, lis=
t) {
>> >> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (addr =3D=3D br=
_mac_zero ||
>> >> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memc=
mp(p->dev->dev_addr, addr, ETH_ALEN) < 0)
>> >> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 addr =3D p->dev->dev_addr;
>> >> -
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 addr =3D p->dev->d=
ev_addr;
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>> >>
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (compare_ether_addr(br->bridge_id.addr,=
 addr))
>> >> --------------------------
>> >>
>> >> However, when I look at the 2.6.27 source code, it seems like this
>> >> patch should no longer be needed and an "ifconfig br0 hw ether
>> >> "xx:xx:xx:xx:xx:xx" should be sufficient. Am I doing something wrong?
>> >>
>> >> Thanks for your time,
>> >>
>> >> Daniel Robbins
>> >
>> > It was fixed by:
>> >
>> > Author: Stephen Hemminger <shemminger@vyatta.com> =C2=A02008-06-17 16:=
10:06
>> > Committer: David S. Miller <davem@davemloft.net> =C2=A02008-06-17 16:1=
0:06
>> > Parent: 0b040829952d84bf2a62526f0e24b624e0699447 (net: remove CVS keyw=
ords)
>> > Branches: master, remotes/origin/master
>> > Follows: v2.6.26-rc6
>> > Precedes: v2.6.27-rc1
>> >
>> > =C2=A0 =C2=A0bridge: make bridge address settings sticky
>> >
>> > =C2=A0 =C2=A0Normally, the bridge just chooses the smallest mac addres=
s as the
>> > =C2=A0 =C2=A0bridge id and mac address of bridge device. But if the ad=
ministrator
>> > =C2=A0 =C2=A0has explictly set the interface address then don't change=
 it.
>> >
>> > =C2=A0 =C2=A0Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>
>> > =C2=A0 =C2=A0Signed-off-by: David S. Miller <davem@davemloft.net>
>> >
>> >
>
> # brctl addbr brex0
> # modprobe dummy
>
> # ip li set dev brex0 addr 0c:01:02:03:04:05
> # ip li show dev brex0
> 22: brex0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
> =C2=A0 =C2=A0link/ether 0c:01:02:03:04:05 brd ff:ff:ff:ff:ff:ff
> # brctl addif brex0 dummy0
> # ip li show dev brex0
> 22: brex0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
> =C2=A0 =C2=A0link/ether 0c:01:02:03:04:05 brd ff:ff:ff:ff:ff:ff
>
> --
>
