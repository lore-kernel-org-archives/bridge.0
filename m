Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 303A660C28
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 39FB960D71
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1684226293; x=1686818293;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qoPnstjPrS2tzxEaPLFxVKxPj2WD+daPAFjbj9WTzeA=;
 b=x+AYYlvmcvoPE6XEGFZ+zXR1dy97/Gjk9/JFLJgq598TT4S2KgCmm7js1PYCuIu2aa
 BgK6e/PbU25N55S47oUFbt8DQ4RJSpuOYyYOf1QTi3BuRFdSSSrcJnkgzDDzV3lX7Uo4
 ZuCRK7bEeBkio/9mz3kpnivYgynTlowWBwmnd6Z0jR2frjS+euEznXRhH7wr1/TJ6QLq
 VDdyZKJttmdjpHvDAzqdFAroThW0zhwWEcLH4NRdbcEGY1FbzjnHSzc8Rm9Lp/A+flMK
 2enzAg2BLSXp1asCYWGYxX6zQ2eupJXgV0c/Xooa8maBNLaUOO0FajLMXLjLcnXgTGpl
 o7dA==
Message-ID: <a1d13117-a0c5-d06e-86b7-eacf4811102f@blackwall.org>
Date: Tue, 16 May 2023 11:38:11 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230515085046.4457-1-jnixdorf-oss@avm.de>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230515085046.4457-1-jnixdorf-oss@avm.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next 1/2] bridge: Add a limit on FDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Johannes Nixdorf <jnixdorf-oss@avm.de>, netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On 15/05/2023 11:50, Johannes Nixdorf wrote:
> A malicious actor behind one bridge port may spam the kernel with packets
> with a random source MAC address, each of which will create an FDB entry,
> each of which is a dynamic allocation in the kernel.
> 
> There are roughly 2^48 different MAC addresses, further limited by the
> rhashtable they are stored in to 2^31. Each entry is of the type struct
> net_bridge_fdb_entry, which is currently 128 bytes big. This means the
> maximum amount of memory allocated for FDB entries is 2^31 * 128B =
> 256GiB, which is too much for most computers.
> 
> Mitigate this by adding a bridge netlink setting IFLA_BR_FDB_MAX_ENTRIES,
> which, if nonzero, limits the amount of entries to a user specified
> maximum.
> 
> For backwards compatibility the default setting of 0 disables the limit.
> 
> All changes to fdb_n_entries are under br->hash_lock, which means we do
> not need additional locking. The call paths are (✓ denotes that
> br->hash_lock is taken around the next call):
> 
>  - fdb_delete <-+- fdb_delete_local <-+- br_fdb_changeaddr ✓
>                 |                     +- br_fdb_change_mac_address ✓
>                 |                     +- br_fdb_delete_by_port ✓
>                 +- br_fdb_find_delete_local ✓
>                 +- fdb_add_local <-+- br_fdb_changeaddr ✓
>                 |                  +- br_fdb_change_mac_address ✓
>                 |                  +- br_fdb_add_local ✓
>                 +- br_fdb_cleanup ✓
>                 +- br_fdb_flush ✓
>                 +- br_fdb_delete_by_port ✓
>                 +- fdb_delete_by_addr_and_port <--- __br_fdb_delete ✓
>                 +- br_fdb_external_learn_del ✓
>  - fdb_create <-+- fdb_add_local <-+- br_fdb_changeaddr ✓
>                 |                  +- br_fdb_change_mac_address ✓
>                 |                  +- br_fdb_add_local ✓
>                 +- br_fdb_update ✓
>                 +- fdb_add_entry <--- __br_fdb_add ✓
>                 +- br_fdb_external_learn_add ✓
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
> ---
>  include/uapi/linux/if_link.h | 1 +
>  net/bridge/br_device.c       | 2 ++
>  net/bridge/br_fdb.c          | 6 ++++++
>  net/bridge/br_netlink.c      | 9 ++++++++-
>  net/bridge/br_private.h      | 2 ++
>  5 files changed, 19 insertions(+), 1 deletion(-)
> 

I completely missed the fact that you don't deal with the situation where you already have fdbs created
and a limit is set later, then it would be useless because it will start counting from 0 even though
there are already entries. Also another issue that came to mind is that you don't deal with fdb_create()
for "special" entries, i.e. when adding a port. Currently it will print an error, but you should revisit
all callers and see where it might be a problem.



