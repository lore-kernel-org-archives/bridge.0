Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BAB41418A8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2FACB418A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YKJw2qpF3iJxcC8WpvUyBdGxAEqGRGDuO70Dlx4m/SM=;
 b=phft8sgdI/bymGOE9M77QzP+qBHNW01yWqM+P73mHM9JVCzbekbC2ZEV1AEzvHfslD
 yqwzoi2yHaUb0WubzsnBgfg9YF5OHEWoPlWzKpr3dI9BNc0uDJZwGkxj2JyfEzxTKXjM
 xdLWYWZtaC6LFXbHGeYM4ZBcRaklt81h0qjhnMz6Vr/LOl+JYncoE5P0U2EGs4D2KIQg
 XHc8Ik49gwa9FOilvhqNppuoFoqgFelCgK/SWOC2Omb2NyKQbp3cf7UzTaX9D8W+WCsn
 cAx9r9kt15jvbYSh6f6sqbMgzXhYbouWps1PjdktRq4fjLSv5+15iOx2PF4yOiXMoIFr
 kjyQ==
Message-ID: <c8ca33cd-f0eb-e917-3fb3-c00a0f0ed753@blackwall.org>
Date: Tue, 18 Oct 2022 11:37:30 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20221018064001.518841-1-idosch@nvidia.com>
 <20221018064001.518841-4-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221018064001.518841-4-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 3/4] bridge: mcast: Use spin_lock()
 instead of spin_lock_bh()
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

On 18/10/2022 09:40, Ido Schimmel wrote:
> IGMPv3 / MLDv2 Membership Reports are only processed from the data path
> with softIRQ disabled, so there is no need to call spin_lock_bh(). Use
> spin_lock() instead.
> 
> This is consistent with how other IGMP / MLD packets are processed.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_multicast.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

