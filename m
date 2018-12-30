Return-Path: <roopa@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=YFeNYt3qds9NtkkG7ighrWV+y/CcFKLntXdz8Bt7jaU=;
	b=TTLSZldCxljN2mHQdDXtLa4mQ8vhpr8dk+DRnjD9xKGeHqy2Izfup0BNn70Wd31DEb
	yjCJyemNW4sH5GPlVGp+MHbNxEsqCWqwsDh92zG+SHJwrhFtg5HQj3/gb4ik0KObpihY
	UGEXEtP2U/8U1DNe8NQU8W9zsgJFZaiJB+ZDY=
MIME-Version: 1.0
References: <663bc6d0-f6ec-796d-54bb-b9afa3c0bce1@cumulusnetworks.com>
	<20181230123320.32484-1-nikolay@cumulusnetworks.com>
In-Reply-To: <20181230123320.32484-1-nikolay@cumulusnetworks.com>
From: Roopa Prabhu <roopa@cumulusnetworks.com>
Date: Sun, 30 Dec 2018 11:10:33 -0800
Message-ID: <CAJieiUg4PO9WHeJByXz2FkZP51K2drxPLNtTEWFEDoUvnxwQGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH net] net: rtnetlink: address is mandatory for
	rtnl_fdb_get
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>, David Ahern <dsa@cumulusnetworks.com>

On Sun, Dec 30, 2018 at 4:33 AM Nikolay Aleksandrov
<nikolay@cumulusnetworks.com> wrote:
>
> We must have an address to lookup otherwise we'll derefence a null
> pointer in the ndo_fdb_get callbacks.
>
> CC: Roopa Prabhu <roopa@cumulusnetworks.com>
> CC: David Ahern <dsa@cumulusnetworks.com>
> Reported-by: syzbot+017b1f61c82a1c3e7efd@syzkaller.appspotmail.com
> Fixes: 5b2f94b27622 ("net: rtnetlink: support for fdb get")
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Acked-by: Roopa Prabhu <roopa@cumulusnetworks.com>

Thanks Nikolay!.



> ---
>  net/core/rtnetlink.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 48f61885fd6f..5ea1bed08ede 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -4104,6 +4104,11 @@ static int rtnl_fdb_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
>         if (err < 0)
>                 return err;
>
> +       if (!addr) {
> +               NL_SET_ERR_MSG(extack, "Missing lookup address for fdb get request");
> +               return -EINVAL;
> +       }
> +
>         if (brport_idx) {
>                 dev = __dev_get_by_index(net, brport_idx);
>                 if (!dev) {
> --
> 2.19.2
>
