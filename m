Return-Path: <jnixdorf-oss@avm.de>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7053281A73
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 76E7D81380
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1684227220; bh=VV1aTdyRlYF0Cbqz2Q4oeSsJ1iE3UDM6RxDiJvHQWZM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=V2oN7ldNczSlpbtWCZKEcWHJ7KbrE5gfu6ksiQH/HrqRedg7F/Wvb20SMAyL8P7WA
 xgGIt/Nl9oylPWMFzXwJqtYtijBQLKFcJgfzk6nOr7cKqLVltrP4mohekm5IOl7Ve0
 pjH74daLXHb/ZXSR1Kfv84mwWAvfV+V3Xhj74aGY=
Date: Tue, 16 May 2023 10:53:39 +0200
From: Johannes Nixdorf <jnixdorf-oss@avm.de>
Message-ID: <ZGNEk3F8mcT7nNdB@u-jnixdorf.ads.avm.de>
References: <20230515085046.4457-1-jnixdorf-oss@avm.de>
 <a1d13117-a0c5-d06e-86b7-eacf4811102f@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1d13117-a0c5-d06e-86b7-eacf4811102f@blackwall.org>
Subject: Re: [Bridge] [PATCH net-next 1/2] bridge: Add a limit on FDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Tue, May 16, 2023 at 11:38:11AM +0300, Nikolay Aleksandrov wrote:
> On 15/05/2023 11:50, Johannes Nixdorf wrote:
> > A malicious actor behind one bridge port may spam the kernel with packets
> > with a random source MAC address, each of which will create an FDB entry,
> > each of which is a dynamic allocation in the kernel.
> > 
> > There are roughly 2^48 different MAC addresses, further limited by the
> > rhashtable they are stored in to 2^31. Each entry is of the type struct
> > net_bridge_fdb_entry, which is currently 128 bytes big. This means the
> > maximum amount of memory allocated for FDB entries is 2^31 * 128B =
> > 256GiB, which is too much for most computers.
> > 
> > Mitigate this by adding a bridge netlink setting IFLA_BR_FDB_MAX_ENTRIES,
> > which, if nonzero, limits the amount of entries to a user specified
> > maximum.
> > 
> > For backwards compatibility the default setting of 0 disables the limit.
> > 
> > All changes to fdb_n_entries are under br->hash_lock, which means we do
> > not need additional locking. The call paths are (✓ denotes that
> > br->hash_lock is taken around the next call):
> > 
> >  - fdb_delete <-+- fdb_delete_local <-+- br_fdb_changeaddr ✓
> >                 |                     +- br_fdb_change_mac_address ✓
> >                 |                     +- br_fdb_delete_by_port ✓
> >                 +- br_fdb_find_delete_local ✓
> >                 +- fdb_add_local <-+- br_fdb_changeaddr ✓
> >                 |                  +- br_fdb_change_mac_address ✓
> >                 |                  +- br_fdb_add_local ✓
> >                 +- br_fdb_cleanup ✓
> >                 +- br_fdb_flush ✓
> >                 +- br_fdb_delete_by_port ✓
> >                 +- fdb_delete_by_addr_and_port <--- __br_fdb_delete ✓
> >                 +- br_fdb_external_learn_del ✓
> >  - fdb_create <-+- fdb_add_local <-+- br_fdb_changeaddr ✓
> >                 |                  +- br_fdb_change_mac_address ✓
> >                 |                  +- br_fdb_add_local ✓
> >                 +- br_fdb_update ✓
> >                 +- fdb_add_entry <--- __br_fdb_add ✓
> >                 +- br_fdb_external_learn_add ✓
> > 
> > Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
> > ---
> >  include/uapi/linux/if_link.h | 1 +
> >  net/bridge/br_device.c       | 2 ++
> >  net/bridge/br_fdb.c          | 6 ++++++
> >  net/bridge/br_netlink.c      | 9 ++++++++-
> >  net/bridge/br_private.h      | 2 ++
> >  5 files changed, 19 insertions(+), 1 deletion(-)
> > 
> 
> I completely missed the fact that you don't deal with the situation where you already have fdbs created
> and a limit is set later, then it would be useless because it will start counting from 0 even though
> there are already entries.

This should not be an issue. The accounting starts with the bridge
creation and is never suspended, so if the user sets a limit later we
do not restart counting at 0.

The only corner case I can see there is if the user sets a new limit
lower than the current number of FDB entries. In that case the code
currently leaves the bridge in a state where the limit is violated,
but refuses new FDB entries until the total is back below the limit. The
alternative of cleaning out old FDB entries until their number is under
the limit again seems to be more error prone to me as well, so I'd rather
leave it that way.

> Also another issue that came to mind is that you don't deal with fdb_create()
> for "special" entries, i.e. when adding a port. Currently it will print an error, but you should revisit
> all callers and see where it might be a problem.

I'll have a look again, also to see whether only counting dynamic
entries created as a reaction to observed packets might be a viable
alternative. If the user creates the entries by adding a port or manually
via netlink I see no reason to restrict them to the same limit.
