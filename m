Return-Path: <andrew@lunn.ch>
Date: Thu, 2 Nov 2017 13:53:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20171102125305.GI4772@lunn.ch>
References: <20171102093648.4141-1-privat@egil-hjelmeland.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171102093648.4141-1-privat@egil-hjelmeland.no>
Subject: Re: [Bridge] [PATCH net-next] net: Define eth_stp_addr in
	linux/etherdevice.h
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Egil Hjelmeland <privat@egil-hjelmeland.no>
Cc: f.fainelli@gmail.com, vivien.didelot@savoirfairelinux.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, rafal@milecki.pl

On Thu, Nov 02, 2017 at 10:36:48AM +0100, Egil Hjelmeland wrote:
> Why:

Please drop the Why.

> The lan9303 driver defines eth_stp_addr as a synonym to
> eth_reserved_addr_base to get the STP ethernet address 01:80:c2:00:00:00.
> 
> eth_reserved_addr_base is also used to define the start of Bridge Reserved
> ethernet address range, which happen to be the STP address.
> 
> br_dev_setup refer to eth_reserved_addr_base as a definition of STP
> address.
> 
> Clean up by:
>  - Move the eth_stp_addr definition to linux/etherdevice.h
>  - Use eth_stp_addr instead of eth_reserved_addr_base in br_dev_setup.
> 
> Signed-off-by: Egil Hjelmeland <privat@egil-hjelmeland.no>

I was thinking along the same lines when reviewing your lan9303 patch.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
