Date: Tue, 2 Mar 2010 09:23:01 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20100302092301.7ca9b368@nehalam>
In-Reply-To: <1267520579.2964.27.camel@edumazet-laptop>
References: <20100301161658.5a61143b@nehalam>
	<1267520579.2964.27.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH]  bridge: per-cpu packet statistics
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>

On Tue, 02 Mar 2010 10:02:59 +0100
Eric Dumazet <eric.dumazet@gmail.com> wrote:

> From: Stephen Hemminger <shemminger@vyatta.com>
>=20
> Le lundi 01 mars 2010 =C3=A0 16:16 -0800, Stephen Hemminger a =C3=A9crit :
>=20
> > +	for_each_online_cpu(cpu) {
> > +		const struct br_cpu_netstats *bstats
> > +			=3D per_cpu_ptr(br->stats, cpu);
> > +
> > +		stats->rx_bytes   +=3D bstats->rx_bytes;
> > +		stats->rx_packets +=3D bstats->rx_packets;
> > +	}
>=20
> And last point, we should use for_each_possible_cpu() here
>=20
> Here is your patch with all my comments integrated :
>=20
> 1) Use txq->{tx_bytes|tx_packets} counter
>=20
> 2) alloc_percpu(struct ...) instead of alloc_percpu(sizeof(struct ...))
>=20
> 3) free_netdev() in destructor
>=20
> 4) for_each_possible_cpu() instead of for_each_online_cpu()
>=20
> 5) br_get_stats() use local variables for the sake of concurrent users

No need, bridge has no queue!
