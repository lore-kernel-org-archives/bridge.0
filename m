Return-Path: <davem@davemloft.net>
Date: Wed, 18 Mar 2020 16:42:34 -0700 (PDT)
Message-Id: <20200318.164234.1141226942122598740.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200318130325.100508-1-nikolay@cumulusnetworks.com>
References: <20200318130325.100508-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: vlan: include stats in
 dumps if requested
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed, 18 Mar 2020 15:03:25 +0200

> @@ -170,11 +170,13 @@ struct bridge_stp_xstats {
>  /* Bridge vlan RTM header */
>  struct br_vlan_msg {
>  	__u8 family;
> -	__u8 reserved1;
> +	__u8 flags;
>  	__u16 reserved2;
>  	__u32 ifindex;
>  };

I can't allow this for two reasons:

1) Userspace explicitly initializing all members will now get a compile
   failure on the reference to ->reserved1

2) Userspace not initiailizing reserved fields, which worked previously,
   might send in flags that trigger the new behavior.

Sorry, this is UAPI breakage.
