Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BC34340644
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BFA494063C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1685366361; x=1687958361;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7liou2UMGklqRO9dLDDOCk0JRNw6KtAVNVlIZMEBmcs=;
 b=KLEPR262FOslxo55V+tYUh11CnbmuKwlngkBTAky1p8umNg5QkIQI38Z+WeJjBGE12
 mTo1wstdR1L3Nc60NQMJ84pybpUYD7b8Qki9ssLYEfDB2lWGw0jpHfVDwGs3T0twMVi/
 6ka5i2joKgJKGAltya1QnjrVtLEV6/cKNa+2v4khPlSqLl1NY17cP9b84mtZwbzsO+Qk
 tcfzeuzvWocAmamqtjZo7aAeew57i4swF3AbZkCZ7Y8U1IfVIgquLHvnMHVzlEb24sUa
 H1wCIkOEINjeqd6IrFGY8B5WA4yUTRjvJqQIKHcWa/MVAWMCSMBgbiUArnVIzW8N/5S4
 V2AA==
Message-ID: <a6d5285b-641e-16a1-ca29-2d020b628ff8@blackwall.org>
Date: Mon, 29 May 2023 16:19:18 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230529114835.372140-1-idosch@nvidia.com>
 <20230529114835.372140-5-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230529114835.372140-5-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 4/8] flow_offload: Reject matching
 on layer 2 miss
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
> Adjust drivers that support the 'FLOW_DISSECTOR_KEY_META' key to reject
> filters that try to match on the newly added layer 2 miss field. Add an
> extack message to clearly communicate the failure reason to user space.
> 
> The following users were not patched:
> 
> 1. mtk_flow_offload_replace(): Only checks that the key is present, but
>    does not do anything with it.
> 2. mlx5_tc_ct_set_tuple_match(): Used as part of netfilter offload,
>    which does not make use of the new field, unlike tc.
> 3. get_netdev_from_rule() in nfp: Likewise.
> 
> Example:
> 
>  # tc filter add dev swp1 egress pref 1 proto all flower skip_sw l2_miss true action drop
>  Error: mlxsw_spectrum: Can't match on "l2_miss".
>  We have an error talking to the kernel
> 
> Acked-by: Elad Nachman <enachman@marvell.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     * Expand commit message to explain why some users were not patched.
> 
>  .../net/ethernet/marvell/prestera/prestera_flower.c    |  6 ++++++
>  drivers/net/ethernet/mellanox/mlx5/core/en_tc.c        |  6 ++++++
>  drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c  |  6 ++++++
>  drivers/net/ethernet/mscc/ocelot_flower.c              | 10 ++++++++++
>  4 files changed, 28 insertions(+)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


