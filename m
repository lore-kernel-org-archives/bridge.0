Date: Fri, 26 Feb 2010 10:08:00 -0800 (PST)
Message-Id: <20100226.100800.116618587.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100226100102.0d52c6e9@nehalam>
References: <20100226165104.GB5364@lenovo> <4B88076F.8030302@openvz.org>
	<20100226100102.0d52c6e9@nehalam>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC 0/5] bridge - introduce via_phys_dev feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@linux-foundation.org
Cc: gorcunov@gmail.com, netdev@vger.kernel.org, bridge@linux-foundation.org, den@openvz.org, xemul@openvz.org

From: Stephen Hemminger <shemminger@linux-foundation.org>
Date: Fri, 26 Feb 2010 10:01:02 -0800

> TCP connections are never really bound to device. TCP routing is
> flexible; if packets can get through, it doesn't care.

I think he might be talking about SO_BINDTODEVICE
