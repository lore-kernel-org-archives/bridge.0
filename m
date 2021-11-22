Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=7AB/rq
 zonUOWzLAzTKIR/r2isQMsfo/GkiwD4h91rPk=; b=Akr3wk7NneWaUex6gfdwC6
 e0KL0P7VzRwGjLuFL7R8Oi+JaazQk8xb+7CjQFxwgIufRHr24cno03AtgGOMc9d3
 qgCS3uRRtLm1VsYKH+pRGx7LObiuRURpBEV9934LzBhl4BO2jsXACOFqU+lpLbYA
 en8N549cMme6P4rmduc+oIo9M+O3+UXtIoV+QOk4q7DJaQCKXZVKPwqfQaXC/Nwk
 2YD4Sf11QRo1GDyYbEDKRfoUYuDGK166iVS1RDKd2vm3N8kPspPZ1eBlUXs7PSmO
 AKNAWVi3RAc9YV4ItosimB+veoxFZEeihYSufuVYi04SHEFMBiVGSeq1n2giJDHA
 ==
Date: Mon, 22 Nov 2021 12:04:35 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <YZtrM3Ukz7rKfNLN@shredder>
References: <20211119020642.108397-1-bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119020642.108397-1-bernard@vivo.com>
Subject: Re: [Bridge] [PATCH] net/bridge: replace simple_strtoul to kstrtol
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Bernard Zhao <bernard@vivo.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

On Thu, Nov 18, 2021 at 06:06:42PM -0800, Bernard Zhao wrote:
> simple_strtoull is obsolete, use kstrtol instead.
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  net/bridge/br_sysfs_br.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
> index d9a89ddd0331..11c490694296 100644
> --- a/net/bridge/br_sysfs_br.c
> +++ b/net/bridge/br_sysfs_br.c
> @@ -36,15 +36,14 @@ static ssize_t store_bridge_parm(struct device *d,
>  	struct net_bridge *br = to_bridge(d);
>  	struct netlink_ext_ack extack = {0};
>  	unsigned long val;
> -	char *endp;
>  	int err;
>  
>  	if (!ns_capable(dev_net(br->dev)->user_ns, CAP_NET_ADMIN))
>  		return -EPERM;
>  
> -	val = simple_strtoul(buf, &endp, 0);
> -	if (endp == buf)
> -		return -EINVAL;
> +	err = kstrtoul(buf, 10, &val);

Base 16 is valid.

Before this patch:

# ip link add name br0 type bridge vlan_filtering 1
# echo "0x88a8" > /sys/class/net/br0/bridge/vlan_protocol
# echo $?
0

After this patch:

# ip link add name br0 type bridge vlan_filtering 1
# echo "0x88a8" > /sys/class/net/br0/bridge/vlan_protocol 
bash: echo: write error: Invalid argument

> +	if (err != 0)
> +		return err;
>  
>  	if (!rtnl_trylock())
>  		return restart_syscall();
> -- 
> 2.33.1
> 
