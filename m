Date: Mon, 9 Aug 2004 16:52:37 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: Fw: [Bridge] Re:  Any way of knowing a packet's been defragmented
Message-Id: <20040809165237.18cda881.davem@redhat.com>
In-Reply-To: <20040806091305.4d405664@dell_ss3.pdx.osdl.net>
References: <20040806091305.4d405664@dell_ss3.pdx.osdl.net>
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
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@osdl.org

On Fri, 6 Aug 2004 09:13:05 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> Dave, this patch from Bart De Schuymer <bdschuym@pandora.be> fixes problems
> when using filtering and defragmentation.  The bridge needs to enforce the
> MTU restriction after going through the filtering chain not before, because
> the incoming filter may have reassembled an IP packet, that then needs to
> be fragmented on the output chain.

Applied.
