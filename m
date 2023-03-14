Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BA79940919
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8BB6140354
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112; t=1678794192;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MCrsF1Bkt9UxCTo/05ahhMR6IA2FanOVtp8JvR2CXcc=;
 b=mRixeqMfSYUD/Ww8F7phJ61EE22o699N+ef7bjGAnnpvqg78eN/3vGhiV/g1Ak7qyJ
 EgObHJqU9BxCXL3+eu11BJBn62LAr0sNifx1p2Iudhx5lAIK1Kz3+HRBg2XLWoDVzqmC
 IHW+P9HQje9rVz8XbDBi+tfyCs6Z/qV1OH7EzBFNOdvHBfrYwrdN/0BobmqzVj5HDnpn
 9Tryc8C7qp8ACWJ2j+3STRCtSQO8X4qdF4QU0TqpdYIPJSy/TobUn98OlpLpqc+X8ckq
 /yB4fwRZSuc9B6pPlZTv4NXbQcwdKaOtEU6xXfvQHoLwuWGSB4LAqwg97KAA7oXt09hw
 xJnA==
Message-ID: <d4a39646-ed81-d900-6cd7-a87c561f8049@blackwall.org>
Date: Tue, 14 Mar 2023 13:43:11 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20230313145349.3557231-1-idosch@nvidia.com>
 <20230313145349.3557231-3-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230313145349.3557231-3-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 02/11] bridge: mcast: Implement MDB
 net device operations
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, mlxsw@nvidia.com, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 13/03/2023 16:53, Ido Schimmel wrote:
> Implement the previously added MDB net device operations in the bridge
> driver so that they could be invoked by core rtnetlink code in the next
> patch.
> 
> The operations are identical to the existing br_mdb_{dump,add,del}
> functions. The '_new' suffix will be removed in the next patch. The
> functions are re-implemented in this patch to make the conversion in the
> next patch easier to review.
> 
> Add dummy implementations when 'CONFIG_BRIDGE_IGMP_SNOOPING' is
> disabled, so that an error will be returned to user space when it is
> trying to add or delete an MDB entry. This is consistent with existing
> behavior where the bridge driver does not even register rtnetlink
> handlers for RTM_{NEW,DEL,GET}MDB messages when this Kconfig option is
> disabled.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_device.c  |   3 +
>  net/bridge/br_mdb.c     | 124 ++++++++++++++++++++++++++++++++++++++++
>  net/bridge/br_private.h |  25 ++++++++
>  3 files changed, 152 insertions(+)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


