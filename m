Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D31BE81B69
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0E6BF81ADE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date;
 bh=v6Fmj83hx1h9EOaSFrL3lfhYXbz4XGnMveaMkf6jjPQ=;
 b=oWXQ6TZyU38Tt6B0tB5xoeC2txaV/i23+XquBsZIHUlTTdtqpu/uE5zzD2jzVvE+Vf
 WzCR1/U7ZsjhW8WtBnrtoJiP70wvf0AuxhL3i9qedEDUVGMWVGw4N9gRiiUDXYjS3++/
 4flXzd2anBcOIY2h7liTEQb2eNCop6Ymvn29azgWeIx4F8b7viSUyVrZ89YRgpSM35pU
 b4j5EA/AO4GanUxm7eAIIVGMfAWHXxpxTav64KglJnpoMOA3ALHlJpHHmpacUrTkl1po
 wY19mQYdyX7TiiTOKtCqM21IGN5fvYkzdlcnPb8kdOD4eD7PBvqDYiq3siRnzbUhf64t
 eENg==
Message-ID: <78bd0e54-4ee3-bd3c-2154-9eb8b9a70497@blackwall.org>
Date: Tue, 20 Sep 2022 12:16:26 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <cover.1663445339.git.sevinj.aghayeva@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <cover.1663445339.git.sevinj.aghayeva@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH RFC net-next 0/5] net: vlan: fix bridge binding
 behavior and add selftests
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>, netdev@vger.kernel.org
Cc: aroulin@nvidia.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, sbrivio@redhat.com, Eric Dumazet <edumazet@google.com>, roopa@nvidia.com, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On 17/09/2022 23:17, Sevinj Aghayeva wrote:
> When bridge binding is enabled for a vlan interface, it is expected
> that the link state of the vlan interface will track the subset of the
> ports that are also members of the corresponding vlan, rather than
> that of all ports.
> 
> Currently, this feature works as expected when a vlan interface is
> created with bridge binding enabled:
> 
>   ip link add link br name vlan10 type vlan id 10 protocol 802.1q \
>         bridge_binding on
> 
> However, the feature does not work when a vlan interface is created
> with bridge binding disabled, and then enabled later:
> 
>   ip link add link br name vlan10 type vlan id 10 protocol 802.1q \
>         bridge_binding off
>   ip link set vlan10 type vlan bridge_binding on
> 
> After these two commands, the link state of the vlan interface
> continues to track that of all ports, which is inconsistent and
> confusing to users. This series fixes this bug and introduces two
> tests for the valid behavior.
> 
> Sevinj Aghayeva (5):
>   net: core: export call_netdevice_notifiers_info
>   net: core: introduce a new notifier for link-type-specific changes
>   net: 8021q: notify bridge module of bridge-binding flag change
>   net: bridge: handle link-type-specific changes in the bridge module
>   selftests: net: tests for bridge binding behavior
> 
>  include/linux/if_vlan.h                       |   4 +
>  include/linux/netdevice.h                     |   3 +
>  include/linux/notifier_info.h                 |  21 +++
>  net/8021q/vlan.h                              |   2 +-
>  net/8021q/vlan_dev.c                          |  20 ++-
>  net/bridge/br.c                               |   5 +
>  net/bridge/br_private.h                       |   7 +
>  net/bridge/br_vlan.c                          |  18 +++
>  net/core/dev.c                                |   7 +-
>  tools/testing/selftests/net/Makefile          |   1 +
>  .../selftests/net/bridge_vlan_binding_test.sh | 143 ++++++++++++++++++
>  11 files changed, 223 insertions(+), 8 deletions(-)
>  create mode 100644 include/linux/notifier_info.h
>  create mode 100755 tools/testing/selftests/net/bridge_vlan_binding_test.sh
> 

The set looks good to me, the bridge and vlan direct dependency is gone and
the new notification type is used for passing link type specific info.

If the others are ok with it I think you can send it as non-RFC, but I'd give it
a few more days at least. :)

Thanks,
 Nik

