Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=eTfgNMrHEKzNLPnjPqRrECZOQgTNZMlFdHVjuqHHQqA=;
	b=vNKien9DRf2q78jddbf0o6GsS1qa20ei3UMhh5oT3DEfBgFSwY2xigi4vkqZp1sC6X
	R5xkyrcKeBw8zSJCIoLNzm45fGZQREf7Kgn0Ob1TR2SckO8KxLEWn16Z8Ug5kq7PkOQk
	LIvJW3h+sbp2CmuId8oYwpEaWbmIPbToBksP5G6BLVMLdcS7hQqEl3aWQ6xMaW3EPlGW
	Ozg8Q4jeTxVzgHORXkufvtHnOYK2+x6YIH8JxqBt9movQIzd5tvjFTgMSulqE60uwp4X
	Btnu3FzngUc6Uz8JVZWYuyuz7jmlF3CvbJOVVbfwdJuzlWMqTfmuiTP4NqTP+RhxPl+A
	uYKw==
Date: Fri, 12 Oct 2018 08:39:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20181012083932.1753c93e@xeon-e3>
In-Reply-To: <20181012104116.12751-1-nikolay@cumulusnetworks.com>
References: <20181012104116.12751-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: add support for per-port
 vlan stats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, davem@davemloft.net

On Fri, 12 Oct 2018 13:41:16 +0300
Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:

> This patch adds an option to have per-port vlan stats instead of the
> default global stats. The option can be set only when there are no port
> vlans in the bridge since we need to allocate the stats if it is set
> when vlans are being added to ports (and respectively free them
> when being deleted). Also bump RTNL_MAX_TYPE as the bridge is the
> largest user of options. The current stats design allows us to add
> these without any changes to the fast-path, it all comes down to
> the per-vlan stats pointer which, if this option is enabled, will
> be allocated for each port vlan instead of using the global bridge-wide
> one.
> 
> CC: bridge@lists.linux-foundation.org
> CC: Roopa Prabhu <roopa@cumulusnetworks.com>
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Yes, per-vlan stats could be quite useful.
Most cases of statistics in the kernel are always on, and some API's
get them (and skip others).  Other than the additional memory overhead, why
not make the statistics as always on.

Also, is there any chance of creating too much data in a netlink
message if there are 4K-1 VLAN's?

