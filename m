Date: Thu, 2 Dec 2004 16:45:59 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20041202164559.429d90e8@dxpl.pdx.osdl.net>
In-Reply-To: <41AF57D7.10608@nefty.hu>
References: <41AF57D7.10608@nefty.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: IPv6 bridging
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Zoltan NAGY <nagyz@nefty.hu>
Cc: bridge@osdl.org, linux-kernel@vger.kernel.org

On Thu, 02 Dec 2004 18:58:47 +0100
Zoltan NAGY <nagyz@nefty.hu> wrote:

> Hello!
> 
> Is it possible to bridge ip tunnels (IPv6 in IPv4)? brctl gives me an 
> error "Invalid argument",
> and from strace it seems it misses some ioctls from kernel...

That is because the bridge code works at the Ethernet level.
It is an 802 Ethernet bridge, not an IP tunnel.


> any ideas?
> 
> I need it to be able to give my UMLs a public ipv6 address.
> 
> Regrads,
> 
> Zoltan NAGY,
> Software Engineer
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
