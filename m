Date: Fri, 16 Apr 2004 14:15:37 -0700
From: "David S. Miller" <davem@redhat.com>
Message-Id: <20040416141537.74dd31ec.davem@redhat.com>
In-Reply-To: <20040413152440.7e410cd8@dell_ss3.pdx.osdl.net>
References: <20040413151630.710042e3@dell_ss3.pdx.osdl.net>
	<20040413152440.7e410cd8@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH 2.6.5] (4/9) bridge - use ethtool to get port
	speed
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

On Tue, 13 Apr 2004 15:24:40 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> The bridge code needs to keep track of a cost estimate for each
> port in the bridge.  Instead of a hack based on device name, try
> and use ethtool to get port speed from device.  This has been tested
> on e100 (uses ethtool_ops) and e1000 (does ethtool the hard way)
> and dummy (no ethtool).

Looks fine, applied.
