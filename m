Return-Path: <davem@davemloft.net>
Date: Fri, 01 Nov 2019 10:33:02 -0700 (PDT)
Message-Id: <20191101.103302.244767657227182634.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20191101124639.32140-1-nikolay@cumulusnetworks.com>
References: <20191101124639.32140-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 0/3] net: bridge: minor followup
 optimizations
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
Date: Fri,  1 Nov 2019 14:46:36 +0200

> After the converted flags to bitops we can take advantage of the flags
> assignment and remove one test and three atomic bitops from the learning
> paths (patch 01 and patch 02), patch 03 restores the unlikely() when taking
> over HW learned entries.
> 
> v2: a clean export of the latest set version

Series applied, thanks Nikolay.
