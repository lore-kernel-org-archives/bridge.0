Return-Path: <davem@davemloft.net>
Date: Sat, 15 Dec 2018 11:35:49 -0800 (PST)
Message-Id: <20181215.113549.1512874227634168486.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20181212230943.757-1-f.fainelli@gmail.com>
References: <20181212230943.757-1-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] Documentation: networking: Clarify
 switchdev devices behavior
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: f.fainelli@gmail.com
Cc: andrew@lunn.ch, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, vivien.didelot@gmail.com

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 12 Dec 2018 15:09:43 -0800

> This patch provides details on the expected behavior of switchdev
> enabled network devices when operating in a "stand alone" mode, as well
> as when being bridge members. This clarifies a number of things that
> recently came up during a bug fixing session on the b53 DSA switch
> driver.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Hi all,
> 
> Please review carefully, and let me know if you think some of the
> behaviors described below do not make any sense. Thanks!

Looks like Andrew had some feedback, so I'm expecting a new version
of this.
