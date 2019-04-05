Return-Path: <davem@davemloft.net>
Date: Thu, 04 Apr 2019 17:54:24 -0700 (PDT)
Message-Id: <20190404.175424.2300798250459460775.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190403204418.3946-1-nikolay@cumulusnetworks.com>
References: <20190403204418.3946-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: mcast: remove unused
 br_ip_equal function
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
Date: Wed,  3 Apr 2019 23:44:18 +0300

> Since the mcast conversion to rhashtable this function has been unused, so
> remove it.
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Another reason to not use inline functions in foo.c files :-)

Applied, thanks Nikolay.
