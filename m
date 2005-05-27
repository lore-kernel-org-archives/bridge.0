Date: Fri, 27 May 2005 08:59:24 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Re: [PATCH] (6/6) bridge: receive path optimization
Message-ID: <20050527085924.720ba7ef@dxpl.pdx.osdl.net>
In-Reply-To: <009201c56280$e9b7cd00$0202a8c0@ATULSPC>
References: <20050526110425.27590eb8@dxpl.pdx.osdl.net>
	<20050526.144638.71091166.davem@davemloft.net>
	<20050526154857.3cb34d11@dxpl.pdx.osdl.net>
	<20050526.155401.18310361.davem@davemloft.net>
	<009201c56280$e9b7cd00$0202a8c0@ATULSPC>
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
To: Atul Sabharwal <iamatul@comcast.net>
Cc: netdev@oss.sgi.com, bridge@osdl.org, "David S. Miller" <davem@davemloft.net>

On Thu, 26 May 2005 22:57:05 -0700
"Atul Sabharwal" <iamatul@comcast.net> wrote:

> I have a question about using the 802.1d driver with a switch.  I have a 
> managed switch
> which connects to the Xscale MAC using a Reverse MII interface.
> 
> It seems that the 802.1d bridge puts the interface into promiscuous mode and 
> needs multiple
> ethernet devices to work with.  Can it work with a single ethernet device 
> which is connected
> to a BCM5338 ( broadcomm 8 port switch chip ).

Why? what would you gain?

> I understand that I would have to change the STP configuration component to 
> write to the
> broadcomm chip.

You would be better off writing a different driver, the amount of shared
logic would be less than the per hardware logic. 
