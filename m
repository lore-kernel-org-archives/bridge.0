Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F3D4B60692
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6DCA66068D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gVdahFE3VCsg1gB9d5/Q9u5eE8BPZK+mrYotqg2hIQI=;
 b=WkJ0nrMo5rkcmbC0jEiEUWoe+lpYz8LMT2g3ETIXKai3ipMja/7APKVLpqDQ5mlCgl
 HbexCGvC3+l/2WAvq+hJGNVrlSU4kAEDjh0deqWj++gGyme0xfljRvk1lWnXDqu4UZ0T
 963d3O8QHVnzwC8G75/oReE1enUiEwJl3vWuZ3MIKv06V4uNRc8FsnW9gRyG1B6vg41I
 36NAbQgBKtUJIpzlX1latn1u/kEmjiQu8w+5mZW0sLZGKIPUCX1VxYil6UgtLMsFhaCM
 2r60v+u0HaNUdGNFyCnzGnBuDKzVS9viPwSCAuKKbVsH5d0GiV2G0HiQgPu8nnLRSf0U
 Dn1w==
Message-ID: <90216c45-ce6d-8502-9158-636fbe247ebe@blackwall.org>
Date: Sun, 11 Dec 2022 11:26:02 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20221210145633.1328511-1-idosch@nvidia.com>
 <20221210145633.1328511-13-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221210145633.1328511-13-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 12/14] bridge: mcast: Support
 replacement of MDB port group entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 10/12/2022 16:56, Ido Schimmel wrote:
> Now that user space can specify additional attributes of port group
> entries such as filter mode and source list, it makes sense to allow
> user space to atomically modify these attributes by replacing entries
> instead of forcing user space to delete the entries and add them back.
> 
> Replace MDB port group entries when the 'NLM_F_REPLACE' flag is
> specified in the netlink message header.
> 
> When a (*, G) entry is replaced, update the following attributes: Source
> list, state, filter mode, protocol and flags. If the entry is temporary
> and in EXCLUDE mode, reset the group timer to the group membership
> interval. If the entry is temporary and in INCLUDE mode, reset the
> source timers of associated sources to the group membership interval.
> 
> Examples:
> 
>  # bridge mdb replace dev br0 port dummy10 grp 239.1.1.1 permanent source_list 192.0.2.1,192.0.2.2 filter_mode include
>  # bridge -d -s mdb show
>  dev br0 port dummy10 grp 239.1.1.1 src 192.0.2.2 permanent filter_mode include proto static     0.00
>  dev br0 port dummy10 grp 239.1.1.1 src 192.0.2.1 permanent filter_mode include proto static     0.00
>  dev br0 port dummy10 grp 239.1.1.1 permanent filter_mode include source_list 192.0.2.2/0.00,192.0.2.1/0.00 proto static     0.00
> 
>  # bridge mdb replace dev br0 port dummy10 grp 239.1.1.1 permanent source_list 192.0.2.1,192.0.2.3 filter_mode exclude proto zebra
>  # bridge -d -s mdb show
>  dev br0 port dummy10 grp 239.1.1.1 src 192.0.2.3 permanent filter_mode include proto zebra  blocked    0.00
>  dev br0 port dummy10 grp 239.1.1.1 src 192.0.2.1 permanent filter_mode include proto zebra  blocked    0.00
>  dev br0 port dummy10 grp 239.1.1.1 permanent filter_mode exclude source_list 192.0.2.3/0.00,192.0.2.1/0.00 proto zebra     0.00
> 
>  # bridge mdb replace dev br0 port dummy10 grp 239.1.1.1 temp source_list 192.0.2.4,192.0.2.3 filter_mode include proto bgp
>  # bridge -d -s mdb show
>  dev br0 port dummy10 grp 239.1.1.1 src 192.0.2.4 temp filter_mode include proto bgp     0.00
>  dev br0 port dummy10 grp 239.1.1.1 src 192.0.2.3 temp filter_mode include proto bgp     0.00
>  dev br0 port dummy10 grp 239.1.1.1 temp filter_mode include source_list 192.0.2.4/259.44,192.0.2.3/259.44 proto bgp     0.00
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     * Remove extack from br_mdb_replace_group_sg().
>     * Change 'nlflags' to u16 and move it after 'filter_mode' to pack the
>       structure.
> 
>  net/bridge/br_mdb.c     | 102 ++++++++++++++++++++++++++++++++++++++--
>  net/bridge/br_private.h |   1 +
>  2 files changed, 98 insertions(+), 5 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


