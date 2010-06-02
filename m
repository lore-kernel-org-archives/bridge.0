From: "Singh, Animesh" <Animesh.Singh@lsi.com>
Date: Wed, 2 Jun 2010 17:38:32 +0530
Message-ID: <B56B1B98C23D084F9E69AFCF8A51D84B0292E01617@inbmail02.lsi.com>
In-Reply-To: <20100601091510.38a77a06@nehalam>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] Multicasting and Bridged networking issue
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: "bridge@osdl.org" <bridge@linux-foundation.org>

Not really ... we are based atop Xen-3.4.1 with linux-2.6.18 series in Dom0

-----Original Message-----
From: Stephen Hemminger [mailto:shemminger@linux-foundation.org]=20
Sent: Tuesday, June 01, 2010 9:45 PM
To: Singh, Animesh
Cc: bridge@osdl.org
Subject: Re: [Bridge] Multicasting and Bridged networking issue

On Tue, 1 Jun 2010 15:08:19 +0530
"Singh, Animesh" <Animesh.Singh@lsi.com> wrote:

> Hi,
>     Have been experimenting with bridged networking in order to connect V=
Ms located on separate physical machines. Unicast communication works fine =
but multicast traffic in not being forwarded beyond the bridge. Looking at =
the code am reaching the conclusion that bridge treats multicast traffic in=
 same way as broadcast, so why the multicast traffic is not flowing beyond =
the bridge. Also does kernel tunable like mc_forwarding have any significan=
ce in this matter? On the later version of linux 2.6.18 and after am findin=
g this tunable as read-only (and set to 0). The kernel being used has CONFI=
G_IP_MROUTE enabled but its not running mrouted.
>=20

Are you using VMware? VMware doesn't really allow for bridging.
