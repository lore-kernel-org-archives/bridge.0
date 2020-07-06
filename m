Return-Path: <davem@davemloft.net>
Date: Mon, 06 Jul 2020 12:27:48 -0700 (PDT)
Message-Id: <20200706.122748.828248704525141203.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200706091842.3324565-3-horatiu.vultur@microchip.com>
References: <20200706091842.3324565-1-horatiu.vultur@microchip.com>
 <20200706091842.3324565-3-horatiu.vultur@microchip.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 02/12] bridge: uapi: mrp: Extend MRP
 attributes for MRP interconnect
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: horatiu.vultur@microchip.com
Cc: ivecera@redhat.com, andrew@lunn.ch, jiri@resnulli.us, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, kuba@kernel.org

From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Mon, 6 Jul 2020 11:18:32 +0200

> +struct br_mrp_in_state {
> +	__u16 in_id;
> +	__u32 in_state;
> +};

Put the __u32 first then the __u16.

> +struct br_mrp_in_role {
> +	__u16 in_id;
> +	__u32 ring_id;
> +	__u32 in_role;
> +	__u32 i_ifindex;
> +};

Likewise.

> +struct br_mrp_start_in_test {
> +	__u16 in_id;
> +	__u32 interval;
> +	__u32 max_miss;
> +	__u32 period;
> +};

Likewise.

> +struct br_mrp_in_test_hdr {
> +	__be16 id;
> +	__u8 sa[ETH_ALEN];
> +	__be16 port_role;
> +	__be16 state;
> +	__be16 transitions;
> +	__be32 timestamp;
> +};

Likewise.  Put the larger members first.  There is lots of unnecessary
padding in this structure.

