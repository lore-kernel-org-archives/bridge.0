Date: Fri, 9 Jul 2004 16:45:32 -0700
From: "David S. Miller" <davem@redhat.com>
Message-Id: <20040709164532.22202ce2.davem@redhat.com>
In-Reply-To: <20040708104143.67210e39@dell_ss3.pdx.osdl.net>
References: <20040708104143.67210e39@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH 2.6] bridge -- support different MTU sizes
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

On Thu, 8 Jul 2004 10:41:43 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> This patch adds support for different size MTU's to bridging.
> It is useful for bridging Ethernet's with jumbo frames, etc.
> 
> The mtu of the bridge pseudo-device is maintained as the minimum
> of all the underlying ports.  And when forwarding a frame through
> the bridge, it will drop the frame if the outgoing port's MTU
> is less than the frame size (as per 802 standard).

Looks fine, applied.
