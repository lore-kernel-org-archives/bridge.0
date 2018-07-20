Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=wajQNGVdFInCf2c0A5oO3DN8oJdgm/jpPLCI9en0c+A=;
	b=FGcjP3prWIXB+sJfI9JtW9gxfmFJsLQ3/gyjWa69OqVMDkXAMZJWz0xoPZOory2cey
	kWvGwVAKvzsDaPkseRQcHHT2IBtt5kBhFT4LLtfpLTuupGl9bLz2QfhAtjNBeXWpKmgq
	jRtJXbrb2MR9/xqLAz7ELRXPe7zlwGwmoaOoW1IfLKtCd+DtzoItPkZ5d8nwjrdLNfTT
	VFFzi38h9QNHqB894QQRNnmWqkEJPoAnvkhC2OaTAJdPeBLkTOh41Wop/w8ZtBrvc7HG
	+Zvzw/VayELncxjz4+CsoNeyqdFbPrywb+8wRjnXh8wiRIHQJKx2/WuY5jVmUpXAoCqi
	w6PA==
Date: Fri, 20 Jul 2018 08:22:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20180720082222.2f8cb8d2@xeon-e3>
In-Reply-To: <20180720144826.29892-1-nikolay@cumulusnetworks.com>
References: <20180720144826.29892-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/2] net: bridge: add support for
	backup port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, wkok@cumulusnetworks.com, anuradhak@cumulusnetworks.com, davem@davemloft.net

On Fri, 20 Jul 2018 17:48:24 +0300
Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:

> Hi,
> This set introduces a new bridge port option that allows any port to have
> any other port (in the same bridge of course) as its backup and traffic
> will be forwarded to the backup port when the primary goes down. This is
> mainly used in MLAG and EVPN setups where we have peerlink path which is
> a backup of many (or even all) ports and is a participating bridge port
> itself. There's more detailed information in patch 02. Patch 01 just
> prepares the port sysfs code for options that take raw value. The main
> issues that this set solves are scalability and fallback latency.
> 
> We have used similar code for over 6 months now to bring the fallback
> latency of the backup peerlink down and avoid fdb notification storms.
> Also due to the nature of master devices such setup is currently not
> possible, and last but not least having tens of thousands of fdbs require
> thousands of calls to switch.
> 
> I've also CCed our MLAG experts that have been using similar option.
> 
> Thanks,
>  Nik
> 
> 
> Nikolay Aleksandrov (2):
>   net: bridge: add support for raw sysfs port options
>   net: bridge: add support for backup port
> 
>  include/uapi/linux/if_link.h |  1 +
>  net/bridge/br_forward.c      | 16 ++++++++-
>  net/bridge/br_if.c           | 53 ++++++++++++++++++++++++++++
>  net/bridge/br_netlink.c      | 30 +++++++++++++++-
>  net/bridge/br_private.h      |  3 ++
>  net/bridge/br_sysfs_if.c     | 82 ++++++++++++++++++++++++++++++++++++--------
>  6 files changed, 168 insertions(+), 17 deletions(-)
> 

Not sure why this has to be built into the bridge.
There already is bonding and teaming, why invent yet another?
