Date: Mon, 2 Aug 2004 13:19:46 -0700
From: "David S. Miller" <davem@redhat.com>
Message-Id: <20040802131946.28f09d3a.davem@redhat.com>
In-Reply-To: <20040802130840.434c409b@dell_ss3.pdx.osdl.net>
References: <20040802153128.GA5423@man.manty.net>
	<20040802130840.434c409b@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH] 2.4.27-rc4 bridge fix
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@osdl.org, netdev@osd.org, manty@manty.net, marcelo.tosatti@cyclades.com.br

On Mon, 2 Aug 2004 13:08:40 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> The problem was that the br_add_bridge ended up calling register_netdev
> that did a rtnl_lock.  This fixes that, and gets rid of the bridge_list,
> there is no need to keep a separate device list of just bridges.  By not
> having multiple lists, races are avoided. 

Marcelo, please apply this.

Thanks.
