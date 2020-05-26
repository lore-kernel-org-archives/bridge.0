Return-Path: <davem@davemloft.net>
Date: Mon, 25 May 2020 18:10:08 -0700 (PDT)
Message-Id: <20200525.181008.578915373174688150.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200525095541.46673-1-horatiu.vultur@microchip.com>
References: <20200525095541.46673-1-horatiu.vultur@microchip.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: mrp: Fix out-of-bounds read in
	br_mrp_parse
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: horatiu.vultur@microchip.com
Cc: andrew@lunn.ch, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, syzbot+9c6f0f1f8e32223df9a4@syzkaller.appspotmail.com, kuba@kernel.org

From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Mon, 25 May 2020 09:55:41 +0000

> The issue was reported by syzbot. When the function br_mrp_parse was
> called with a valid net_bridge_port, the net_bridge was an invalid
> pointer. Therefore the check br->stp_enabled could pass/fail
> depending where it was pointing in memory.
> The fix consists of setting the net_bridge pointer if the port is a
> valid pointer.
> 
> Reported-by: syzbot+9c6f0f1f8e32223df9a4@syzkaller.appspotmail.com
> Fixes: 6536993371fa ("bridge: mrp: Integrate MRP into the bridge")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Applied to net-next, thanks.
