Return-Path: <davem@davemloft.net>
Date: Fri, 03 Nov 2017 15:43:21 +0900 (KST)
Message-Id: <20171103.154321.558835036860502316.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1509690071-12585-2-git-send-email-allen.pais@oracle.com>
References: <1509690071-12585-1-git-send-email-allen.pais@oracle.com>
	<1509690071-12585-2-git-send-email-allen.pais@oracle.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 2/2] [net-next] net: bridge: Convert timers to
 use timer_setup()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: allen.pais@oracle.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, keescook@chromium.org

From: Allen Pais <allen.pais@oracle.com>
Date: Fri,  3 Nov 2017 11:51:11 +0530

> switch to using the new timer_setup() and from_timer() api's.
> 
> Signed-off-by: Allen Pais <allen.pais@oracle.com>

Applied.
