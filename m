Return-Path: <davem@davemloft.net>
Date: Tue, 05 May 2015 19:21:17 -0400 (EDT)
Message-Id: <20150505.192117.1979417987836600141.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1430772433-16384-1-git-send-email-bernhard.thaler@wvnet.at>
References: <20150401155001.40d58a37@urahara>
	<1430772433-16384-1-git-send-email-bernhard.thaler@wvnet.at>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCHv2] bridge: change BR_GROUPFWD_RESTRICTED to
 allow forwarding of LLDP frames
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bernhard.thaler@wvnet.at
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

From: Bernhard Thaler <bernhard.thaler@wvnet.at>
Date: Mon,  4 May 2015 22:47:13 +0200

> BR_GROUPFWD_RESTRICTED bitmask restricts users from setting values to
> /sys/class/net/brX/bridge/group_fwd_mask that allow forwarding of
> some IEEE 802.1D Table 7-10 Reserved addresses:
> 
> 	(MAC Control) 802.3		01-80-C2-00-00-01
> 	(Link Aggregation) 802.3	01-80-C2-00-00-02
> 	802.1AB LLDP			01-80-C2-00-00-0E
> 
> Change BR_GROUPFWD_RESTRICTED to allow to forward LLDP frames and document
> group_fwd_mask.
> 
> e.g.
>    echo 16384 > /sys/class/net/brX/bridge/group_fwd_mask
> allows to forward LLDP frames.
> 
> This may be needed for bridge setups used for network troubleshooting or
> any other scenario where forwarding of LLDP frames is desired (e.g. bridge
> connecting a virtual machine to real switch transmitting LLDP frames that
> virtual machine needs to receive).
> 
> Tested on a simple bridge setup with two interfaces and host transmitting
> LLDP frames on one side of this bridge (used lldpd). Setting group_fwd_mask
> as described above lets LLDP frames traverse bridge.
> 
> Signed-off-by: Bernhard Thaler <bernhard.thaler@wvnet.at>

Applied, thanks.
