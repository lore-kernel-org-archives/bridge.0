Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A135F821B3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DDA9382174
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1685371804; x=1687963804;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mHZZ92GJ5ZTas5TwDw4/gd16Yq3qwKu+NLw4y0txzO8=;
 b=rzoJFhFQwd8s2j0J7YhRub5SjpCMeLl4XSuJ5tuxJ1gWgsWYZwM/IUDgQvJ33THL1Y
 HQRpxqwQ4LQlX4SHLiJBrjNX6EvsiUVykMAlYInmQsEfkDFzqUHrbBxrMTc67zqz9tKf
 u7hX3Nm1SBoes1oiAsIJityu5J3ca/IqYFmc7bpF32JpIeFM4hIUpkZOIqNng5oynjc4
 fntEcEud09bnR9aniI14YdNxQ+GPcDrQyvT8owt/J5ygvrPJNfqmj8y6+kR+UVVl9cwC
 YVJ52ohCWkgJ+cLe50SgA6CWhBYvcy/LmsSy+1yYV0Pk52jC9AXikoh8YZYBT4So0z6D
 ksdA==
Message-ID: <cae7f2be-cc0b-b6bb-16c5-eb014e07e73f@blackwall.org>
Date: Mon, 29 May 2023 17:50:01 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230529114835.372140-1-idosch@nvidia.com>
 <20230529114835.372140-8-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230529114835.372140-8-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 7/8] mlxsw: spectrum_flower: Add
 ability to match on layer 2 miss
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
> Add the 'fdb_miss' key element to supported key blocks and make use of
> it to match on layer 2 miss.
> 
> The key is only supported on Spectrum-{2,3,4}. An error is returned for
> Spectrum-1 since the key element is not present in any of its key
> blocks.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     * Use 'fdb_miss' key element instead of 'dmac_type'.
> 
>  drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c    | 1 +
>  drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h    | 3 ++-
>  .../net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c    | 2 ++
>  drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c       | 6 ++----
>  4 files changed, 7 insertions(+), 5 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


