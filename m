Date: Mon, 31 Jan 2005 08:45:35 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Bridge MAC address
Message-ID: <20050131084535.10db250a@dxpl.pdx.osdl.net>
In-Reply-To: <87pszl99je.fsf@aka.i.naked.iki.fi>
References: <87pszl99je.fsf@aka.i.naked.iki.fi>
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
To: bridge@lists.osdl.org

On Mon, 31 Jan 2005 12:29:09 +0200
Nuutti Kotivuori <naked@iki.fi> wrote:

> Sorry, if this question has been answered before, but I could not find
> out with a brief look.
> 
> How can I set the MAC address for a bridge? The MAC address given for
> the bridge device seems to be the one it sends network packets with if
> the bridge device has an IP address set. Apparently the bridge starts
> with a zero MAC address and when the first interface is attached to
> it, it takes its MAC address. When I try to set the MAC address, I
> just get operation unsupported as a result.
> 
> I know I can probably cheat this by making a dummy interface, giving
> it the MAC address I want and then attaching it to the bridge, but
> this is but a crude workaround.
> 
> -- Naked

The question is why do you need to set it at all? If this is some ISP
mac filtering issue, then set it on the first device before putting it into
the bridge.  I would be reluctant to change the bridge driver to accept
MAC address changes because of Spanning Tree and other standards related issues.

-- 
Stephen Hemminger	<shemminger@osdl.org>
