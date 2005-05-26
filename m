Date: Thu, 26 May 2005 15:54:01 -0700 (PDT)
Message-Id: <20050526.155401.18310361.davem@davemloft.net>
Subject: Re: [Bridge] Re: [PATCH] (6/6) bridge: receive path optimization
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050526154857.3cb34d11@dxpl.pdx.osdl.net>
References: <20050526110425.27590eb8@dxpl.pdx.osdl.net>
	<20050526.144638.71091166.davem@davemloft.net>
	<20050526154857.3cb34d11@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: shemminger@osdl.org
Cc: netdev@oss.sgi.com, bridge@osdl.org

From: Stephen Hemminger <shemminger@osdl.org>
Date: Thu, 26 May 2005 15:48:57 -0700

> So the call chain is bounded (ie not related to number of filters)
> but slightly longer.

You're right, thanks for the explanation Stephen.
