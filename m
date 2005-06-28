Date: Tue, 28 Jun 2005 09:48:40 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Possibility of  copying over fdb entries.
Message-ID: <20050628094840.6c2e381b@dxpl.pdx.osdl.net>
In-Reply-To: <42C0F0E2.1000501@smartbridges.com>
References: <42C0F0E2.1000501@smartbridges.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: munro <munro.biswal@smartbridges.com>
Cc: bridge@lists.osdl.org

On Tue, 28 Jun 2005 14:40:34 +0800
munro <munro.biswal@smartbridges.com> wrote:

> 
> 
> Hi, all,
> 
> I wish to copy over fdb(forwarding database  entries) learnt over from 
> one interface  onto  as  they are from another interface.
> 
> Like for eg :
>  brctl showmacs br0
> port no mac addr                is local?       ageing timer
>   1     00:30:1a:01:6f:e4       no                 0.46
>   1     00:30:1a:1c:3d:b7       yes                0.00
>   2     00:30:1a:1c:3d:b8       yes                0.00
> 
> Instead of the above in line 1 if i wish to forcefully add mac  "  
> 00:30:1a:01:6f:e4 "  from port 2 instated of port 1.

Why? What reason.

> Do i need to create a separate ioctl for it from the brctl to the kernel 
> code or is thier some provision for doing it.

Since all enhancements can be 2.6 only,
I would prefer a sysfs interface to an ioctl to do this.
You can add a store/write interface to /sys/class/net/brX/bridge/brforward
file.  The creative part is figuring out what the semantics should
be and getting the locking right.
