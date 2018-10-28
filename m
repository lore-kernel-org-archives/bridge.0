Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Yb8/OM4Nskkb/6Uo3ZDW2aUqPY7FhppQb15V4e+q4GI=;
	b=2AQzNiJzmb/H/M4jJyKa7GKVTbjhmLnhgIGRPaCt7LY0MXZ7JMAgCQ7VS+0+NZ5z9s
	VZ9X+DOxvdrw+geFwXVdUfbOPl6Gp6xX9Fe61i+sgj5meZkpsoRroYXzVG+KxjFbdqT8
	kFjAjzEorq8ymxgDODb51kXuN3nmwfwh9j5eIWFbMX1wa+MP9X/MfWqyHfRKEkV4yjgh
	6n1npQBIY2A8FjKDj3xKTkoWOX+xqVKAo+jImkih+k/mfnU8zlg8P97JoogYjLnGQ4Eb
	BUELNlE38ySFQiVQBBZmTdL6zZlDsKt2xWriQjvVkAd14/Rv613MWPNi8uvSTv7kbgMo
	u7kg==
Date: Sun, 28 Oct 2018 08:20:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20181028082023.222fac71@xeon-e3>
In-Reply-To: <20181027090747.22104-1-nikolay@cumulusnetworks.com>
References: <90c5f2fe-1743-6b17-2e44-eba58cdbbb35@cumulusnetworks.com>
	<20181027090747.22104-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: remove ipv6 zero address
 check in mcast queries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, yinxu@redhat.com, liuhangbin@gmail.com, davem@davemloft.net

On Sat, 27 Oct 2018 12:07:47 +0300
Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:

> Recently a check was added which prevents marking of routers with zero
> source address, but for IPv6 that cannot happen as the relevant RFCs
> actually forbid such packets:
> RFC 2710 (MLDv1):
> "To be valid, the Query message MUST
>  come from a link-local IPv6 Source Address, be at least 24 octets
>  long, and have a correct MLD checksum."
> 
> Same goes for RFC 3810.
> 
> And also it can be seen as a requirement in ipv6_mc_check_mld_query()
> which is used by the bridge to validate the message before processing
> it. Thus any queries with :: source address won't be processed anyway.
> So just remove the check for zero IPv6 source address from the query
> processing function.
> 
> Fixes: 5a2de63fd1a5 ("bridge: do not add port to router list when receives query with source 0.0.0.0")
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

What about a broken/malicious sender? Could an all zero source be used
to poison the multicast table?
