Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=AjpUQ/2FRJXBZ7fxRJf659LKsXh1dKwFUapYVqp0rok=;
	b=FB+q65wYzcmfuLLMy7uNqYvTT7QaJ06ARdE+EAkQs+MOLFQjEY6C8jyscfq048GosY
	dQu6997+u7NmgA/UWeQXIISNy9WcehOXWsVYnaUWcZeUNhGTSROzehrIknP+kAg58Jkw
	1asgdIz/oN6AE8CF8BfbgYIk/nIR3xzfjRRlrydJ9HSydQTTUYx8FsYIOc7AjWcT10aG
	WKxuu2wssmNJFmnM5+URidO1u4lxrjtkxWbU0Mg3rr1LLfWVg8ILsUXehCvczjPieVe4
	Dwvt1+5LRL7DYgZj95M9L1M+B12j5TCgQZZRBmry1w0v18i/+iWILETTF/7DAYTuD1+1
	0nuA==
Date: Wed, 6 Jul 2016 14:31:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20160706143118.2de2394c@samsung9>
In-Reply-To: <1467832341-5355-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1467832341-5355-1-git-send-email-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net-next] net: bridge: extend MLD/IGMP query
	stats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On Wed,  6 Jul 2016 12:12:21 -0700
Nikolay Aleksandrov <razor@blackwall.org> wrote:

> As was suggested this patch adds support for the different versions of MLD
> and IGMP query types. Since the user visible structure is still in net-ne=
xt
> we can augment it instead of adding netlink attributes.
> The distinction between the different IGMP/MLD query types is done as
> suggested in Section 7.1, RFC 3376 [1] and Section 8.1, RFC 3810 [2] based
> on query payload size and code for IGMP. Since all IGMP packets go through
> multicast_rcv() and it uses ip_mc_check_igmp/ipv6_mc_check_mld we can be
> sure that at least the ip/ipv6 header can be directly used.
>=20
> [1] https://tools.ietf.org/html/rfc3376#section-7
> [2] https://tools.ietf.org/html/rfc3810#section-8.1
>=20
> Suggested-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Looks good to me.
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
