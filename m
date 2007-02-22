Date: Thu, 22 Feb 2007 01:09:05 -0800 (PST)
Message-Id: <20070222.010905.57155690.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070221224255.581096490@linux-foundation.org>
References: <20070221224107.741532037@linux-foundation.org>
	<20070221224255.581096490@linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 1/4] bridge: get rid of miscdevice include
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: shemminger@linux-foundation.org
Cc: netdev@vger.kernel.org, bridge@linux-foundation.org

From: Stephen Hemminger <shemminger@linux-foundation.org>
Date: Wed, 21 Feb 2007 14:41:08 -0800

> The bridge hasn't used miscdevice for a long long time.

Applied, thanks Stephen.

> Signed-off-by: StephenHemminger <shemminger@linux-foundtion.org>
                      ^^^^                              ^^^^

You don't type these in by hand do you? :-)

Time to put your signoff into a text file and use the insert-from-file
feature of your favorite editor or similar :-)
