Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 95696611BD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B3C41611B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1685366294; x=1687958294;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ekH/XPPL11xeKHaj9D6lSLg3OZVj5G8ttFan0W5KnI8=;
 b=g4QHDjpT4S77avoZxAHq41BxBNa4BuJgDXddpg8aHMfKgTdpn9YReZo+21hMlaD6D6
 iItVduypcbFD1PjRrNqqS5/QWJOL91v1aEFHpy+Piv/tQOnuZ/8900d3KLD+6yDZhpm8
 X6wsiZd+yTlVGwf81XT+iF86AUW8ST3rrYJH3d9m6JgVUaln+cfboCE/t06YMe26S0es
 c2sU8/+VTR6vh/mJBoSD0FtL5ey707nXvJBnNTOplj/IuWYkb+eGAvC4KaabeIcV/qqn
 cAFSzamLycnVQmnzCf3uNEYn2E5MOitp6ku2o3dUjWvxoSHLSoFR2oKaiFJPjyWHirkb
 N+SQ==
Message-ID: <cddf6ca0-3c9f-3ee2-1145-f68b3da73fab@blackwall.org>
Date: Mon, 29 May 2023 16:18:11 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230529114835.372140-1-idosch@nvidia.com>
 <20230529114835.372140-3-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230529114835.372140-3-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 2/8] flow_dissector: Dissect layer
 2 miss from tc skb extension
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: taras.chornyi@plvision.eu, petrm@nvidia.com, alexandre.belloni@bootlin.com, jiri@resnulli.us, leon@kernel.org, vladimir.oltean@nxp.com, roopa@nvidia.com, claudiu.manoil@nxp.com, UNGLinuxDriver@microchip.com, edumazet@google.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com, simon.horman@corigine.com, kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, davem@davemloft.net

On 29/05/2023 14:48, Ido Schimmel wrote:
> Extend the 'FLOW_DISSECTOR_KEY_META' key with a new 'l2_miss' field and
> populate it from a field with the same name in the tc skb extension.
> This field is set by the bridge driver for packets that incur an FDB or
> MDB miss.
> 
> The next patch will extend the flower classifier to be able to match on
> layer 2 misses.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     * Split from flower patch.
>     * Use tc skb extension instead of 'skb->l2_miss'.
> 
>  include/net/flow_dissector.h |  2 ++
>  net/core/flow_dissector.c    | 10 ++++++++++
>  2 files changed, 12 insertions(+)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


