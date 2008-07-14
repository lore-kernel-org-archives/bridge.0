Message-ID: <487B11D9.7090800@snapgear.com>
Date: Mon, 14 Jul 2008 18:44:09 +1000
From: Philip Craig <philipc@snapgear.com>
MIME-Version: 1.0
References: <4876FDF0.1030807@iki.fi> <487AA0CD.9090600@snapgear.com>
	<487AFF82.4090707@iki.fi>
In-Reply-To: <487AFF82.4090707@iki.fi>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] bridging with gre tunnel
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?ISO-8859-1?Q?Timo_Ter=E4s?= <timo.teras@iki.fi>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

Timo Ter=E4s wrote:
> There is an essential difference in this patch compared to the one
> I referred to. This patch adds a new way to create GRE devices which
> results in ethernet style device whereas the older patch modifies
> transmit and receive paths to detect packets coming from bridging
> code and does not need userland changes at all.
>
> I kind of like the fact that userland tools work as-is and that
> I don't need any special flags for the GRE tunnel creation. However
> your patch does look way cleaner.
>
> Any comments on what the solution to merged in should look like?

I posted a cleaner version that's similar to what the old patch
did, see http://marc.info/?l=3Dlinux-netdev&m=3D115449948503549&w=3D2

But I don't think that is the right approach:
- it forces you to use bridging if you only want ethernet over GRE
- the change fundamentally has nothing to do with bridging

BTW, the STP bits in my patch can be removed too if needed, most users
won't want them and they aren't quite right (stp packets are counted
as errors).  I don't even know what device needed it, I just have a
pcap file with the packets.  After removing that, there's nothing
in the patch related to bridging.

Actually, this change doesn't really belong in GRE either, because
that forces you to choose between ethernet encapsulation and not.
It could be a new device that sits on top of GRE and simply does
ethernet encapsulation then passes it to the raw GRE device.
That's a lot of infrastructure for something so simple though,
and I don't think people will want to use both devices at once.
