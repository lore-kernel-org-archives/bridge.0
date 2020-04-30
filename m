Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lJmhJmuG1IWJED6rmkx8pwPYj9TB5d9M3E2doIVmkRs=;
 b=fASOuBt8zE/+5tGQ1qY43ZGmu7xs3H/w9z3Pm/vJuvfUa2asOH8b4HVp+BzFYW2gq9
 k/vAAX9bsEroUhXniLEqBNheSAyqquWOoBWhfRRhPTtM6BNPU/YY6wRnpLXIHX5op9zn
 oX5+7hg/ULQ559d9tT1q7s9x1uq1m04Av3I1A=
References: <20200430193845.4087868-1-idosch@idosch.org>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <ab70b93d-c296-402e-865f-c96be764e7a3@cumulusnetworks.com>
Date: Thu, 30 Apr 2020 23:25:40 +0300
MIME-Version: 1.0
In-Reply-To: <20200430193845.4087868-1-idosch@idosch.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: vlan: Add a schedule point
 during VLAN processing
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@mellanox.com, s.priebe@profihost.ag, roopa@cumulusnetworks.com, Ido Schimmel <idosch@mellanox.com>, kuba@kernel.org, davem@davemloft.net

On 30/04/2020 22:38, Ido Schimmel wrote:
> From: Ido Schimmel <idosch@mellanox.com>
> 
> User space can request to delete a range of VLANs from a bridge slave in
> one netlink request. For each deleted VLAN the FDB needs to be traversed
> in order to flush all the affected entries.
> 
> If a large range of VLANs is deleted and the number of FDB entries is
> large or the FDB lock is contented, it is possible for the kernel to
> loop through the deleted VLANs for a long time. In case preemption is
> disabled, this can result in a soft lockup.
> 
> Fix this by adding a schedule point after each VLAN is deleted to yield
> the CPU, if needed. This is safe because the VLANs are traversed in
> process context.
> 
> Fixes: bdced7ef7838 ("bridge: support for multiple vlans and vlan ranges in setlink and dellink requests")
> Signed-off-by: Ido Schimmel <idosch@mellanox.com>
> Reported-by: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
> Tested-by: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
> ---
>  net/bridge/br_netlink.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 43dab4066f91..a0f5dbee8f9c 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -612,6 +612,7 @@ int br_process_vlan_info(struct net_bridge *br,
>  					       v - 1, rtm_cmd);
>  				v_change_start = 0;
>  			}
> +			cond_resched();
>  		}
>  		/* v_change_start is set only if the last/whole range changed */
>  		if (v_change_start)
> 

Looks good, thanks!
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
