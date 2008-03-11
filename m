Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Mar 2008 11:43:24 +1100
Message-ID: <96CF49BD8B56384395D698BA99007FA32FA169@exchange.pacwire.local>
From: "Leigh Sharpe" <lsharpe@pacificwireless.com.au>
Subject: Re: [Bridge] bridge, vlan and *no* stp/bpdu
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jonathan Thibault <jonathan@navigue.com>, bridge@lists.osdl.org

Can you do a brctl showmacs br0, and see if the machines which are not
receiving an ARP response are being seen by the bridge as being on the
wrong VLAN?


Ie, I'm wondering if the bridge sees their MAC address on an interface
other than the one they are really connected to. If that's the case, the
bridge would send their response out of the wrong interface, which may
result in the symptoms you are describing. I think there may be some
ebtables rules which could help here, but my memory fails me at this
point.

Regards,
             Leigh
=20
Leigh Sharpe
Network Systems Engineer
Pacific Wireless
Ph +61 3 9584 8966
Mob 0408 009 502
Helpdesk 1300 300 616
email lsharpe@pacificwireless.com.au
web www.pacificwireless.com.au
=20

-----Original Message-----
From: bridge-bounces@lists.linux-foundation.org
[mailto:bridge-bounces@lists.linux-foundation.org] On Behalf Of Jonathan
Thibault
Sent: Monday, 10 March 2008 2:53 AM
To: bridge@lists.osdl.org
Subject: Re: [Bridge] bridge, vlan and *no* stp/bpdu

Sorry, that's was in another mistakenly off-list reply.

Kernel is 2.6.24, been seeing this problem since 2.6.16 when I started=20
the setup.

richardvoigt@gmail.com wrote:
>
> You still didn't tell us any version numbers, and I've got a similar
> setup which "works for me".  The only real difference is that my box
> routes between two logical bridges, and the bridged interfaces are
> multiple vlans in the same trunk.  I can even protect individual vlans
> from each other with netfilter rules.
>
> What if you routed "out" as a new vlan on the same cable as "in"?
>
>  =20
That's an interesting idea which I haven't tried yet.  An interesting=20
tidbit is that there is a handful of machines in the lot which are=20
affected right away (as soon as I add a second vlan interface to the=20
bridge).  It may just be that they just have a very short arp timeout. =20
I tried to find a pattern in their MAC addresses or hardware but there=20
isn't really one.  I first assumed there was a problem with those=20
machines but given that the ARP reply never gets to the trunk cable=20
going their way, I concluded otherwise.

Thanks a lot for the help.  The fact that you have a setup that works=20
gives me some confidence that I'm not just trying to do something insane
;)

Jonathan
_______________________________________________
Bridge mailing list
Bridge@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/bridge
