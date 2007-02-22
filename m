Date: Thu, 22 Feb 2007 01:10:41 -0800 (PST)
Message-Id: <20070222.011041.40575191.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070221224255.686055172@linux-foundation.org>
References: <20070221224107.741532037@linux-foundation.org>
	<20070221224255.686055172@linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 2/4] bridge: eliminate workqueue for carrier
	check
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
Date: Wed, 21 Feb 2007 14:41:09 -0800

> Having a work queue for checking carrier leads to lots of race issues.
> Simpler to just get the cost when data structure is created and
> update on change.
> 
> Signed-off-by: StephenHemminger <shemminger@linux-foundtion.org>

Applied, I guess the signoff typo is in your file :-)
