Return-Path: <davem@davemloft.net>
Date: Wed, 02 Sep 2020 16:16:44 -0700 (PDT)
Message-Id: <20200902.161644.1325056661404881358.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <22c022da-4b1d-b0fe-b701-ce2163b3c3c0@cumulusnetworks.com>
References: <20200902.125846.1328960907241014780.davem@davemloft.net>
 <16ed8f8a-2040-5546-5cea-09a8a5b0bd7b@cumulusnetworks.com>
 <22c022da-4b1d-b0fe-b701-ce2163b3c3c0@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 00/15] net: bridge: mcast: initial
 IGMPv3 support (part 1)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed, 2 Sep 2020 23:17:46 +0300

> i. e. this doesn't exclude IPv6 or makes it worse for it, on the
> contrary the ops needed to
> implement MLDv2 state transitions are in this set, they just need to
> be extended for v6.
> The new br_ip src group field contains also a field for an IPv6
> address.

Great, then implement those parts and resubmit and we'll all be happy
:-)
