Date: Fri, 16 Apr 2004 14:22:52 -0700
From: "David S. Miller" <davem@redhat.com>
Message-Id: <20040416142252.05481624.davem@redhat.com>
In-Reply-To: <20040413153308.6e0dd462@dell_ss3.pdx.osdl.net>
References: <20040413151630.710042e3@dell_ss3.pdx.osdl.net>
	<20040413153308.6e0dd462@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH 2.6.5] (8/9) bridge - support lots of 1k ports
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

On Tue, 13 Apr 2004 15:33:08 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> Support >256 ports on a bridge.  Use the suggestion of reducing
> the number of bits of priority and increasing the number of bits
> for port number.

Seems sane, applied.
