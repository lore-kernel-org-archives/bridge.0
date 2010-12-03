Message-ID: <4CF8BB08.7040601@free.fr>
Date: Fri, 03 Dec 2010 10:40:24 +0100
From: =?windows-1252?Q?Nicolas_de_Peslo=FCan?=
 <nicolas.2p.debian@free.fr>
MIME-Version: 1.0
References: <DBDEC20E6E29304D8AE5EAA493609B35576467B066@EMBX02-HQ.jnpr.net>
In-Reply-To: <DBDEC20E6E29304D8AE5EAA493609B35576467B066@EMBX02-HQ.jnpr.net>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] bridge problem with with ICMP fragment reassembly
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Shawn Delaney <sdelaney@juniper.net>
Cc: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

Le 02/12/2010 23:19, Shawn Delaney a =E9crit :
> Hi,
> I have a bridge (br0) with two enslaved interfaces (int0 and ext0). From
> the ext0 side, with a windows device, I ping with packet size 1932:
> ping =96n 1 =96l 1932 10.64.160.94
> ping request and reply is bridged.
> Now if I do the same with packet size 1933:
> ping =96n 1 =96l 1933 10.64.160.94
> the request never seems to make it to the bridge interface
> If I sniff the ping from the windows device on the ext0 side, I see two
> frames sent, request + fragment, as expected.
> In the working case, if I sniff ext0 on the bridge device I see the same
> two frames received.
> In the working case, if I sniff br0 on the bridge I see one frame (I
> assume the bridge reassembles the request + fragment).
> In the non working case, if I sniff ext0 on the bridge device I see the
> same two frames received.
> In the non working case, if I sniff br0 I see nothing.
> It seems there is a bug with bridging and reassembly of packets or
> fragments of a certain size, and am wondering If there is a patch.

Bridges are not expected to change frames in any way. This is not specific =
to the bridging function=20
of Linux.

No reassembly occurs at the bridge level. If one host send two frames, the =
bridge will forward two=20
frames.

By the way, it means that the MTU for all interfaces of the bridge should b=
e identical.

	Nicolas.

> The MTU of all interfaces is 1500.
> I am using connection tracking.
> The problem is seen on kernels 2.6.11 and 2.6.24
> Any help would be much appreciated.
> Regards,
> Shawn
>
>
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge

