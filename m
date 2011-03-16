Date: Wed, 16 Mar 2011 09:41:56 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20110316094156.204e4903@nehalam>
In-Reply-To: <4D80BC5B0200007800036D85@vpn.id2.novell.com>
References: <4D80BC5B0200007800036D85@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] build breakage due to br_multicast.c referencing
 ipv6_dev_get_saddr()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jan Beulich <JBeulich@novell.com>
Cc: bridge@lists.linux-foundation.org, linus.luessing@web.de, davem@davemloft.net, netdev@vger.kernel.org

On Wed, 16 Mar 2011 12:34:19 +0000
"Jan Beulich" <JBeulich@novell.com> wrote:

> With BRIDGE=y and IPV6=m commit
> fe29ec41aaa51902aebd63658dfb04fe6fea8be5 ("bridge: Use IPv6
> link-local address for multicast listener queries") causes the build to
> break.

I have no problem building with 2.6.38 and BRIDGE=y and IPV6=m.
Blacklisting ipv6 module is just self inflicted pain, don't do it.


