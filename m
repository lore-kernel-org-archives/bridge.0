Date: Thu, 10 Mar 2005 18:50:57 -0800
From: "David S. Miller" <davem@davemloft.net>
Message-Id: <20050310185057.05336cd1.davem@davemloft.net>
In-Reply-To: <20050310154434.52f8f561@dxpl.pdx.osdl.net>
References: <20050310154434.52f8f561@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH] (3/4) bridge: get rid of threaded link for
 forwarding timeout
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: netdev@oss.sgi.com, bridge@osdl.org

On Thu, 10 Mar 2005 15:44:34 -0800
Stephen Hemminger <shemminger@osdl.org> wrote:

> For 2.6, I changed the bridge forwarding table timeout code to keep
> a threaded list of in order entries. Well, it turns out that this is
> a performance hit because we end up constantly moving entries around
> in the list.  Later patch changes this to be in place update with RCU.
> 
> This version just uses a 100ms garbage collection timer.
> 
> Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

Applied, thanks.
