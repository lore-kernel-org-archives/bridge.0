Date: Fri, 16 Apr 2004 14:22:09 -0700
From: "David S. Miller" <davem@redhat.com>
Message-Id: <20040416142209.04913f56.davem@redhat.com>
In-Reply-To: <20040413153046.4f47fe0f@dell_ss3.pdx.osdl.net>
References: <20040413151630.710042e3@dell_ss3.pdx.osdl.net>
	<20040413153046.4f47fe0f@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH 2.6.5] (7/9) bridge - STP unsigned fields
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

On Tue, 13 Apr 2004 15:30:46 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> Use correct types for fields related to spanning tree protocols.
>   * costs are 32 bit unsigned
>   * ports are 16 bit unsigned
>   * booleans are bytes rather than bitfield
>   * arrange for better packing

Applied.
