Date: Tue, 25 Nov 2003 17:18:58 -0800
From: "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH][BRIDGE] br.c depends on CONFIG_BRIDGE_NETFILTER, not
	CONFIG_NETFILTER
Message-Id: <20031125171858.2ba03810.davem@redhat.com>
In-Reply-To: <200311260030.21197.bdschuym@pandora.be>
References: <200311260030.21197.bdschuym@pandora.be>
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
To: Bart De Schuymer <bdschuym@pandora.be>
Cc: M.Miroslaw@elka.pw.edu.pl, bridge@osdl.org, shemminger@osdl.org

On Wed, 26 Nov 2003 00:30:21 +0100
Bart De Schuymer <bdschuym@pandora.be> wrote:

> The patch below lets the bridge compile when CONFIG_BRIDGE_NETFILTER
> isn't enabled.
> This patch is an update of M.J. Miroslaw's patch that arrived through
> private mail.

Applied, thanks guys.
