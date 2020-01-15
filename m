Return-Path: <davem@davemloft.net>
Date: Wed, 15 Jan 2020 04:51:15 -0800 (PST)
Message-Id: <20200115.045115.844354931575663015.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200114175614.17543-1-nikolay@cumulusnetworks.com>
References: <20200114175614.17543-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 0/8] net: bridge: add vlan
 notifications and rtm support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, dsahern@gmail.com, kuba@kernel.org

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue, 14 Jan 2020 19:56:06 +0200

> This patch-set is a prerequisite for adding per-vlan options support
> because we need to be able to send vlan-only notifications and do larger
> vlan netlink dumps. Per-vlan options are needed as we move the control
> more to vlans and would like to add per-vlan state (needed for per-vlan
> STP and EVPN), per-vlan multicast options and control, and I'm sure
> there would be many more per-vlan options coming.
 ...

Series applied, thanks Nikolay.
