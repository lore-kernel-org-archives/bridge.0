Return-Path: <davem@davemloft.net>
Date: Fri, 03 Nov 2017 14:18:39 +0900 (KST)
Message-Id: <20171103.141839.1785916247470411683.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20171102093648.4141-1-privat@egil-hjelmeland.no>
References: <20171102093648.4141-1-privat@egil-hjelmeland.no>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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
To: privat@egil-hjelmeland.no
Cc: andrew@lunn.ch, f.fainelli@gmail.com, vivien.didelot@savoirfairelinux.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, rafal@milecki.pl

From: Egil Hjelmeland <privat@egil-hjelmeland.no>
Date: Thu,  2 Nov 2017 10:36:48 +0100

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

Applied, thank you.
