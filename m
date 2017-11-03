Return-Path: <davem@davemloft.net>
Date: Fri, 03 Nov 2017 14:14:28 +0900 (KST)
Message-Id: <20171103.141428.1029481368155846689.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1509600531-16086-1-git-send-email-allen.pais@oracle.com>
References: <1509600531-16086-1-git-send-email-allen.pais@oracle.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 1/2] net: bridge: Convert timers to use
	timer_setup()
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
Date: Thu,  2 Nov 2017 10:58:50 +0530

> switch to using the new timer_setup() and from_timer() api's.
> 
> Signed-off-by: Allen Pais <allen.pais@oracle.com>

These two patches do not apply cleanly to net-next, please respin.
