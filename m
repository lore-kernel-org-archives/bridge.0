Date: Mon, 31 Mar 2008 08:42:17 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20080331084217.26bd1d7f@extreme>
In-Reply-To: <4BE92402-91E0-48D2-8A18-2FC659F88685@gmail.com>
References: <4BE92402-91E0-48D2-8A18-2FC659F88685@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridge sysfs port_no overflow
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Osama Abu Elsorour <fobowise@gmail.com>
Cc: bridge@linux-foundation.org

On Mon, 31 Mar 2008 09:11:31 +0200
Osama Abu Elsorour <fobowise@gmail.com> wrote:

> All
> 
> We are running a setup with a large number of bridge ports that  
> reaches the 900 ports. After switching to recent kernel and brctl- 
> utils that uses the sysfs interface, we started noticing that the port  
> numbers are mis-reported when issues the command:
> brctl showmacs br1
> After tracing the code, we found that the problem lies in the sysfs  
> structure called __fdb_entry. The port_no is declared as a u8 while it  
> is u16 in the rest of the bridge structure. This causes the port_no to  
> overflow when the bridge port number exceeds 255.
> 
> The overflow line is in file br_fdb.c function br_fdb_fillbuf:
>                          fe->port_no = f->dst->port_no;
> where left hand port_no is _u8 and right hand is _u16.
> 
> Even if it is unusual to have this number of ports on a single bridge  
> it should be changed to the sake of consistency.
> 	
> This patch shows the change:
> 
> @@ -94,7 +94,7 @@ struct __port_info
> struct __fdb_entry
> {
> 	__u8 mac_addr[6];
> -	__u8 port_no;
> +	__u16 port_no;
> 	__u8 is_local;
> 	__u32 ageing_timer_value;
> 	__u32 unused;

The problem is that this changes the size of the binary data structure
and therefore changes the API. Better to do something with the unused
field and maintain binary compatibility.

Like this:

--- a/include/linux/if_bridge.h	2008-03-31 08:37:57.000000000 -0700
+++ b/include/linux/if_bridge.h	2008-03-31 08:39:02.000000000 -0700
@@ -94,10 +94,11 @@ struct __port_info
 struct __fdb_entry
 {
 	__u8 mac_addr[6];
-	__u8 port_no;
+	__u8 old_port_no;
 	__u8 is_local;
 	__u32 ageing_timer_value;
-	__u32 unused;
+	__u16 port_no;
+	__u16 unused;
 };
 
 #ifdef __KERNEL__
--- a/net/bridge/br_fdb.c	2008-03-31 08:39:23.000000000 -0700
+++ b/net/bridge/br_fdb.c	2008-03-31 08:41:32.000000000 -0700
@@ -285,6 +285,7 @@ int br_fdb_fillbuf(struct net_bridge *br
 
 			/* convert from internal format to API */
 			memcpy(fe->mac_addr, f->addr.addr, ETH_ALEN);
+			fe->old_port_no = f->dst->port_no;
 			fe->port_no = f->dst->port_no;
 			fe->is_local = f->is_local;
 			if (!f->is_static)
