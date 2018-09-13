Return-Path: <davem@davemloft.net>
Date: Wed, 12 Sep 2018 20:30:31 -0700 (PDT)
Message-Id: <20180912.203031.102683412207287870.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180911063953.15008-1-nikolay@cumulusnetworks.com>
References: <20180910141802.268e85c5@shemminger-XPS-13-9360>
	<20180911063953.15008-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2] net: bridge: add support for
 sticky fdb entries
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
Date: Tue, 11 Sep 2018 09:39:53 +0300

> Add support for entries which are "sticky", i.e. will not change their port
> if they show up from a different one. A new ndm flag is introduced for that
> purpose - NTF_STICKY. We allow to set it only to non-local entries.
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> ---
> v2: As Stephen suggested pass the whole ndm_flags because it will probably
>     be used by someone else soon.

Applied, thanks Nikolay.
