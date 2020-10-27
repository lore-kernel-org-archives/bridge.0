Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fp9DOIG89yQphhVtnUaB6Uhgg6cfJ/f6CEZSpcBxAQ4=;
 b=UYbkYuZz+V4mrSNGV9sOj772Km/E4ZB7bT64Rbq2OmBMBkMYpC/7uQ71Ta7B2pS0a2
 WLcDodpDC1YTDYaBRw1CbZbZOSp5ejCOMFhRTSm3DDK3rUHnvIQVXpUAP7h/bavtyd9B
 AffszAuFp9L/C2x3u4KNpH126oHbtsOE0aVWv7t3FTD3lS67vj/zsohznzCAa6YABlL2
 3edS17Pwz9ME/qPhAlc7lKiLmqmxq9d8kGG0ADppn1UWSKP1c9YqopZqB7918qfr+ep/
 r2T39MEnfS2D3B9VQosD2qQEohJjelHEvQu8vgQdqqd5Z/sg+A0mgpmrBvaNIuXBQI0p
 YG4A==
Date: Tue, 27 Oct 2020 07:59:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20201027075921.69976131@hermes.local>
In-Reply-To: <20201027100251.3241719-2-henrik.bjoernlund@microchip.com>
References: <20201027100251.3241719-1-henrik.bjoernlund@microchip.com>
 <20201027100251.3241719-2-henrik.bjoernlund@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v7 01/10] net: bridge: extend the
 process of special frames
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Henrik Bjoernlund via Bridge <bridge@lists.linux-foundation.org>
Cc: netdev@vger.kernel.org, jiri@mellanox.com, linux-kernel@vger.kernel.org, idosch@mellanox.com, Henrik Bjoernlund <henrik.bjoernlund@microchip.com>, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, UNGLinuxDriver@microchip.com, Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net

On Tue, 27 Oct 2020 10:02:42 +0000
Henrik Bjoernlund via Bridge <bridge@lists.linux-foundation.org> wrote:

> +/* Return 0 if the frame was not processed otherwise 1
> + * note: already called with rcu_read_lock
> + */
> +static int br_process_frame_type(struct net_bridge_port *p,
> +				 struct sk_buff *skb)
> +{
> +	struct br_frame_type *tmp;
> +
> +	hlist_for_each_entry_rcu(tmp, &p->br->frame_type_list, list)
> +		if (unlikely(tmp->type == skb->protocol))
> +			return tmp->frame_handler(p, skb);
> +
> +	return 0;
> +}

Does the linear search of frame types have noticable impact on performance?
Hint: maybe a bitmap or something would be faster.
