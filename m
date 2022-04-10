Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=OidQIHbEm/hM6OAnbFcQVbU0BPrg1Seqw7Y933k7iHk=;
 b=e4W65seRjaLegmIk/OvxytHviWAisj66NFs6XfVQG39KqoNOSUhXlTq6b1hnm6rgLW
 idJSXoORhzZ8Y4jYPaLZM94QqaWYf0TNcrD/kk4tS6xP4HlcEtT/w75CoW79Td6IhTcM
 W1lnAcMAwstXURXMMUkr+iX52kD8vm4aXHK5Z3Ob5dAd53zq/PVS8lIKC/gJ+nCzJXGm
 CNoRRhPANDOauAPJ+IQFm9Yh65OC5atrbj3uxvxIpsVrsf6GM6Nndop/T2c5Md9vRLHg
 rRSIx3U9rpH/NkCd83LujQtiPhUJt3LVOkyfIeZDuwQb2+/+wNIFeFCDSTx9PV84ca2s
 RIWg==
Message-ID: <b38a740f-fadb-bd2e-38d2-3683ddce69eb@blackwall.org>
Date: Sun, 10 Apr 2022 23:43:20 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20220409105857.803667-1-razor@blackwall.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220409105857.803667-1-razor@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/6] net: bridge: add flush filtering
	support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@idosch.org>, kuba@kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

On 09/04/2022 13:58, Nikolay Aleksandrov wrote:
> Hi,
> This patch-set adds support to specify filtering conditions for a flush
> operation. Initially only FDB flush filtering is added, later MDB
> support will be added as well. Some user-space applications need a way
> to delete only a specific set of entries, e.g. mlag implementations need
> a way to flush only dynamic entries excluding externally learned ones
> or only externally learned ones without static entries etc. Also apps
> usually want to target only a specific vlan or port/vlan combination.
> The current 2 flush operations (per port and bridge-wide) are not
> extensible and cannot provide such filtering, so a new bridge af
> attribute is added (IFLA_BRIDGE_FLUSH) which contains the filtering
> information for each object type which has to be flushed.
> An example structure for fdbs:
>      [ IFLA_BRIDGE_FLUSH ]
>       `[ BRIDGE_FDB_FLUSH ]
>         `[ FDB_FLUSH_NDM_STATE ]
>         `[ FDB_FLUSH_NDM_FLAGS ]
> 
[snip]
> Note that all flags have their negated version (static vs nostatic etc)
> and there are some tricky cases to handle like "static" which in flag
> terms means fdbs that have NUD_NOARP but *not* NUD_PERMANENT, so the
> mask matches on both but we need only NUD_NOARP to be set. That's
> because permanent entries have both set so we can't just match on
> NUD_NOARP. Also note that this flush operation doesn't treat permanent
> entries in a special way (fdb_delete vs fdb_delete_local), it will
> delete them regardless if any port is using them. We can extend the api
> with a flag to do that if needed in the future.
> 
> Patches in this set:
>  1. adds the new IFLA_BRIDGE_FLUSH bridge af attribute
>  2. adds a basic structure to describe an fdb flush filter
>  3. adds fdb netlink flush call via BRIDGE_FDB_FLUSH attribute
>  4 - 6. add support for specifying various fdb fields to filter
> 
> Patch-sets (in order):
>  - Initial flush infra and fdb flush filtering (this set)
>  - iproute2 support
>  - selftests
> 
> Future work:
>  - mdb flush support
> 
> Thanks,
>  Nik
> 
> Nikolay Aleksandrov (6):
>   net: bridge: add a generic flush operation
>   net: bridge: fdb: add support for fine-grained flushing
>   net: bridge: fdb: add new nl attribute-based flush call
>   net: bridge: fdb: add support for flush filtering based on ndm flags
>     and state
>   net: bridge: fdb: add support for flush filtering based on ifindex
>   net: bridge: fdb: add support for flush filtering based on vlan id
> 
>  include/uapi/linux/if_bridge.h |  22 ++++++
>  net/bridge/br_fdb.c            | 128 +++++++++++++++++++++++++++++++--
>  net/bridge/br_netlink.c        |  59 ++++++++++++++-
>  net/bridge/br_private.h        |  12 +++-
>  net/bridge/br_sysfs_br.c       |   6 +-
>  5 files changed, 215 insertions(+), 12 deletions(-)
> 

Just FYI I plan to send v2 tomorrow with a few cleanups suggested by Ido.
Please don't apply this one, I'll wait for more feedback and will resubmit.

Thanks,
 Nik
