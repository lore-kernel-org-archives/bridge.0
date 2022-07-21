Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5D2534015F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CD60840135
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=qXv6CUvSTMfPvvXNvz/Br6ygFjjEQtW3IZorN82JkiU=;
 b=P+0nQPKeA3PoGFzwFw3rHozuSxcxC8sThvgWr85Jgf8I0HLON9ganDXQeF+CXi03M8
 QjR7MJw6kirPoUgYH+Giho7PJvp2ReSEvld3BVDqJP1IlxeQfywVwXtpsBRJSXX4+jWb
 plznFF7jPvGt3gwaqtL2/00LYhCFhrX8Q2iWYZFHKd/mPx6Mpu3FViZ6AsRPoG3iofQI
 H3FmIsHff9UoPwOJzMMdft7cHqTf5qN4rDyGg8bdoUwiX6nh+bYwn2P7RsU/suilsCsu
 3pYjs4Ujkes4hhtM+BsOvm8IEzRBpXWF+HOV66ewkbbfBisnVv6XU9Kv1t4SKZAjMJNo
 0u+w==
Date: Thu, 21 Jul 2022 17:20:01 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220721142001.twcmiyvhvlxmp24j@skbuf>
References: <20220708115624.rrjzjtidlhcqczjv@skbuf>
 <723e2995314b41ff323272536ef27341@kapio-technology.com>
 <YsqPWK67U0+Iw2Ru@shredder>
 <d3f674dc6b4f92f2fda3601685c78ced@kapio-technology.com>
 <Ys69DiAwT0Md+6ai@shredder>
 <648ba6718813bf76e7b973150b73f028@kapio-technology.com>
 <YtQosZV0exwyH6qo@shredder>
 <4500e01ec4e2f34a8bbb58ac9b657a40@kapio-technology.com>
 <20220721115935.5ctsbtoojtoxxubi@skbuf> <YtlUWGdgViyjF6MK@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtlUWGdgViyjF6MK@shredder>
Subject: Re: [Bridge] [PATCH v4 net-next 3/6] drivers: net: dsa: add locked
 fdb entry flag to drivers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, netdev@kapio-technology.com, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Thu, Jul 21, 2022 at 04:27:52PM +0300, Ido Schimmel wrote:
> I tried looking information about MAB online, but couldn't find
> detailed material that answers my questions, so my answers are based
> on what I believe is logical, which might be wrong.

I'm kind of in the same situation here.

> Currently, the bridge will forward packets to a locked entry which
> effectively means that an unauthorized host can cause the bridge to
> direct packets to it and sniff them. Yes, the host can't send any
> packets through the port (while locked) and can't overtake an existing
> (unlocked) FDB entry, but it still seems like an odd decision. IMO, the
> situation in mv88e6xxx is even worse because there an unauthorized host
> can cause packets to a certain DMAC to be blackholed via its zero-DPV
> entry.
> 
> Another (minor?) issue is that locked entries cannot roam between locked
> ports. Lets say that my user space MAB policy is to authorize MAC X if
> it appears behind one of the locked ports swp1-swp4. An unauthorized
> host behind locked port swp5 can generate packets with SMAC X,
> preventing the true owner of this MAC behind swp1 from ever being
> authorized.

In the mv88e6xxx offload implementation, the locked entries eventually
age out from time to time, practically giving the true owner of the MAC
address another chance every 5 minutes or so. In the pure software
implementation of locked FDB entries I'm not quite sure. It wouldn't
make much sense for the behavior to differ significantly though.

> It seems like the main purpose of these locked entries is to signal to
> user space the presence of a certain MAC behind a locked port, but they
> should not be able to affect packet forwarding in the bridge, unlike
> regular entries.

So essentially what you want is for br_handle_frame_finish() to treat
"dst = br_fdb_find_rcu(br, eth_hdr(skb)->h_dest, vid);" as NULL if
test_bit(BR_FDB_LOCKED, &dst->flags) is true?

> Regarding a separate knob for MAB, I tend to agree we need it. Otherwise
> we cannot control which locked ports are able to populate the FDB with
> locked entries. I don't particularly like the fact that we overload an
> existing flag ("learning") for that. Any reason not to add an explicit
> flag ("mab")? At least with the current implementation, locked entries
> cannot roam between locked ports and cannot be refreshed, which differs
> from regular learning.

Well, assuming we model the software bridge closer to mv88e6xxx (where
locked FDB entries can roam after a certain time), does this change things?
In the software implementation I think it would make sense for them to
be able to roam right away (the age-out interval in mv88e6xxx is just a
compromise between responsiveness to roaming and resistance to DoS).
