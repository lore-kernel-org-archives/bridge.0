MIME-Version: 1.0
In-Reply-To: <OFCE5E72FE.D082AB78-ONC12575D4.005256D7-C12575D4.0052B193@transmode.se>
References: <1244842010-24945-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<m3ab4dovgi.fsf@ursa.amorsen.dk>
	<OFCE5E72FE.D082AB78-ONC12575D4.005256D7-C12575D4.0052B193@transmode.se>
Date: Sat, 13 Jun 2009 10:57:55 -0500
Message-ID: <2e59e6970906130857t2441d0bap34e15fd2af12fe72@mail.gmail.com>
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH] [bridge] Add split horizon
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: bridge@lists.linux-foundation.org, Benny Amorsen <benny+usenet@amorsen.dk>

On Sat, Jun 13, 2009 at 10:03 AM, Joakim
Tjernlund<joakim.tjernlund@transmode.se> wrote:
> Benny Amorsen <benny+usenet@amorsen.dk> wrote on 13/06/2009 01:58:53:
>>
>> Joakim Tjernlund <Joakim.Tjernlund@transmode.se> writes:
>>
>> > Currently the bridge does not impl. split horizon which will easily
>> > cause loops when 2 or more VLANs are added from the same physical inte=
rface.
>>
>> Why would they cause loops? If your topology isn't loop free, run
>> spanning tree in the VLAN's. Yet another thing most hardware switches
>> can't do, incidentally.
>
> ehh, connect two Linux bridges that have 2 VLANs in common on the intersw=
itch connection.

For example, here is a configuration that meets your problem
description and has no loops:

host A eth0 connected to hostB eth0

host A:
brctl add br0
brctl addif br0 eth0.1
brctl addif br0 eth1
brctl add br1
brctl addif br1 eth0.2
brctl addif br1 eth2

host B:
brctl add br0
brctl addif br0 eth0.1
brctl addif br0 wlan0.1
brctl add br1
brctl addif br1 eth0.2
brctl addif br1 wlan0.2

Let's compare this to your complaint:
Two Linux hosts.... check
Two VLANs in common.... check
Both VLANs on the inter-switch connection.... check

Nope, there are no loops.

You need to stop calling "a machine running bridging" a "Linux
bridge".  A "bridge", in Linux, is a virtual interface inside a
machine with the bridging module loaded.  There can be more than zero,
one, or multiple bridges in a single Linux machine.  I think that when
you understand that, all your problems will go away with a simpler
configuration and no changes to the Linux kernel.



> What happens?
>
> =A0Jocke
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
