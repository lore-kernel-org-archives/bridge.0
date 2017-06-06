Return-Path: <roopa@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=4MGLw2b5/YhGyEzpW5N7gTz/nyEhQRkPZuWNh7G1njc=;
	b=ShxyPzozf/MDm1e8Se6dM3W29u53DfJjt8XrotRe9ELEMHWs5UW9c3bC21bLkIInbJ
	yog5fxp6bIn19qvGAzRP6gOBwacCIIJj3LXlfjg9nScXy2LuTLgSIreu/xqidgjfH+cR
	lgmSdsO3Ed3Oe+HU+GRt197x4wiL+C3j7+h4o=
MIME-Version: 1.0
In-Reply-To: <1496701584-26855-1-git-send-email-nikolay@cumulusnetworks.com>
References: <840022de-3d31-4f62-aaaf-ba83d5c78ad7@cumulusnetworks.com>
	<1496701584-26855-1-git-send-email-nikolay@cumulusnetworks.com>
From: Roopa Prabhu <roopa@cumulusnetworks.com>
Date: Mon, 5 Jun 2017 22:28:03 -0700
Message-ID: <CAJieiUhDEWhSw0QBLijiDp2ZkFuCGhuNvaAmBAfthtyPZ3bvTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH net] net: bridge: fix a null pointer
	dereference in br_afspec
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, garsilva@embeddedor.com, "davem@davemloft.net" <davem@davemloft.net>

On Mon, Jun 5, 2017 at 3:26 PM, Nikolay Aleksandrov
<nikolay@cumulusnetworks.com> wrote:
> We might call br_afspec() with p == NULL which is a valid use case if
> the action is on the bridge device itself, but the bridge tunnel code
> dereferences the p pointer without checking, so check if p is null
> first.
>
> Reported-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> Fixes: efa5356b0d97 ("bridge: per vlan dst_metadata netlink support")
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Acked-by: Roopa Prabhu <roopa@cumulusnetworks.com>

Thanks Nikolay.
