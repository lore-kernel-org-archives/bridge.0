Date: Mon, 17 Dec 2007 08:53:49 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] [PATCH] Add vlan id to bridge forward database
Message-ID: <20071217085349.729e5c17@deepthought>
In-Reply-To: <4766a3d1.02ab100a.0be8.6fdc@mx.google.com>
References: <4766a3d1.02ab100a.0be8.6fdc@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jaime Medrano <jaime.medrano@gmail.com>
Cc: bridge@lists.osdl.org

On Mon, 17 Dec 2007 17:13:09 +0100
Jaime Medrano <jaime.medrano@gmail.com> wrote:

> Hi!
> 
> This makes forwarding table aware of 802.1Q vlan ids and stores
> id with MACs in the table.
> 
> It solves problems when having same MAC on diffent pairs
> (vlan, port). Current code gets confused at that situation.
> 
> Local MACs are managed as present on every vlan.
> 
> Signed-off-by: Jaime Medrano <jaime.medrano@gmail.com>

What about the nested vlan case?

I assume it continues to work without Vlan's.
How does this affect use of the userspace RSTP?


> --- linux-2.6.23.orig/include/linux/if_bridge.h	2007-12-17 11:59:46.000000000 +0100
> +++ linux-2.6.23/include/linux/if_bridge.h	2007-12-17 12:00:28.000000000 +0100
> @@ -97,7 +97,8 @@
>  	__u8 port_no;
>  	__u8 is_local;
>  	__u32 ageing_timer_value;
> -	__u32 unused;
> +	__u16 vlan_id;
> +	__u16 unused;
>  };

This is a user/kernel ABI change. Does it break old tools?


-- 
Stephen Hemminger <shemminger@linux-foundation.org>
