Date: Tue, 14 Apr 2009 12:15:13 +0200
From: Jiri Pirko <jpirko@redhat.com>
Message-ID: <20090414101512.GA3999@psychotron.englab.brq.redhat.com>
References: <20090313183303.GF3436@psychotron.englab.brq.redhat.com>
	<20090413083729.GA23734@psychotron.englab.brq.redhat.com>
	<20090413084407.GD23734@psychotron.englab.brq.redhat.com>
	<20090413075400.34604e72@nehalam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090413075400.34604e72@nehalam>
Subject: Re: [Bridge] [PATCH 3/4] net: bridge: use device address list
	instead of	dev_addr
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: ivecera@redhat.com, fubar@us.ibm.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mschmidt@redhat.com, bonding-devel@lists.sourceforge.net, dada1@cosmosbay.com, jgarzik@pobox.com, davem@davemloft.net

Mon, Apr 13, 2009 at 04:54:00PM CEST, shemminger@vyatta.com wrote:
>> +static int another_port_has_addr(const struct net_bridge_port *p,
>> +				 struct net_bridge_fdb_entry *f)
>> +{
>> +	struct net_bridge *br = p->br;
>> +	struct net_bridge_port *op;
>> +
>> +	list_for_each_entry(op, &br->port_list, list) {
>> +		if (op != p && is_dev_addr(op->dev, f->addr.addr)) {
>> +			f->dst = op;
>> +			return 1;
>> +		}
>> +	}
>> +	return 0;
>> +}
>
>Forwarding database is hot path, people sometimes run lots of devices
>on single bridge, doesn't this scale worse?
>
This only puts the original loop code to the function, so if compiler decides to
inline this there might be no difference.
