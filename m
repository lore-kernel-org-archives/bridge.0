Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=50psdwGjwNe2pJ4DSaYhTcmVWCoftD7MRjYtXnX2qCQ=;
 b=tXCAoxKSY4Ym7sDR97jqh3BbTpQidmXYx7wKwDDzkLiS7MtelzXSP8Z4qGMStp6A7+
 S18qwHVIN7/frrWjKDVuOEja7Ij5PvQ6WxKFWzaqcUhIpQyoidroi/uvA3hlR/StVx29
 cH8trN/NlalcyzsSkKsvmrSqZ2EA0a4hg/88tJS9z5E6vm99DRepSQHKt4omQHBXZHC0
 vqKDdQqWaMip6jY4kP0EbQJ+sVs5jmK6cEaK7VUPtCsRFqn3/F2ODTZN5gcgENOQDcpL
 kqrkK+ykI98L6hKYpgJqL68vx9WMM4hZcC/RpxbkvtK8nnlNIPeRaEEaeomyjozFuvVE
 aQFQ==
Message-ID: <6c8e95fc-ce18-08ab-7d6a-cc345a641dc2@blackwall.org>
Date: Wed, 13 Apr 2022 01:44:00 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20220412132245.2148794-1-razor@blackwall.org>
 <20220412132245.2148794-5-razor@blackwall.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220412132245.2148794-5-razor@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 4/8] net: bridge: fdb: add
	ndo_fdb_del_bulk
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org, bridge@lists.linux-foundation.org, idosch@idosch.org, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

On 4/12/22 16:22, Nikolay Aleksandrov wrote:
> Add a minimal ndo_fdb_del_bulk implementation which flushes all entries.
> Support for more fine-grained filtering will be added in the following
> patches.
> 
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>   net/bridge/br_device.c   |  1 +
>   net/bridge/br_fdb.c      | 25 ++++++++++++++++++++++++-
>   net/bridge/br_netlink.c  |  2 +-
>   net/bridge/br_private.h  |  6 +++++-
>   net/bridge/br_sysfs_br.c |  2 +-
>   5 files changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
> index 8d6bab244c4a..58a4f70e01e3 100644
> --- a/net/bridge/br_device.c
> +++ b/net/bridge/br_device.c
> @@ -465,6 +465,7 @@ static const struct net_device_ops br_netdev_ops = {
>   	.ndo_fix_features        = br_fix_features,
>   	.ndo_fdb_add		 = br_fdb_add,
>   	.ndo_fdb_del		 = br_fdb_delete,
> +	.ndo_fdb_del_bulk	 = br_fdb_delete_bulk,
>   	.ndo_fdb_dump		 = br_fdb_dump,
>   	.ndo_fdb_get		 = br_fdb_get,
>   	.ndo_bridge_getlink	 = br_getlink,
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index 6ccda68bd473..fd7012c32cd5 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -559,7 +559,7 @@ void br_fdb_cleanup(struct work_struct *work)
>   }
>   
>   /* Completely flush all dynamic entries in forwarding database.*/
> -void br_fdb_flush(struct net_bridge *br)
> +void __br_fdb_flush(struct net_bridge *br)

hmm, actually the rename is not really necessary with the new naming

