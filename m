Return-Path: <davem@davemloft.net>
Date: Wed, 05 Dec 2018 17:02:10 -0800 (PST)
Message-Id: <20181205.170210.889852049783806765.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20181205131427.4989-1-nikolay@cumulusnetworks.com>
References: <20181205131427.4989-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 0/4] net: bridge: convert multicast
 to generic rhashtable
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed,  5 Dec 2018 15:14:23 +0200

> The current bridge multicast code uses a custom rhashtable
> implementation which predates the generic rhashtable API. Patch 01
> converts it to use the generic kernel rhashtable which simplifies the
> code a lot and removes duplicated functionality. The convert also makes
> hash_elasticity obsolete as the generic rhashtable already has such
> checks and has a fixed elasticity of RHT_ELASTICITY (16 currently) so we
> emit a warning whenever elasticity is set and return RHT_ELASTICITY when
> read (patch 03). Patch 02 converts the multicast code to use non-bh RCU
> flavor as it was mixing bh and non-bh. Since now we have the generic
> rhashtable which autoshrinks we can be more liberal with the default
> hash maximum so patch 04 increases it to 4096 and moves it to a define in
> br_private.h.
> 
> v3: add non-rcu br_mdb_get variant and use it where we have
>     multicast_lock, drop special hash_max handling and just set it where
>     needed and use non-bh RCU consistently (patch 02, new)
> v2: send the latest version of the set which handles when IGMP snooping
>     is not defined, changes are in patch 01

Series applied, thanks Nik.
