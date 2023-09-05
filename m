Return-Path: <kuba@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 911514091A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8AE92408E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693947239;
 bh=rPD3WYvBqg9PWkPEMXs+yj80x0SnlrDTEIJPptThAxM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=NqWVB2b+z6W60vXKcAyJOlNDeQSZjzea/uXqVnYc7iCgDpebHFjnDD367NrZOd+B+
 w7ITI3lz/UMcj/AKpm7M3+eoWxmN2y6/ouzwOGt8niR40hI1BXX2fGle8KQvrKu8Nm
 ZqWlmszQ2c8UrWNeROdO2qslZlSKz7w09EFm+KeRCeFVgGTfNDvrb/5zX7otstp3n+
 GLV2tQYnFRud7FsTFz9JiQ9OFnq8SvdRlOaZRFxtS+cpK9zP6W8gfYwvjwIBAk461T
 CVQ3BMJ2c7Uad7kkOaER3hDLYA1GEBDyt0Hg5M7CAA6t3XLgsKotxFvSqCB5iXDGoe
 iuHy49aD1XwTw==
Date: Tue, 5 Sep 2023 13:53:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20230905135357.78b57cde@kernel.org>
In-Reply-To: <20230905-fdb_limit-v3-6-7597cd500a82@avm.de>
References: <20230905-fdb_limit-v3-0-7597cd500a82@avm.de>
 <20230905-fdb_limit-v3-6-7597cd500a82@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 6/6] selftests: forwarding:
 bridge_fdb_learning_limit: Add a new selftest
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Johannes Nixdorf <jnixdorf-oss@avm.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, linux-kernel@vger.kernel.org, Oleksij Rempel <linux@rempel-privat.de>, Vladimir Oltean <vladimir.oltean@nxp.com>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, David Ahern <dsahern@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>

On Tue, 05 Sep 2023 13:47:23 +0200 Johannes Nixdorf wrote:
> Add a suite covering the fdb_n_learned_entries and fdb_max_learned_entries
> bridge features, touching all special cases in accounting at least once.
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
> ---
>  .../net/forwarding/bridge_fdb_learning_limit.sh    | 283 +++++++++++++++++++++

Please add it to the Makefile so it gets run by automation.
