Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 45D1E60B46
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4A4AE60AAE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KSkxp9G2CF6S5rppPANiUey7SnfmSrWPD2ZRfSXSe9c=;
 b=wporLZhgoBS3JLFLF2lvV7ZmfJIVRMqul3s5HKG80kGORLsusrqamCFfWUi4gk//e7
 6sAo17PByF0+HJALTxuNovlahMVA+t+gx8r76/bqrEuPYySgzz5+6x0ZLVuFOJwnQZS+
 8Qejh6dBMku5x155Tx0Eosw3KFuIrnqjRcHX9LS62EZWDeM+8IU6q6plOSXvbtHJ+rIM
 UNmYQe87Nkz4Jn+LeUnB7vbjVb85ApvduXTFEpXWjifr+wxImEHBxVwLAQnVhv0ufpHS
 GpXBBcl6fu3s5B0D8W0ThrJH2hL3UZVtVwbJtqMuVKj2ukipe3nr9dyDqOIkbedwdL0t
 dfqw==
Message-ID: <6f71f4e4-9224-efa0-dbe2-e1b35b5526e2@blackwall.org>
Date: Fri, 9 Dec 2022 09:27:01 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20221208152839.1016350-1-idosch@nvidia.com>
 <20221208152839.1016350-2-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221208152839.1016350-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 01/14] bridge: mcast: Do not derive
 entry type from its filter mode
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

On 08/12/2022 17:28, Ido Schimmel wrote:
> Currently, the filter mode (i.e., INCLUDE / EXCLUDE) of MDB entries
> cannot be set from user space. Instead, it is set by the kernel
> according to the entry type: (*, G) entries are treated as EXCLUDE and
> (S, G) entries are treated as INCLUDE. This allows the kernel to derive
> the entry type from its filter mode.
> 
> Subsequent patches will allow user space to set the filter mode of (*,
> G) entries, making the current assumption incorrect.
> 
> As a preparation, remove the current assumption and instead determine
> the entry type from its key, which is a more direct way.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_mdb.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
> index ae7d93c08880..2b6921dbdc02 100644
> --- a/net/bridge/br_mdb.c
> +++ b/net/bridge/br_mdb.c
> @@ -857,17 +857,14 @@ static int br_mdb_add_group(const struct br_mdb_config *cfg,
>  	 * added to it for proper replication
>  	 */
>  	if (br_multicast_should_handle_mode(brmctx, group.proto)) {
> -		switch (filter_mode) {
> -		case MCAST_EXCLUDE:
> -			br_multicast_star_g_handle_mode(p, MCAST_EXCLUDE);
> -			break;
> -		case MCAST_INCLUDE:
> +		if (br_multicast_is_star_g(&group)) {
> +			br_multicast_star_g_handle_mode(p, filter_mode);
> +		} else {
>  			star_group = p->key.addr;
>  			memset(&star_group.src, 0, sizeof(star_group.src));
>  			star_mp = br_mdb_ip_get(br, &star_group);
>  			if (star_mp)
>  				br_multicast_sg_add_exclude_ports(star_mp, p);
> -			break;
>  		}
>  	}
>  

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

