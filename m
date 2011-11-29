Return-Path: <davem@davemloft.net>
Date: Tue, 29 Nov 2011 18:54:33 -0500 (EST)
Message-Id: <20111129.185433.1527626185550800872.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <201111251216.37466.vitas@nppfactor.kiev.ua>
References: <201111251216.37466.vitas@nppfactor.kiev.ua>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: master device stuck in no-carrier
 state forever when in user-stp mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: vitas@nppfactor.kiev.ua
Cc: netdev@vger.kernel.org, shemminger@vyatta.com, bridge@lists.linux-foundation.org

From: Vitalii Demianets <vitas@nppfactor.kiev.ua>
Date: Fri, 25 Nov 2011 12:16:37 +0200

> When in user-stp mode, bridge master do not follow state of its slaves, so 
> after the following sequence of events it can stuck forever in no-carrier 
> state:
> 1) turn stp off
> 2) put all slaves down - master device will follow their state and also go in 
> no-carrier state
> 3) turn stp on with bridge-stp script returning 0 (go to the user-stp mode)
> Now bridge master won't follow slaves' state and will never reach running 
> state.
> 
> This patch solves the problem by making user-stp and kernel-stp behavior 
> similar regarding master following slaves' states.
> 
> Signed-off-by: Vitalii Demianets <vitas@nppfactor.kiev.ua>

Stephen, please review this patch, thanks.
