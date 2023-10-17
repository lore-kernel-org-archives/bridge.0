Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5C99440949
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4D5F240438
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697535124; x=1698139924;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3kgbT4HUwVO3dRrS+UXwvsR6kcnDepF12o+Z+tvmQWQ=;
 b=tyOAzvG5t7HfiOOXKC4GP1E/NzUDDafLR4J739RS3dyNktrfJyZnuTP5jIk0AYeha6
 jgZ0uGEDkJSAxZuqEKJ4j31zJChKuO57tYJcAM5ZRo5h6o7jxZuPpWgb9P1AWDAqc5pA
 KfNsjkhLQdNhBJRsjxkzmIZjA+/r5GrKDw4vT3/5HqB5iXUKuwpR7KeRfVs1jmvavbAC
 dMs+thW5TYXvpKi6GLHt8n686z/o3togdj6tRRYlF6ShxQtJv11LWskd0TIe9pzlK3DU
 GS7bR+LVcTVpewuaTnElX5Zw7PQdTk+QFSTMDtOVd2BxEctyiwl7ViATdejTuPex9Qom
 IT3A==
Message-ID: <f4657a17-1b81-f8e3-a781-714f1dc5174f@blackwall.org>
Date: Tue, 17 Oct 2023 12:32:01 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20231016-fdb_limit-v5-0-32cddff87758@avm.de>
 <20231016-fdb_limit-v5-4-32cddff87758@avm.de>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231016-fdb_limit-v5-4-32cddff87758@avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v5 4/5] net: bridge: Set
 strict_start_type for br_policy
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Johannes Nixdorf <jnixdorf-oss@avm.de>, "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, David Ahern <dsahern@gmail.com>, Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Oleksij Rempel <linux@rempel-privat.de>, Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, Shuah Khan <shuah@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

On 10/16/23 16:27, Johannes Nixdorf wrote:
> Set any new attributes added to br_policy to be parsed strictly, to
> prevent userspace from passing garbage.
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
> ---
>   net/bridge/br_netlink.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 0c3cf6e6dea2..5ad4abfcb7ba 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -1229,6 +1229,8 @@ static size_t br_port_get_slave_size(const struct net_device *brdev,
>   }
>   
>   static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
> +	[IFLA_BR_UNSPEC]	= { .strict_start_type =
> +				    IFLA_BR_FDB_N_LEARNED },
>   	[IFLA_BR_FORWARD_DELAY]	= { .type = NLA_U32 },
>   	[IFLA_BR_HELLO_TIME]	= { .type = NLA_U32 },
>   	[IFLA_BR_MAX_AGE]	= { .type = NLA_U32 },
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

