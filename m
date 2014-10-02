Return-Path: <davem@davemloft.net>
Date: Wed, 01 Oct 2014 22:05:26 -0400 (EDT)
Message-Id: <20141001.220526.686849530279803994.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1412118799-17128-1-git-send-email-f.fainelli@gmail.com>
References: <1412118799-17128-1-git-send-email-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: add a br_set_state
 helper function
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: f.fainelli@gmail.com
Cc: stephen@networkplumber.org, netdev@vger.kernel.org, vyasevich@gmail.com, bridge@lists.linux-foundation.org, jiri@resnulli.us

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 30 Sep 2014 16:13:19 -0700

> In preparation for being able to propagate port states to e.g: notifiers
> or other kernel parts, do not manipulate the port state directly, but
> instead use a helper function which will allow us to do a bit more than
> just setting the state.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

This looks fine to me, applied, thanks Florian.
