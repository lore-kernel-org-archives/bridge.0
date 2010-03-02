From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <20100302095831.151c8bb5@nehalam>
References: <20100301161658.5a61143b@nehalam>
	<1267520579.2964.27.camel@edumazet-laptop>
	<20100302095831.151c8bb5@nehalam>
Content-Type: text/plain; charset="utf-8"
Date: Tue, 02 Mar 2010 19:06:13 +0100
Message-ID: <1267553173.2839.9.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH]  bridge: per-cpu packet statistics (v2)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>

Le mardi 02 mars 2010 à 09:58 -0800, Stephen Hemminger a écrit :
> +	struct br_cpu_netstats __percpu {
> +		unsigned long	rx_packets;
> +		unsigned long	tx_packets;
> +		unsigned long	rx_bytes;
> +		unsigned long	tx_bytes;
> +	} *stats;
> +

Ok, please group rx stats together instead of interleave, this to reduce
possibility of touching two cache lines in tx path (or rx path)

	struct br_cpu_netstats __percpu {
> 		unsigned long	rx_packets;
> +		unsigned long	rx_bytes;
> 
> +		unsigned long	tx_packets;
> +		unsigned long	tx_bytes;
> +	} *stats;
> +


