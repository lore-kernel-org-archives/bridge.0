Date: Thu, 10 Mar 2005 18:51:52 -0800
From: "David S. Miller" <davem@davemloft.net>
Message-Id: <20050310185152.12ed9819.davem@davemloft.net>
In-Reply-To: <20050310154437.1223b6e9@dxpl.pdx.osdl.net>
References: <20050310154437.1223b6e9@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH] (4/4) bridge: forwarding table lockless update
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: netdev@oss.sgi.com, bridge@lists.osdl.org

On Thu, 10 Mar 2005 15:44:37 -0800
Stephen Hemminger <shemminger@osdl.org> wrote:

> Optimize bridge forwarding table for the fastpath of updating
> an existing entry. Use RCU to find the entry and change it's time.
> Fallback to normal locking for insert. This gives about a 1/3
> improvement in packets forwarding per second on SMP.
> 
> Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

Applied, thanks.
