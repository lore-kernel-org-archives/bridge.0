Date: Fri, 16 Apr 2004 14:14:25 -0700
From: "David S. Miller" <davem@redhat.com>
Message-Id: <20040416141425.37bb59d8.davem@redhat.com>
In-Reply-To: <20040413152037.5e28054d@dell_ss3.pdx.osdl.net>
References: <20040413151630.710042e3@dell_ss3.pdx.osdl.net>
	<20040413152037.5e28054d@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH 2.6.5] (3/9) bridge - jiffies_to_clock
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

On Tue, 13 Apr 2004 15:20:37 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> Rather than doing the math directly, use jiffies_to_clock functions
> to convert from user hz to jiffies.

Applied.
