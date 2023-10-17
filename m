Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9973C41518
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 506AF40949
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697533712; x=1698138512;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MTB0PMaH81cPxzWaC0ockKjG/083eP/4X9lYMUVdtT8=;
 b=fy+obZdnpLksIL4xFOkAav/ISMckrWGOGoquYF5Kju29HzQXbFbLSqbZ+mBU5SE1RQ
 XiRDHnnx5v8ECCUl/aHF4eIhdIvV2aJ4NonOTN4r8xMU/ES/Ab9PoMv1O/drNu7pMFHA
 JUnO+TcxoCUXeDoRpGNUCqE+hHCtpNtj8x2KfyWNCOhr6jbdkcTUuXhRkThF9XAcRKJc
 Z8XLJ44G3SgVjfkcghIgwOHyh0aTGhy81j8FUjnAgCmZ8xrpef1AqTH78V6I7qGC1kx1
 G/5Gh279rnOU1rkTdPFW0yUgsEqxKz0SV1G87PMIcBjJ43/nb0m0J2f1OpAW0d0d3eaE
 294g==
Message-ID: <b3e0d656-cb25-3ac8-6391-8fb27217470b@blackwall.org>
Date: Tue, 17 Oct 2023 12:08:30 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20231016131259.3302298-1-idosch@nvidia.com>
 <20231016131259.3302298-8-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231016131259.3302298-8-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 07/13] bridge: add MDB get uAPI
	attributes
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

On 10/16/23 16:12, Ido Schimmel wrote:
> Add MDB get attributes that correspond to the MDB set attributes used in
> RTM_NEWMDB messages. Specifically, add 'MDBA_GET_ENTRY' which will hold
> a 'struct br_mdb_entry' and 'MDBA_GET_ENTRY_ATTRS' which will hold
> 'MDBE_ATTR_*' attributes that are used as indexes (source IP and source
> VNI).
> 
> An example request will look as follows:
> 
> [ struct nlmsghdr ]
> [ struct br_port_msg ]
> [ MDBA_GET_ENTRY ]
> 	struct br_mdb_entry
> [ MDBA_GET_ENTRY_ATTRS ]
> 	[ MDBE_ATTR_SOURCE ]
> 		struct in_addr / struct in6_addr
> 	[ MDBE_ATTR_SRC_VNI ]
> 		u32
> 

Could you please add this info as a comment above the enum?
Similar to the enum below it. It'd be nice to have an example
of what's expected.

> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   include/uapi/linux/if_bridge.h | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
> index f95326fce6bb..7e1bf080b414 100644
> --- a/include/uapi/linux/if_bridge.h
> +++ b/include/uapi/linux/if_bridge.h
> @@ -723,6 +723,14 @@ enum {
>   };
>   #define MDBA_SET_ENTRY_MAX (__MDBA_SET_ENTRY_MAX - 1)
>   
> +enum {
> +	MDBA_GET_ENTRY_UNSPEC,
> +	MDBA_GET_ENTRY,
> +	MDBA_GET_ENTRY_ATTRS,
> +	__MDBA_GET_ENTRY_MAX,
> +};
> +#define MDBA_GET_ENTRY_MAX (__MDBA_GET_ENTRY_MAX - 1)
> +
>   /* [MDBA_SET_ENTRY_ATTRS] = {
>    *    [MDBE_ATTR_xxx]
>    *    ...

