MIME-Version: 1.0
In-Reply-To: <OFB9EFBBE7.11608167-ONC12576F1.005B0C79-C12576F1.005BBE51@transmode.se>
References: <OFB9EFBBE7.11608167-ONC12576F1.005B0C79-C12576F1.005BBE51@transmode.se>
Date: Thu, 25 Mar 2010 12:03:34 -0500
Message-ID: <2e59e6971003251003g34f45ccsf7feecbcb2d68cbf@mail.gmail.com>
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] IP address on physcial interface instead of bridge
	interface?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: bridge@lists.linux-foundation.org

On Thu, Mar 25, 2010 at 11:42 AM, Joakim Tjernlund
<joakim.tjernlund@transmode.se> wrote:
>
> Currently it isn't possible to to have an IP address on one of interfaces
> attached to a bridge, one must always put the IP address on the bridge in=
terface itself.
>
> I wonder if there is a technical reason for that? I would love to be able
> to be able to chose any ONE interface attached to the bridge.
> Example:
> Assume br0 bridge with two interfaces attached, eth0 and eth1.
> Then I would like to assign the IP address to eth0 instead of
> br0. Ideally one should be able to just attach eth0 with an existing IP a=
ddress
> to br0.

Migrating existing configuration to the bridge at the time a port is
added (and back to one member when the bridge is dissolved) has been
discussed quite a bit recently, and is completely different from
trying to independently configure L3 state of bridge ports at
arbitrary times.


>
> =C2=A0 =C2=A0Jocke
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
