Date: Mon, 29 Nov 2004 10:24:32 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] bridge in 'hub' mode possible?
Message-Id: <20041129102432.24888dad@zqx3.pdx.osdl.net>
In-Reply-To: <87d5xw4uui.fsf@aka.i.naked.iki.fi>
References: <87d5xw4uui.fsf@aka.i.naked.iki.fi>
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
To: Nuutti Kotivuori <naked@iki.fi>
Cc: bridge@osdl.org

On Mon, 29 Nov 2004 16:01:57 +0200
Nuutti Kotivuori <naked@iki.fi> wrote:

> Is it somehow possible to configure a bridge in 'hub' mode. So that
> every packet sent from a 'port' (eg. an interface) is delivered to
> every other 'port' on the bridge.

No. The bridge needs to try and stay true to the IEEE 802.2 specification.

> That is, effectively to just turn off MAC address learning and treat
> all packets on the bridge level effectively as broadcasts.

Why, are you trying to work around flaws in the underlying Ethernet
layer. If so, fix it there.


> Or could this be done with some ebtables hack?

Yes

> Suggestions appreciated,
> -- Naked
> 
> 
> 
