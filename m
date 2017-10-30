Return-Path: <roopa@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=b+wTyhlnttK0E56d08wxXOalyY0ed6yXRwln1ysiQFI=;
	b=BwCme3RpfR46Jqctal/dvXyHImAZwACaSI62vE9BF/CG2SYS+GShcIH48Jz5yGxrp1
	+2sD/hgZglNLg6S04PK/II7upnYxX0y5EWAFvl4jgerKLpLJSDyzypbmJJ4hnm1qig9+
	Ddal3lu3W++tEiJVqle9Z6HJpn7oGWZyYX93A=
MIME-Version: 1.0
In-Reply-To: <1509360993-25227-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1509360993-25227-1-git-send-email-nikolay@cumulusnetworks.com>
From: Roopa Prabhu <roopa@cumulusnetworks.com>
Date: Mon, 30 Oct 2017 07:36:19 -0700
Message-ID: <CAJieiUg2uTXyHcREQRHz+cJdTNN0iZC4tnr9ym4rZhipLQdKpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH net-next] net: bridge: add neigh_suppress to
	bridge port policies
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, "davem@davemloft.net" <davem@davemloft.net>

On Mon, Oct 30, 2017 at 3:56 AM, Nikolay Aleksandrov
<nikolay@cumulusnetworks.com> wrote:
> Add an entry for IFLA_BRPORT_NEIGH_SUPPRESS to bridge port policies.
>
> Fixes: 821f1b21cabb ("bridge: add new BR_NEIGH_SUPPRESS port flag to suppress arp and nd flood")
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Acked-by: Roopa Prabhu <roopa@cumulusnetworks.com>

Thanks Nikolay.
