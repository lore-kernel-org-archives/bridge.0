Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=PCjcGLeWxMEylzBxwOcSQmoCFLwBY4GeEPrQDHmN/hY=;
 b=geA+GGrTz3JLPWFWmv855lCH2TrzOQtleq9xQCcvZYkx8Pcwg47lgdJNzni68Cp64p
 Wla75b8GIDQiTGQtNmilmCu/SWFZa58Tacicf6TlInFN+RkF1bCcln+Tdt+bu3SDMlMW
 LESiqBsNlzgULNDuM3ANCXWzxQMUvBJh35yOg=
References: <20200714073458.1939574-1-horatiu.vultur@microchip.com>
 <20200714073458.1939574-5-horatiu.vultur@microchip.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <6267e42e-4f40-db44-e132-98fb29889830@cumulusnetworks.com>
Date: Tue, 14 Jul 2020 16:15:20 +0300
MIME-Version: 1.0
In-Reply-To: <20200714073458.1939574-5-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v4 04/12] bridge: mrp: Extend br_mrp
 for MRP interconnect
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>, roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org, jiri@resnulli.us, ivecera@redhat.com, andrew@lunn.ch, UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org

On 14/07/2020 10:34, Horatiu Vultur wrote:
> This patch extends the 'struct br_mrp' to contain information regarding
> the MRP interconnect. It contains the following:
> - the interconnect port 'i_port', which is NULL if the node doesn't have
>   a interconnect role
> - the interconnect id, which is similar with the ring id, but this field
>   is also part of the MRP_InTest frames.
> - the interconnect role, which can be MIM or MIC.
> - the interconnect state, which can be open or closed.
> - the interconnect delayed_work for sending MRP_InTest frames and check
>   for lost of continuity.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  net/bridge/br_private_mrp.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

> diff --git a/net/bridge/br_private_mrp.h b/net/bridge/br_private_mrp.h
> index 315eb37d89f0f..8841ba847fb29 100644
> --- a/net/bridge/br_private_mrp.h
> +++ b/net/bridge/br_private_mrp.h
> @@ -12,8 +12,10 @@ struct br_mrp {
>  
>  	struct net_bridge_port __rcu	*p_port;
>  	struct net_bridge_port __rcu	*s_port;
> +	struct net_bridge_port __rcu	*i_port;
>  
>  	u32				ring_id;
> +	u16				in_id;
>  	u16				prio;
>  
>  	enum br_mrp_ring_role_type	ring_role;
> @@ -21,6 +23,11 @@ struct br_mrp {
>  	enum br_mrp_ring_state_type	ring_state;
>  	u32				ring_transitions;
>  
> +	enum br_mrp_in_role_type	in_role;
> +	u8				in_role_offloaded;
> +	enum br_mrp_in_state_type	in_state;
> +	u32				in_transitions;
> +
>  	struct delayed_work		test_work;
>  	u32				test_interval;
>  	unsigned long			test_end;
> @@ -28,6 +35,12 @@ struct br_mrp {
>  	u32				test_max_miss;
>  	bool				test_monitor;
>  
> +	struct delayed_work		in_test_work;
> +	u32				in_test_interval;
> +	unsigned long			in_test_end;
> +	u32				in_test_count_miss;
> +	u32				in_test_max_miss;
> +
>  	u32				seq_id;
>  
>  	struct rcu_head			rcu;
> 

