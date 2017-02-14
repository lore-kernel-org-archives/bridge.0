Return-Path: <davem@davemloft.net>
Date: Tue, 14 Feb 2017 12:41:25 -0500 (EST)
Message-Id: <20170214.124125.1924291870103930791.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1486994351-1137-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1486994351-1137-1-git-send-email-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/3] bridge: minor fdb cleanup
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Mon, 13 Feb 2017 14:59:08 +0100

> These patches aim to simplify the bridge fdb API a little by removing some
> redundant functions and converting them into wrappers of a single function.
> Also add proper lock checking to avoid future mistakes for the search
> functions.

This looks fine, series applied.

Thanks.
